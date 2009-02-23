-module(plists).
-compile(export_all).

map(Fun, List) ->
    Parent = self(),
    [receive {Pid, Result} -> Result end
     || Pid <- [spawn(fun() -> Parent ! {self(), Fun(X)} end) || X <- List]].

test() ->
    Funs = [
	    {fun(X) -> math:pow(X, X) end, fun() -> lists:seq(1,100) end},
	    {fun(X) -> is_prime(X) end, fun() -> lists:seq(10000,10100) end}
	   ],
    lists:foreach(fun ({MapFun, DataFun}) ->
			  {Map, Pmap} = test(1000, MapFun, DataFun),
			  io:format("map: ~p~npmap: ~p~n", [Map, Pmap])
		  end, Funs).

test(N, MapFun, DataFun) ->
    test(N, MapFun, DataFun, [], []).

test(0, _MapFun, _DataFun, Map, Pmap) ->
    {{map, mean(Map)}, {pmap, mean(Pmap)}};
test(N, MapFun, DataFun, Map, Pmap) ->
    List = DataFun(),
    {MapTime, MapResult} = timer:tc(lists, map, [MapFun, List]),
    {PmapTime, PmapResult} = timer:tc(?MODULE, map, [MapFun, List]),
    MapResult = PmapResult,
    test(N-1, MapFun, DataFun, [MapTime|Map], [PmapTime|Pmap]).

mean(L) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, L) / length(L).
			
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%% is_prime test function

is_prime(X) when X < 10 -> 
    (X == 2) or (X == 3) or (X == 5) or (X == 7);
is_prime(D) ->
    case D rem 3 of
	0 -> false;
	_ ->
	    new_seed(),
	    is_prime(D, 100)
    end.
is_prime(D, Ntests) ->
    N = length(integer_to_list(D)) - 1,
    is_prime(Ntests, D, N).
is_prime(0, _, _) -> true;
is_prime(Ntest, N, Len) ->
    K = random:uniform(Len),
    %% A is a random number less than N 
    A = make_random(K),
    if A < N ->
	    case pow(A,N,N) of
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

pow(A, 1, M) ->
    A rem M;
pow(A, 2, M) ->
    A*A rem M;
pow(A, B, M) ->
    B1 = B div 2,
    B2 = B - B1,
    %% B2 = B1 or B1+1
    P = pow(A, B1, M),
    case B2 of
	B1 -> (P*P) rem M;
	_  -> (P*P*A) rem M
    end.

make_random(N) -> new_seed(), make_random(N, 0).
make_random(0, D) -> D;
make_random(N, D) ->
    make_random(N-1, D*10 + (random:uniform(10)-1)).
