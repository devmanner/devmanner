-module(prime).
-export([is_prime/1]).
-export([produce/1]).

%% Produce a list of primes from 2 to To.
produce(To) ->
    produce(3, To, [2]).
produce(From, To, Acc) when From > To ->
    Acc;
produce(Num, To, Primes) ->
    R = lists:foldl(fun(_,false) ->
			    false;
		       (Prime, true) ->
			    (Num rem Prime) =/= 0
		    end, true, Primes),
    case R of
	true -> produce(Num+2, To, Primes ++ [Num]);
	false -> produce(Num+2, To, Primes)
    end.
	    
%% By Joe Armstrong

is_prime(2) -> true;
is_prime(3) -> true;
is_prime(5) -> true;
is_prime(7) -> true;
is_prime(X) when X < 10 -> false;
is_prime(D) ->
    new_seed(),
    is_prime(D, 100).

is_prime(D, Ntests) ->
    N = length(integer_to_list(D)) -1,
    is_prime(Ntests, D, N).

is_prime(0, _, _) -> true;
is_prime(Ntest, N, Len) ->
    K = random:uniform(Len),
    %% A is a random number less than N 
    A = make(K),
    if 
	A < N ->
	    case lin:pow(A,N,N) of
		A -> is_prime(Ntest-1,N,Len);
		_ -> false
	    end;
	true ->
	    is_prime(Ntest, N, Len)
    end.

new_seed() ->
    {_,_,X} = erlang:now(),
    {H,M,S} = time(),
    H1 = H * X rem 32767,
    M1 = M * X rem 32767,
    S1 = S * X rem 32767,
    put(random_seed, {H1,M1,S1}).

make(N) -> new_seed(), make(N, 0).
make(0, D) -> D;
make(N, D) ->
    make(N-1, D*10 + (random:uniform(10)-1)).
