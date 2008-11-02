-module('16').
-compile(export_all).

number_sum(X) ->
    number_sum(X, 0).
number_sum(0, Acc) ->
    Acc;
number_sum(X, Acc) ->
    number_sum(X div 10, Acc + (X rem 10)).

solve() ->
    number_sum(round(math:pow(2,1000))).
