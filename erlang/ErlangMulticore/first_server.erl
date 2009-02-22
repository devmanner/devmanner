-module(first_server).
-export([start/0]).

start() ->
    spawn(fun() -> do_start() end).

do_start() ->
    true = register(?MODULE, self()),
    loop().

loop() ->
    receive
	kill ->
	    io:format("~p: I'm dieing now!~n", [?MODULE]);
	Message ->
	    io:format("~p: I've got a message: ~p~n", [?MODULE, Message]),
	    loop()
    end.
