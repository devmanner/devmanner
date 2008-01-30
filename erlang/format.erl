-module(format).
-compile(export_all).

test() ->
    io:format("~.5.0w~n", [1]),
    io:format("~.5w~n", [1]).

