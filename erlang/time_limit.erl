-module(time_limit).
-compile(export_all).

my_fun(0) ->
    io:format("Dead!!!~n");
my_fun(N) ->
    timer:sleep(1000),
    io:format("Alive: ~p~n", [N]),
    my_fun(N-1).

tle(Fun, TimeMS) ->
    Pid = spawn_link(Fun),
    {ok, TRef} = timer:exit_after(TimeMS, Pid, timeout),
    process_flag(trap_exit, true),
    RetVal = receive
		 {'EXIT', Pid, timeout} ->
		     {nok, timeout};
		 {'EXIT', Pid, normal} ->
		     ok;
		 Rest ->
		     io:format("This probably crashed: ~p", [Rest]),
		     {nok, Rest}
	     end,
    {ok, cancel} = timer:cancel(TRef),
    RetVal.


