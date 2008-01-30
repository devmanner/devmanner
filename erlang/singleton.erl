-module(singleton).
-compile(export_all).

is_name(X) ->
	case X of
		singleton -> true;
		_ -> false
	end.

create(Parent) ->
	create(Parent, 0).
create(Parent, X) ->
	recieve
		new_instance ->
			case lists:filter(fun (X) -> singleton:is_name(X) end, registered()) of
				[foo|_] -> ;
				_ -> register(singleton, self())
			end,
			Parent ! X,
	end,
	create(Parent, X).


get_instance() ->
	spawn(singleton, create, [self()]),
	recieve
		Instance -> Instance;
		_ -> io:format("Error~n")
	end.

main() ->
	get_instance(),
	get_instance(),
	get_instance().
