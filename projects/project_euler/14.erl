-module('14').
-compile(export_all).


seq(N) ->
    seq(N, []).
seq(1, Acc) ->
    [1|Acc];
seq(N, Acc) ->
    case N band 1 of
	1 -> %% Odd
	    seq(3*N+1, [N|Acc]);
	0 -> %% Even
	    seq(N div 2, [N|Acc])
    end.

len(N) ->
    length(seq(N)).

solve() ->
    lists:max(lists:map(fun(X) -> {len(X), {num, X}} end, lists:seq(1, 1000000))).
