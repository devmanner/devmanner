-module(foldl).

-compile(export_all).

main() ->
    lists:foreach(fun({File, Atom}) -> io:format("{\"~s\", ~p}~n", [File, Atom]) end, get_list()).
			  

get_list() ->
    Dir = "/home/qtomama/code/erlang/",
    {ok, Beams} = regexp:split(string:strip(os:cmd("ls " ++ Dir ++ "*.beam"), right, $\n), "\n"),
    Fun = fun(X, L) -> L ++ [{Dir ++ X, foo}] end,
    lists:foldl(Fun, [], Beams).
 
		  
		  
