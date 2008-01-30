-module(foreach).

-compile(export_all).

print(X) ->
    io:format("~p~n", [X]).

test() ->
    L = [foo, bar, baz, rab],
    lists:foreach(fun(X) -> print(X) end, L).
