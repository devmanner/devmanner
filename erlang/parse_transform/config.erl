-module(config).
-compile(export_all).
-compile({parse_transform, transform}).

%% -define(rebind(X), shell_default:f(X),X).

%% foo() ->
%%     A = 1,
%%     ?rebind(A) = inc(A).

%% inc(X) ->
%%     io:format("hello"),
%%     X+1.

-compile(begin_grammar).

expr() ->
    expr(), '+', expr(), 'OR',
    expr(), '-', expr(), 'OR',
    number().
    
