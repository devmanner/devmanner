-module(math).
-export([factorial/1, area/1, double/1, is_even/1, is_odd/1]).

%% Factorial
factorial(0) ->	1;
factorial(N) -> N * factorial(N-1).

%% Power function pow(x, y) = x ^ y
pow(X, 0) -> 1;
pow(X, Y) -> X * pow(X, Y-1).

%% Primitive areas
area({square, Side}) ->
	area({rectangle, Side, Side});
area({rectangle, Width, Height}) ->
	Width * Height;
area({circle, Radius}) ->
	3.14159 * pow(Radius, 2);
area({triangle, Width, Height}) ->
	area({rectangle, Width, Height}) / 2.

%% double(D), doubles argument.
double(D) -> D*2.

%% is_even(X), return true if X is even.
is_even(X) when X rem 2 == 0 -> true;
is_even(_) -> false.

%% is_odd(X), return true if X is odd.
is_odd(X) when X rem 2 =/= 0 -> true;
is_odd(_) -> false.

