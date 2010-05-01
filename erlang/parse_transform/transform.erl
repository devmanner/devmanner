-module(transform).
-compile(export_all).


parse_transform(AST, _Options) ->
    io:format("AST: ~p~n", [AST]),
    traverse(AST, []),
    AST.

traverse([{attribute,_,compile,begin_grammar}|T], Acc) ->
    parse_grammar(T, Acc);
traverse([{attribute,_,_,_}|T], Acc) ->
    traverse(T, Acc).

parse_grammar([{function,_,Rule,_,[{clause,_,[],[],Match}]}|T], Acc) ->
    io:format("~p is: ", [Rule]),
    L = parse_match_list(Match, []),
    io:format("~p~n", [L]),
    ok.

parse_match_list([], Acc) ->
    Acc;
parse_match_list(Match, Acc) ->
    F = fun({atom,_,'OR'}) -> true;
	   (_) -> false
	end,
    {FirstMatch, Rest} = split_at(F, Match),
    parse_match_list(Rest, Acc ++ [parse_match(FirstMatch, [])]).

parse_match([{call,_,{atom,_,Rule},[]}|T], Acc) ->
    parse_match(T, Acc ++ [Rule]);
parse_match([{atom,_,Token}|T], Acc) ->
    parse_match(T, Acc ++ [Token]);
parse_match([], Acc) ->
    Acc.



split_at(Pred, L) ->
    split_at(Pred, L, []).
split_at(_, [], Acc) ->
    {lists:reverse(Acc), []};
split_at(Pred, [H|T], Acc) ->
    case Pred(H) of
	true ->
	    {lists:reverse(Acc), T};
	false ->
	    split_at(Pred, T, [H|Acc])
    end.
