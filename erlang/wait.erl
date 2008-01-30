-module(wait).
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

%% Waited for 10 minutes.
wait4(_, _, _, 10) ->
    nok;
wait4(Mod, Func, Arg, TotalTime) ->
    case catch erlang:apply(Mod, Func, Arg) of
	ok      -> ok;
	{ok, R} -> {ok, R};
	_       -> sleep(1000),
		   wait4(Mod, Func, Arg, TotalTime+1)
    end.

wait4par(List) ->
    getWait4parAnswers(spawnWait4par(List, 0)).

spawnWait4par([], N) ->
    N;
spawnWait4par([H|T], N) ->
    spawn(?MODULE, doWait4par, [self(), H]),
    spawnWait4par(T, N+1).

doWait4par(Parent, A) ->
    Ret = wait4([A]),
    Parent ! Ret.

getWait4parAnswers(N) ->
    getWait4parAnswers(N, []).

getWait4parAnswers(0, []) ->
    ok;
getWait4parAnswers(0, Acc) ->
    {ok, Acc};
getWait4parAnswers(N, Acc) ->
    receive
	{ok, R} -> getWait4parAnswers(N-1, Acc ++ [R]);
	ok      -> getWait4parAnswers(N-1, Acc);
	_       -> getWait4parAnswers(N-1, Acc),
		   nok
    end.

sleep(Time) ->
    receive
	after Time -> ok
	end.

f() ->
    throw({error, "my reason"}).

ping(Node) ->
    case net_adm:ping(Node) of
	pong -> ok;
	pang -> nok
    end.
    
