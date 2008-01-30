-module(guard).
-compile(export_all).


main() ->
	A = a,
	case A of
		a when is_atom(a) -> io:format("a when is_atom(a)~n");
		_ -> io:format("rest~n")
	end.
