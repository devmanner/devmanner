-module(shapes).
-export([area/1]).

area({square, X}) ->
    X*X;
area({triangle, Base, Height}) ->
    Base * Height / 2;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area([]) ->
    0;
area([Shape|Rest]) ->
    area(Shape) + area(Rest).
