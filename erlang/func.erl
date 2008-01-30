-module(func).
-compile(export_all).


test() ->
    func(fun(X) -> io:format("item: ~p~n", [X]) end, [1, 2, 3, 4]),
    Y = 1,
    func(fun(X) -> io:format("item: ~p ~p~n", [X, Y]) end, [1, 2, 3, 4]).

func(_, []) ->
    ok;
func(F, [H|T]) ->
    F(H),
    func(F, T).

