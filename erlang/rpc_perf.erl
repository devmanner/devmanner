-module(rpc_perf).

-export([test/0, fun_to_test/0]).

-define(WORKER, worker@ws67061).
-define(COOKIE, cookie).

%% Instructions:
% 1) ssh qtomama@ws67061
% 2) ct setview qtomama_ppb ; module add swift
% 3) erl -sname worker -setcookie cookie
% 4) Run rpc_perf:test() on local host.

fun_to_test() ->
    N = 10000,
    erlang:set_cookie(?WORKER, ?COOKIE),
    Fun = fun(_) ->
		  true = rpc:call(?WORKER, erlang, is_atom, [foo])
	  end,
    lists:map(Fun, lists:seq(1, N)),
    ok.

test() ->
    {MicroSec, ok} = timer:tc(?MODULE, fun_to_test, []),
    io:format("Time: ~p~n", [MicroSec]),
    ok.
