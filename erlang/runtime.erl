-module(runtime).

-compile(export_all).

wait(Pid, Time) ->
    timer:sleep(Time),
    exit(Pid, {timeout, "Timeout for testcase!"}).

set_runtime(Pid, Time) ->
    erlang:spawn(?MODULE, wait, [Pid, Time]).

test() ->
    set_runtime(self(), 3000),
    timer:sleep(5000).
