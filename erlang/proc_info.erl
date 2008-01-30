-module(proc_info).

-compile(export_all).

test() ->
    erlang:process_info(self(), current_function).
