-module(algo).
-export([foo/1]).

foo(N) -> 1.

%%-export([find/2]). %% , append/2, reverse/1, delete_all/2]).

%% find(L, X), returns true if X is found in L
%%find([X|_], X) -> true;
%%find([_|T], X) -> find(X, T);
%%find([], X) -> false.

%% append(L1, L2), append L2 to L1
%%append([H|T], L) -> [H|append(T, L)];
%%append([], L) -> L.

%% reverse(L), return L reversed.
%%reverse(L) -> reverse(L, []).
%%reverse([H|T], Acc) -> reverse(T, [H|Acc]);
%%reverse([], Acc) -> Acc.

%% delete_all(L, X), delete all X from L
%%delete_all([X|T], X) -> delete_all(T, X);
%%delete_all([H|T], X) -> [H|delete_all(T, X)];
%%delete_all([], X) -> [].

%% split(Pivot, L, Smaller, Bigger), puts all elements smaller then Pivot to
%% the left and all bigger to the right.
%%split(L, Pivot) -> split(L, Pivot, [], []).
%%split([], Pivot, Smaller, Bigger) ->
%%	{Smaller, Bigger};
%%split([H|T], Pivot, Smaller, Bigger) where H < Pivot ->
%%	split(T, Pivot, [H|Smaller], Bigger);
%%split(Pivot, [H|T], Smaller, Bigger) where H >= Pivot -> %% Implicit where.
%%	split(T, Pivot, Smaller, [H|Bigger]).

%% sort(L), Sort list L.
%%sort([]) -> [];
%%sort([Pivot|Rest])