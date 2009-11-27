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

test() ->
    "bob" = translate("b"),
    "totakokkok" = translate("tack"),
    "jojagog totalolaror rorövovarorsospoproråkoketot"
	= translate("jag talar rövarspråket"),
    "rorövovarorsospoproråkoketot"
	= translate("rövarspråket"),
    ok.
