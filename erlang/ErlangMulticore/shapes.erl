-module(shapes).
-export([area/1]).

area({square, X}) ->
    X*X;
area({triangle, Base, Height}) ->
    Base * Height / 2;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area({composite, Shapes}) ->
    F = fun(Shape, Acc) ->
		area(Shape) + Acc
	end,
    lists:foldl(F, 0, Shapes).
