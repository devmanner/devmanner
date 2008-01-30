-module(set).
-export([new/0, add_element/2, del_element/2, is_element/2, is_empty/1, union/2, intersection/2]).

new() -> [].

add_element(S, E) ->
    case is_element(S, E) of
	true -> S;
	false -> [E|S]
    end.

del_element([E|Tail], E) -> Tail;
del_element([H|Tail], E) -> [H|del_element(Tail, E)];
del_element([], _) -> [].

is_element([E|_], E) -> true;
is_element([_|S], E) -> is_element(S, E);
is_element([], E) -> false.

is_empty([]) -> true;
is_empty(_) -> false.

union(S, []) -> S;
union([], S) -> S;
union(S, [H|Tail]) -> union(Tail, add_element(S, H)).

intersection([], S) -> [];
intersection(S, []) -> [];
intersection([H|Tail], S) ->
    case is_element(S, H) of
	true -> [H|intersection(Tail, S)];
	false -> intersection(Tail, S)
    end.
