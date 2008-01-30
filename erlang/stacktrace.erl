-module(stacktrace).

-compile(export_all).

get_call_trace() ->
    catch throw(dummy_exception),
    tl(erlang:get_stacktrace()).

foo() ->
    bar(),
    ok.

bar() ->
    baz(),
    io:format("This is bar~n"),
    ok.

baz() ->
    io:format("erlang:get_stacktrace(): ~p~n", [erlang:get_stacktrace()]),
    io:format("erlang:process_info(self(), last_calls): ~p~n", [erlang:process_info(self(), last_calls)]),
    io:format("get_call_trace(): ~p~n", [get_call_trace()]),
    ok.

a() ->
    b(),
    ok.

b() ->
    c(),
    ok.

c() ->
    catch throw(exception).

test() ->
    process_flag(save_calls, 30),
    a(),
    foo().
