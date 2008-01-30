-module(parse).

-compile(export_all).

test() ->
    S = "[1, 2] {kolle, ada} [list, {kalle,ada},1]",
    parse_terms(S).

parse_terms(S) ->
    case catch parse_terms(tokenize(S), 1) of
	{nok, R} -> {nok, R};
	X -> X
    end.
parse_terms(Tokens, Len) when Len > length(Tokens)  ->
    case Tokens of
	[] -> [];
	_ -> throw({nok, "Tokens left!"})
    end;
parse_terms(Tokens, Len) ->
    {First, Second} = lists:split(Len, Tokens),
    case erl_scan:string(lists:concat(First) ++ ".") of
	{ok, L, _} ->
	    case erl_parse:parse_term(L) of
		{error,_} ->
		    parse_terms(Tokens, Len+1);
		{ok, Term} ->
		    [Term] ++ parse_terms(Second, 1)
	    end;
	_ ->
	    parse_terms(Tokens, Len+1)
    end.


tokenize(S) ->
    {ok, L, _} = erl_scan:string(S),
    Fun = fun(X) ->
		  case X of
		      {T,_} -> T;
		      {_,_,T} -> T
		  end
	  end,
    lists:map(Fun, L).
