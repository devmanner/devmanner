-module(test_case).

-compile(export_all).

f() ->
    ok.

check_ok([]) ->
    ok;
check_ok([ok|T]) ->
    check_ok(T);
check_ok([R|_]) ->
    {nok, R}.

main() ->
    case
	(ok == f()) and
	(ok == f()) 
	of
	ok ->
	    ok;
	R ->
	    R
    end.

