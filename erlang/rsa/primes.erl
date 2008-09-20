-module(primes).
-export([make_prime/1, make/1]).


     
make_prime(K) when K > 0 ->
    new_seed(),
    N = make(K),
    if N > 3 ->
	    io:format("Generating a ~w digit prime ",[K]),
	    MaxTries = N - 3,
	    P1 = make_prime(MaxTries, N+1),
	    io:format("~n",[]),
	    P1;
       true ->
	    make_prime(K)
    end.

make_prime(0, _) ->
    exit(impossible);
make_prime(K, P) ->
    io:format(".",[]),
    case is_prime(P) of
	true  -> P;
	false -> make_prime(K-1, P+1)
    end.

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
