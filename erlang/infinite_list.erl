-module(infinite_list).

-compile(export_all).

from(N) ->
    fun() ->
	    [N|from(N+1)]
    end.

list(L) ->
    fun() ->
	    [L|list(L)]
    end.

print(0, _) ->
    ok;
print(_, []) ->
    ok;
print(N, L) ->
    List = L(),
    io:format("~p~n", [erlang:hd(List)]),
    print(N-1, erlang:tl(List)).
