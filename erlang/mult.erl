-module(mult).
-compile(export_all).
%%-import(random, [uniform/1, seed/0]).

sleep(Time) ->
	receive
		after Time -> Time
	end.

rand_sleep(Time) -> sleep(random:uniform(Time)).

init() -> random:seed(), random:seed().

child_proc(Parent) -> init()
	, child_loop(Parent, 10).

child_loop(Parent, 0) -> Parent ! {self(), die};
child_loop(Parent, X) ->
	io:print("Parent: ~w X:~w\n", [Parent, X])
	, Parent ! {self(), message}
	%%, rand_sleep(10)
	, child_loop(Parent, X-1).

main() -> init()
	, listen(spawn(mult, child_proc, [self(), 10]), spawn(mult, child_proc, [self(), 10]), 2).

listen(A, B, 0) -> io:format("All dead\n", []);
listen(A, B, X) ->
	io:format("A: ~w B: ~w\n", [A, B]),
	receive
		{A, message} -> io:format("ping\n", []), listen(A, B, X);
		{B, message} -> io:format("pong\n", []), listen(A, B, X);
		{A, die} -> io:format("A dead!\n", []), listen(A, B, X-1);
		{B, die} -> io:format("B dead!\n", []), listen(A, B, X-1)
		after 1000 -> io:format("Timeout\n", [])
	end.

		
