-module(matrix).
-compile(export_all).

new(R, C) ->
	new(R, C, 0).
new(R, C, V) ->
	{R, C, lists:map(fun(_) -> V end, lists:seq(1, R*C))}.

from_list(R, C, L) when is_list(L) ->
	{R, C, L}.

index({_Rows, Cols, _M}, R, C) ->
	R*Cols+C.

value({Rows, Cols, M}, R, C) ->
	lists:nth(1 + index({Rows, Cols, M}, R, C), M).

set({Rows, Cols, M}, R, C, V) ->
	Index = index({Rows, Cols, M}, R, C),
	{Rows, Cols, lists:sublist(M, Index) ++ [V] ++ lists:nthtail(Index+1, M)}.

print(Matrix={Rows, Cols, _M}) ->
	lists:foreach(fun(R) ->
		lists:foreach(fun(C) -> io:format("~p ", [value(Matrix, R, C)])end, lists:seq(0, Cols-1)),
		io:format("~n")
	end, lists:seq(0, Rows-1)).

test() ->
	M = new(2,2),
	0 = value(M, 0, 0),
	0 = value(M, 1, 1),
	M2 = set(M, 1, 1, 1),
	1 = value(M2, 1, 1),
    M3 = set(M, 0, 0, 1),
	1 = value(M3, 0, 0),
	1 = value(from_list(1, 1, [1]), 0, 0),
	ok.

