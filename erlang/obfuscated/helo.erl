-module(helo).
-compile(export_all).

doit() ->
    register(main, self()),
    spawn(fun() -> print(h, e) end),
    spawn(fun() -> print(e, l) end),
    spawn(fun() -> print(l, o) end),
    spawn(fun() -> print(o, main) end),
    timer:sleep(10),
    h ! go,
    receive
	go ->
	    unregister(main),
	    io:format("~n")
    end.

print(X, Next) ->
    register(X, self()),
    receive
	go ->
	    io:format("~p", [X]),
	    Next ! go
    end.
