-module(map_catch).

-export([test/0]).

test() ->
    %% Den funktion vi vill mappa över listan.
    Fun = fun({M, F, A}) ->
 		  case catch apply(M, F, A) of
 		      {'EXIT', _}=X ->
 			  io:format("Hey, I caught an exception: ~p~n", [X]),
 			  {M, F, A, X};
 		      Rest ->
 			  {M, F, A, Rest}
 		  end
 	  end,
    
    %% En lista med MFA:er som vi vill exekvera.
    List = [{io, format, ["hello world~n"]},
	    %% Denna finns inte och kommer generera exception.
	    {an_undefined_module, function, [argument1, argument2]},
	    {erlang, is_atom, [foobar]}],

    Result = lists:map(Fun, List),
    
    io:format("~n~nResult of lists:map is:~n~p~n", [Result]).
