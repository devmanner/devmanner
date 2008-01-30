-module(test).
-compile(export_all).

test(A) ->
    case A of
	{nok, R} -> {nok, R};
	File ->
	    {ok, Path, _} = regexp:gsub(File, "erlang\.log\..*", "___"),
	    Path
    end.
