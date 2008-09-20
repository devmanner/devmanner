-module(lin).

-compile(export_all).


pow(A, 1, M) ->
    A rem M;
pow(A, 2, M) ->
    A*A rem M;
pow(A, B, M) ->
    B1 = B div 2,
    B2 = B - B1,
    %% B2 = B1 or B1+1
    P = pow(A, B1, M),
    case B2 of
	B1 -> (P*P) rem M;
	_  -> (P*P*A) rem M
    end.

gcd(A, B) when A < B -> gcd(B, A);
gcd(A, 0) -> A;
gcd(A, B) ->
    gcd(B, A rem B).

str2int(Str) -> str2int(Str, 0).
str2int([H|T], N) -> str2int(T, N*256+H);
str2int([], N) -> N.

int2str(N) -> int2str(N, []).
int2str(N, L) when N =< 0 -> L;
int2str(N, L) ->
    N1 = N div 256,
    H = N - N1 * 256,
    int2str(N1, [H|L]).



solve(A, B) ->
    case catch s(A,B) of
	insoluble -> insoluble;
             {X, Y} ->
	    case A * X - B * Y of
		1     -> {X, Y};
		Other -> error
	    end
    end.

s(A, 0)  -> throw(insoluble);
s(A, 1)  -> {0, -1};
s(A, -1) -> {0, 1};
s(A, B)  ->
    K1 = A div B,
    K2 = A - K1*B,
    {Tmp, X} = s(B, -K2),
    {X, K1 * X - Tmp}.

inv(A, B) ->
    case solve(A, B) of
	{X, Y} ->
	    if X < 0 -> X + B;
	       true  -> X
	    end;
	_ ->
	    no_inverse
    end.

