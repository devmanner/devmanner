-module(default_arg).
-compile(export_all).
-compile({parse_transform, transform_default_arg}).

bar(X) ->
    foo([], X).

foo(Bar=default([]), X) ->
    io:format("foo(~p, ~p)~n", [Bar, X]),
    ok.

kalle(X=default(1),Y,Z=default("hello")) ->
    io:format("kalle(~p,~p,~p)~n", [X,Y,Z]).

test() ->
    foo(1),
    kalle(99,"non default",other_atom),
    kalle(99,"non default","nisse"),
    kalle("hej"),

    %% This will not work
    %%kalle("non default",other_atom),

    ok.

