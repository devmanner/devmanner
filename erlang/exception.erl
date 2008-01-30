-module(exception).

-compile(export_all).

foo() ->
    F = case foo of
	    foobar -> throw({nok, foobar});
	    R -> R
	end,
    throw({nok, kalle}).

test() ->
    case catch foo() of
	{nok, R} ->
	     {nok, R};
	ok -> ok
    end.
