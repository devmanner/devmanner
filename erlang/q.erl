-module(q).
-export([solve/0]).

%% Number of rows and columns
-define(RC, 8).
-define(RCI(R, C), ((R-1)*?RC + C) ).

%%-define(BOARD_AS_LIST, true).

-ifdef(BOARD_AS_LIST).
%% Board handling functions. Board implemented as a 64 index list.
%% Time to solve measured with: timer:tc(q, solve, []):
%% {3380267,ok}
new() ->
    lists:map(fun(_) -> 0 end, lists:seq(1, ?RC*?RC)). %% UGLY
get_square(_, Row, Col) when (Row < 1) or (Row > ?RC) or (Col < 1) or (Col > ?RC) ->
    0;
get_square(Board, Row, Col) ->
    lists:nth(?RCI(Row, Col), Board).
set_square(Board, Row, Col, Value) ->
    lists:sublist(Board, 1, ?RCI(Row, Col)-1)
 	++ [Value]
 	++ lists:sublist(Board, ?RCI(Row, Col) + 1, length(Board) - ?RCI(Row, Col)).
print([]) ->
    ok;
print(Board) ->
    {Head, Tail} = lists:split(?RC, Board),
    io:format(get_fstr(), Head),
    print(Tail).
get_fstr() ->
    lists:flatten(lists:map(fun(_) -> "~p" end, lists:seq(1, ?RC)) ++ "~n").

-else.
%% Board handling functions. Board implemented as a 64 bit integer.
%% Time to solve measured with: timer:tc(q, solve, []):
%% {1294454,ok}
new() ->
    0.
get_square(_, Row, Col) when (Row < 1) or (Row > ?RC) or (Col < 1) or (Col > ?RC) ->
    0;
get_square(Board, Row, Col) ->
    (Board bsr (?RCI(Row, Col)-1)) band 1.
set_square(Board, Row, Col, Value) ->
    Board bor (Value bsl (?RCI(Row, Col)-1)).
print(Board) ->
    print(Board, 0).
print(_, ?RC*?RC) ->
    ok;
print(Board, BitsPrinted) ->
    io:format("~p", [Board band 1]),
    case BitsPrinted rem ?RC of
	?RC-1 -> io:format("~n");
	_ -> ok
    end,
    print(Board bsr 1, BitsPrinted + 1).
-endif.

%% Is it ok to place a queen at (Row, Col)
ok_place(Board, Row, Col) ->
    All = lists:seq(1, ?RC),
    Fun = fun(X, Acc) ->
		  case (Acc == ok) and
		      (get_square(Board, Row, X) == 0) and
		      (get_square(Board, X, Col) == 0) and
		      (get_square(Board, Row-X, Col-X) == 0) and
		      (get_square(Board, Row+X, Col+X) == 0) and
		      (get_square(Board, Row+X, Col-X) == 0) and
		      (get_square(Board, Row-X, Col+X) == 0) of
		      true -> ok;
		      false -> nok
		  end
	  end,
    lists:foldl(Fun, ok, All).

get_answers(0, Acc) ->
    Acc;
get_answers(N, Acc) ->
    receive R -> get_answers(N-1, Acc ++ R) end.

proc(Parent, Board, ?RC+1) ->
    Parent ! [Board];
proc(Parent, Board, Row) ->
    All = lists:seq(1, ?RC),
    Fun = fun(Col, NStarted) ->
		  case ok_place(Board, Row, Col) of
		      ok ->
			  Self = self(),
			  spawn(fun() -> proc(Self, set_square(Board, Row, Col, 1), Row+1) end),
			  NStarted+1;
		      nok ->
			  NStarted
		  end
	  end,
    N = lists:foldl(Fun, 0, All),
    case Parent of
	no_parent ->
	    get_answers(N, []);
	_ ->
	    Parent ! get_answers(N, [])
    end.

solve() ->
    io:format("Solving ~p queens problem...~n", [?RC]),
    R = proc(no_parent, new(), 1),
    io:format("Found: ~p solutions:~n", [length(R)]),
    lists:foreach(fun(X) -> print(X), io:format("~n") end, R).

