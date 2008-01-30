-module(segfault).
-author(qtomama).

-export([main/0]).

generate(From, To) ->
    generate(From, To, fun(X) -> X+1 end).
generate(From, To, _) when From > To ->
    [];
generate(From, To, F) ->
    [From] ++ generate(F(From), To, F).

main() ->
    generate(1 bsl 1, 1 bsl (1 bsl 64), fun(X) -> X bsl 1 end).
%%    lists:filter(fun(X) -> X =/= ok end, lists:map(fun(X) -> selectChannels(WhichANT, X), F() end, generate(1 bsl FromChannel, 1 bsl ToChannel, fun(X) -> X bsl 1 end))).
