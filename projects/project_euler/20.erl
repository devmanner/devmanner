-module('20').

-compile(export_all).

fac(1) ->
    1;
fac(N) ->
    N * fac(N-1).

solve() ->
    '16':number_sum(fac(100)).
