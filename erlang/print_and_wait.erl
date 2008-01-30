-module(print_and_wait).
-compile(export_all).


print_and_wait(M, F, A) ->
    ArgList = case A of
		  [] -> [];
		  [H|T] ->
		      io_lib:format("~p", [H]) ++
			  lists:foldl(fun(X, Acc) -> Acc ++ io_lib:format(", ~p", [X]) end, [], T)
	      end,
    
    io:format("Waiting for ~p:~p(~s)~n", [M, F, lists:flatten(ArgList)]),
    io:format("Done waiting for: ~p:~p(~s)~n", [M, F, lists:flatten(ArgList)]).
