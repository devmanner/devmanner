-module(dbg).

-define(ML, {process_info(self(), current_function), ?LINE}).

-compile(export_all).

dbg({{current_function, {Module, Function, Arity}}, Line}, S) ->
    io:format("[~p:~p/~p] ~p ~s~n", [Module, Function, Arity, Line, S]).

test() ->
    dbg(?ML, "Foobar").
