-module(plists).
-export([map/2]).

map(Fun, List) ->
    Pids = spawn_workers(self(), Fun, List),
    collect_answers(Pids).

spawn_workers(_Parent, _Fun, []) ->
    [];
spawn_workers(Parent, Fun, [Head|Tail]) ->
    Pid = spawn(fun() -> Parent ! {self(), Fun(Head)} end),
    [Pid | spawn_workers(Parent, Fun, Tail)].

collect_answers([]) ->
    [];
collect_answers([Pid|Pids]) ->
    receive
	{Pid, Result} ->
	    [Result | collect_answers(Pids)]
    end.
