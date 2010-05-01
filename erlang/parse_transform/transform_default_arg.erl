-module(transform_default_arg).
-compile(export_all).

dbg(Format) ->
    dbg(Format, []).
dbg(Format, Arg) ->
    io:format(Format, Arg).

parse_transform(AST, _Options) ->
    io:format("AST (before): ~p~n", [AST]),
    R = lists:flatten(lists:map(fun transform/1, AST)),
    io:format("AST: ~p~n", [R]),
    R.

transform({function,Line,Fname,Arity,X}=Function) when Arity > 0 ->
    [{clause,_,Args,Rule,Body}] = X,
    case get_default_values(Args) of
	[] -> Function;
	DefValues ->
	    [new_function(Fname,Arity,Line,Args,DefValues),
	     old_function(Fname,Arity,Rule,Body,Line,Args)]
    end;
transform(X) ->
    X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create new function
new_function(Fname,Arity,Line,Args,DefValues) ->
    {function,Line,Fname,Arity-length(DefValues),
     [{clause,Line,
       remove_default_arguments(Args,DefValues),
       [],
       body(Fname,Line,Args,DefValues)}]}.

%% Strip off all defaulted arguments.
remove_default_arguments(Args, _DefValues) ->
    F = fun({var,_,_}=Arg) ->
		Arg;
	   (_) ->
		[]
	end,
    lists:flatten(lists:map(F, Args)).

body(Fname,Line,Args,DefValues) ->
    F = fun({var,_,_}=Arg) ->
		Arg;
	   ({match,_,{var,_,ArgName},{call,_,{atom,_,default},[_]}}) ->
		proplists:get_value(ArgName,DefValues)
	end,
    ArgList = lists:map(F, Args),
    [{call,Line,{atom,Line,Fname},ArgList}].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Regenerate old function
old_function(Fname,Arity,Rule,Body,Line,Args) ->
    {function,Line,Fname,Arity,
     [{clause,Line,
       transform_default_arguments(Args),
       Rule,
       Body}]}.
    
%% Make a list of all arguments transforming default ones.
transform_default_arguments(Args) ->
    F = fun({var,_,_}=Arg) ->
		Arg;
	   ({match,N,{var,_,ArgName},{call,_,{atom,_,default},[_]}}) ->
		{var,N,ArgName}
	end,
    lists:map(F, Args).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get default values from argument list.
get_default_values(Args) ->
    F = fun(Arg, Acc) ->
		case get_default_value(Arg) of
		    {_,_}=D -> Acc ++ [D];
		    no -> Acc
		end
	end,
    lists:foldl(F, [], Args).
get_default_value({match,_,{var,_,VarName},{call,_,{atom,_,default},[Value]}}) ->
    {VarName, Value};
get_default_value({var,_,_}) ->
    no.
