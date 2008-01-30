-module(wait4bg).

-compile(export_all).

wait4(What) ->
    wait4(What, []).

wait4([], []) -> ok;
wait4([], Acc) -> {ok, Acc};
wait4([{Mod, Func, Arg}|T], Acc) ->
    case wait4(Mod, Func, Arg, 0) of
	{ok, R} -> wait4(T, Acc ++ [R]);
	ok      -> wait4(T, Acc);
	_       -> nok
    end.

%% Waited for MAX_WAIT4_TIME seconds.
wait4(_, _, _, ?MAX_WAIT4_TIME) ->
    nok;
wait4(Mod, Func, Arg, TotalTime) ->
    case catch erlang:apply(Mod, Func, Arg) of
	ok      -> ok;
	{ok, R} -> {ok, R};
	_       -> timer:sleep(1000),
	     wait4(Mod, Func, Arg, TotalTime+1)
    end.



func() ->
    ok.

wait4bg(What, Name) ->
    erlang:register(Name, spawn(?MODULE, wait4, [What])),
    ok.

check(Name) ->
    case lists:member(Name, erlang:registered()) of
	false ->
	    ok;
	true ->
	    erlang:exit(Name, kill),
	    nok
    end.
