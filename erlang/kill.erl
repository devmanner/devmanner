-module(kill).

-compile(export_all).

main() ->
    spawn_link(fun() -> test() end),
    loop(main).

loop(Who) ->
    io:format("~p~n", [Who]),
    timer:sleep(1000),
    loop(Who).

test() ->
    Self = self(),
    spawn(fun() -> child(Self) end),
    loop(parent).

child(Parent) ->
    timer:sleep(2000),
    io:format("Killing parent~n"),
    exit(Parent, killed_by_child),
    loop(child).
