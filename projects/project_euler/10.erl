-module('10').

-compile(export_all).

sum(Start, Stop) when Start < 3 ->
    sum(Start, Stop, 2);
sum(Start, Stop) ->
    sum(Start, Stop, 0).
sum(X, Stop, Acc) when X > Stop ->
    Acc;
sum(X, Stop, Acc) ->
    case prime:is_prime(X) of
	true -> io:format("Adding: ~p~n", [X]), sum(X+2, Stop, Acc+X);
	false -> sum(X+2, Stop, Acc)
    end.
	    
solve() ->
    lists:sum(prime:produce(2000000)).
