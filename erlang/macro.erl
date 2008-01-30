-module(macro).

-define(CHECK(Func), ?DO_CHECK(Func, ?MODULE, ?LINE)).

-define(DO_CHECK(Func, Module, Line), check_fun(Func, ??Func, Module, Line)).

check_fun(ok, _, _, _) ->
    ok;
check_fun(Ret, Func, CallingModule, CallingLine) ->
    io:format("(~p:~p)\t~s -> ~p~n", [CallingModule, CallingLine, Func, Ret]),
    Ret.

-compile(export_all).

foo() ->
    ok.

bar() ->
    {nok, "Some error"}.

baz(X) ->
    {nok, X}.

main() ->
    ?CHECK(foo()),
    ?CHECK(bar()),
    A = 10,
    ?CHECK(baz(A)).
