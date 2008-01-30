-module(get_tc).
-compile(export_all).


get_dir_suite_cases(Args) ->
    Suites = lists:filter(fun({Name,_}) -> Name == suite end, Args),
    Cases = lists:filter(fun({Name,_}) -> Name == 'case' end, Args),
    Mux = fun({suite, Suite}, {'case', CaseList}) ->
		  {filename:dirname(Suite),
		   list_to_atom(filename:basename(Suite, ".erl")),
		   lists:map(fun(X) -> list_to_atom(X) end, CaseList)
		  }
	  end,
    lists:zipwith(Mux, Suites, Cases).
