-module(rovarsprak).
-compile(export_all).

%% translate(S) ->
%%     F = fun(C) ->
%% 		case is_consonant(C) of
%% 		    true -> transform(C);
%% 		    false -> C
%% 		end
%% 	end,
%%     lists:flatten(lists:map(F, S)).

translate(S) ->
    translate(S, "").
translate([], Acc) ->
    Acc;
translate([$c,$k|T], Acc) ->
    translate([$k|T], Acc ++ "kok");
translate([H|T], Acc) ->
    case is_consonant(H) of
	true -> translate(T, Acc ++ [H,$o,H]);
	false -> translate(T, Acc ++ [H])
    end.

is_consonant(C) ->
    Consonants = "bcdfghjklmnpqrstvwxz",
    lists:member(C, Consonants).

%% transform(C) ->
%%     [C,$o,C].
%% ];

translate2([]) ->
    [];
translate2([$c,$k|T]) ->
    [$k,$o,$k|translate2([$k|T])];
translate2([H|T]) ->
    case is_consonant(H) of
	true -> [H,$o,H|translate2(T)];
	false -> [H|translate2(T)]
    end.
    


test() ->
    "bob" = translate("b"),
    "totakokkok" = translate("tack"),
    "jojagog totalolaror rorövovarorsospoproråkoketot"
	= translate("jag talar rövarspråket"),
    "rorövovarorsospoproråkoketot"
	= translate("rövarspråket"),

    {R1,R2,R3} = erlang:now(),
    random:seed(R1,R2,R3),
    lists:foreach(fun(_) ->
			  S = random_string(),
			  io:format("~nTranslating: ~s~n", [S]),
			  T1 = translate(S),
			  T2 = translate2(S),
			  io:format("~s~n~s~n", [T1, T2]),
			  T1 = T2
		  end, lists:seq(1,100)),
    ok.

random_string() ->
    Chars = "abcdefghijklmnopqrstuvwxyzåäö",
    lists:map(fun(_) -> lists:nth(random:uniform(length(Chars)), Chars) end, lists:seq(1,10)).
		      
