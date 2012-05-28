-module(ping).

-export([start/0, send/1, loop/0]).

start() ->
    spawn_link(ping, loop, []).

send(Pid) ->
    Pid ! {self(), ping},
    receive
	pong -> pong
    end.

loop() ->
    receive
	{Pid, ping} ->
	    spawn(crash, do_not_exist, []), Pid ! pong,
	    loop()
    end.



%% erlang:trace(new,true, ['receive']).
%% Pid = ping:start().
%% Pid ! foo.
%% flush().
%% trace:trace_filter(all, [{['trace', '$1', 'receive', '$2'], [{'not', {'orelse', {'=:=', '$2', timeout}, {'andalso', {is_tuple, '$2'}, {'==', io_reply, {element, 1, '$2'}}}}}], [{message, true}]}])
%% Pid !bar.
%% Pid2 = ping:start().
%% Pid2 ! abc.
%% flush.
