-module(solve).
-compile(export_all).

% Run with:
% erl -noshell -s solve main -s erlang halt

read_input() ->
	{ok, [Rows, Cols]} = io:fread("", "~d ~d"),
	F = fun(I, {List, Start, Goal}) ->
			case io:fread("", "~c") of
				{ok, ["#"]} -> {[{-1, []}|List], Start, Goal};
                {ok, ["u"]} -> {[{0, []}|List], {I div Cols, (I rem Cols) - 1}, Goal};
				{ok, ["c"]} -> {[{inf, []}|List], Start, {I div Cols, (I rem Cols) - 1}};
                {ok, [" "]} -> {[{inf, []}|List], Start, Goal}
			end
		end,
	{List, Start, Goal} = lists:foldl(F, {[], undef, undef}, lists:seq(1, Rows*Cols)),
	{matrix:from_list(Rows, Cols, lists:reverse(List)), Start, Goal}.

less(inf, _) -> false; % This clause will never match in the current context
less(_, inf) -> true;
less(X, Y) -> X < Y.

explore(Row, Col, StartWorld) ->
	{Cost, Path} = matrix:value(StartWorld, Row, Col),
	Instr = [{"N", {-1, 0}}, {"E", {0, 1}}, {"S", {1, 0}}, {"W", {0, -1}}],
	F = fun({Dir, {DRow, DCol}}, World) ->
		{C, _P} = matrix:value(World, Row+DRow, Col+DCol),
		case less(Cost+1, C) of
			true ->
				NewWorld = matrix:set(World, Row+DRow, Col+DCol, {Cost+1, Path ++ Dir}),
				explore(Row+DRow, Col+DCol, NewWorld);
	        false ->
				World
		end
    end,
	lists:foldl(F, StartWorld, Instr).

main() ->
	{World, {StartRow, StartCol}, {GoalRow, GoalCol}} = read_input(),
%	io:format("The world as we know it:~n"),
%	matrix:print(World),
	Paths = explore(StartRow, StartCol, World),
	case matrix:value(Paths, GoalRow, GoalCol) of
		{inf, []} -> io:format(":(~n");
		{_, Path} -> io:format("~s~n", [Path])
	end.




