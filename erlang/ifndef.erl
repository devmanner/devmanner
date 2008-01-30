-module(ifndef).
-compile(export_all).

-define(M, "kalle").

-ifdef(M).

foo() ->
    io:format("M defined~n").

-else.

foo() ->
    io:format("M not defined~n").

-endif.
