-module(lop). %% List OPerations ?
-compile(export_all).

lt({X1, _, Z1}, {X2, _, Z2}) ->
	case X1 < X2 of
		true -> true;
		false -> case X1 == X2 of
			true -> Z1 < Z2;
			false -> false
		end
	end.

eq(X, Y) ->
	case lt(X, Y) of
		true -> false;
		false -> case lt(Y, X) of
			true -> false;
			false -> true
		end
	end.

sort(L) ->
	Fun = fun(X, Y) -> lt(X, Y) end,
	lists:sort(Fun, L).

intersection(L1, L2) -> 
	impl_intersect(sort(L1), sort(L2), []).

impl_intersect([], [], C) ->
	C;
impl_intersect(_, [], C) ->
	C;
impl_intersect([], _, C) ->
	C;
impl_intersect([H|T1], [H|T2], C) ->
	impl_intersect(T1, T2, [H|C]);
impl_intersect([H1|T1], [H2|T2], C) ->
	case eq(H1, H2) of
		true -> impl_intersect(T1, T2, [H1|C]);
		false -> case lt(H1, H2) of
			true -> impl_intersect(T1, [H2|T2], C);
			false -> impl_intersect([H1|T1], T2, C)
		end
	end.


