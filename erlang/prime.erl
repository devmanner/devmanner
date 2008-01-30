-module(prime).
-export([primes/1]).

range(L, U) when L > U -> [];
range(L, U) -> [L|range(L+1, U)].

remove_multiples([], _) -> [];
remove_multiples([H|Tail], N) when H rem N == 0 ->
	remove_multiples(Tail, N);
remove_multiples([H|Tail], N) ->
	[H|remove_multiples(Tail, N)].

sieve([]) -> [];
sieve([H|T]) -> [H|sieve(remove_multiples(T, H))].

primes(Max) -> sieve(range(2, Max)).