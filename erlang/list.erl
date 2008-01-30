-module(list).
%%-export([find/2, append/2, reverse/1, delete_all/2, sort/1, qsort/1, nth_element/2, equals/2]).
-compile(export_all).

%% find(L, X), returns true if X is found in L
find([X|_], X) -> true;
find([_|T], X) -> find(X, T);
find([], _) -> false.

%% append(L1, L2), append L2 to L1
append([H|T], L) -> [H|append(T, L)];
append([], L) -> L.

%% reverse(L), return L reversed.
reverse(L) -> reverse(L, []).
reverse([H|T], Acc) -> reverse(T, [H|Acc]);
reverse([], Acc) -> Acc.

%% delete_all(L, X), delete all X from L
delete_all([X|T], X) -> delete_all(T, X);
delete_all([H|T], X) -> [H|delete_all(T, X)];
delete_all([], _) -> [].

%% split(Pivot, L, Smaller, Bigger), puts all elements smaller then Pivot to
%% the left and all bigger to the right.
split(L, Pivot) -> split(L, Pivot, [], []).
split([], _, Smaller, Bigger) ->
	{Smaller, Bigger};
split([H|T], Pivot, Smaller, Bigger) when H < Pivot ->
	split(T, Pivot, [H|Smaller], Bigger);
split([H|T], Pivot, Smaller, Bigger) when H >= Pivot ->
	split(T, Pivot, Smaller, [H|Bigger]).

%% sort(L), sort the list L
sort([]) -> [];
sort([Pivot|Rest]) -> 
	{Smaller, Bigger} = split(Rest, Pivot),
	list:append(sort(Smaller), [Pivot|sort(Bigger)]).

%% qsort(L), quick-sort the list L.
qsort(L) -> qsort(L, []).
qsort([Pivot|Rest], Tail) ->
	{Smaller, Bigger} = split(Rest, Pivot),
	qsort(Smaller, [Pivot|qsort(Bigger, Tail)]);
qsort([], Tail) -> Tail.

%% Get the n:th element.
nth_element([H|_], 0) -> H;
nth_element([_|Tail], N) -> nth_element(Tail, N-1).

%% equals(L1, L2) return true if L1 == L2
equals([], []) -> true;
equals([H|T1], [H|T2]) -> equals(T1, T2);
equals(_, _) -> false.
