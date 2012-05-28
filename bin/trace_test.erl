-module(trace_test).

-compile(export_all).

r() ->
    P1 = spawn(?MODULE,p,[]),
    P2 = spawn(?MODULE,p,[]),
    %% P1 = open_port(),
    %% P2 = open_port(),
    Q1 = spawn(?MODULE,q,[]),
    Q2 = spawn(?MODULE,q,[]),
    io:format("processes spawned\n"),
    wait(),
    erlang:trace(Q1,true,[{tracer,P1},'receive']),
    wait(),
    Q1 ! foo,
    wait(),
    Q1 ! foo,
    wait(),
    io:format("msg sent\n"),
    erlang:trace(Q2,true,[{tracer,P2},'receive']),
    wait(),
    Q1 ! foo,
    wait(),
    Q2 ! foo,
    wait(),
    wait(),
    Q1 ! foo,
    wait(),
    Q2 ! foo,
    wait(),
    P1 ! stop,
    P2 ! stop,
    Q1 ! stop,
    Q2 ! stop.
    

    
wait() ->
    receive
	after 1000 ->
		ok
    end.


p() ->
    receive
	stop ->
	    ok;
	Msg ->
	    io:format("~p  ~p\n",[self(),Msg]),
	    p()
    end.

q() ->
    receive
	stop ->
	    ok;
	_ ->
	    q()
    end.
