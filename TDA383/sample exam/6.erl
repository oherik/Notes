-module(bbuffer).
-export([start/1, get/1, put/2, unload/1, release/1]).

-record(buffer, {free, elementList=[]}).

start(Size) ->
spawn(fun-> prio_handle(#buffer{free = Size}) end).

prio_handle(Buf)
	receive	
		{unload, OriginPid, OriginRef} ->
			unload_handle(Buf, OriginPid, OriginRef)
	after 0 ->
		handle(Buf)
	end.

unload_handle(Buf, OriginPid, OriginRef) when Buf#buffer.elementList /= []  ->
	receive
		{get, Ref, Return} ->
			[First|Tail] = Buf#buffer.elementList,
			Return ! {get_rep, Ref, First},
			unload_handle(Buf#buffer{Buf#buffer.free+1, Tail}, OriginPid, OriginRef)
	end;

unload_handle(Buf, OriginPid, OriginRef) when Buf#buffer.elementList == []  ->
	receive
		{release, Buf, Pid, Ref} ->
			Pid ! {release_rep, Ref},
			prio_handle(Buf)
	end.


handle(Buf) ->
	receive
		{get, Ref, Return} when Buf#buffer.elementList /= [] ->
			[First|Tail] = Buf#buffer.elementList,
			Return ! {get_rep, Ref, First},
			prio_handle(Buf#buffer{Buf#buffer.free+1, Tail});
		{put, Ref, Return, X} when free > 0 ->
			Return ! {put_rep, Ref},
			prio_handle(Buf#buffer{Buf#buffer.free-1, Tail++[X]});
		{unload, Ref, Return} ->
			unload_handle(Buf)
		end.

get(Serv) ->
	Ref = make_ref(),
	Serv ! {get, Ref, self()},
	receive 
		{get_rep, Ref, First} ->
			First
	end.

put(Serv, X) ->
	Ref = make_ref(),
	Serv ! {put, Ref, self(), X},
	receive 
		{put_rep, Ref} ->
			ok
	end.

unload(Serv) ->
	Ref = make_ref(),
	Serv ! {unload, Ref, self()},
	receive
		{unload_rep, Ref} ->
			ok
	end.

release(Serv) ->
	Ref = make_ref(),
	Serv ! {release, Ref, self()},
	receive
		{release_rep, Ref} ->
			ok
	end.
