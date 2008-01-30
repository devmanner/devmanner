-module(eq).
-compile(export_all).

%% Row, and Col is 1 to 8

get(Board, Row, Col) ->
    (Board bsr ((Row-1)*8) + (Col-1)) band 1.

set(Board, Row, Col) ->
    Board bor (1 bsl ((Row-1)*8+(Col-1))).
