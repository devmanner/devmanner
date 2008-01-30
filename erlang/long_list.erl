-module(long_list).

-compile(export_all).

long_list(L) ->
    long_list(L, [], 10000).
long_list(_, Acc, 0) ->
    Acc;
long_list(L, Acc, N) ->
    long_list(L, Acc ++ L, N-1).

 
