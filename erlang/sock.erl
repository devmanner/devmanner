-module(sock).
-compile(export_all).

test() ->
    SomeHostInNet = "localhost",
    {ok, Sock} = gen_tcp:connect(SomeHostInNet, 8888, [binary, {packet, 0}]),
    ok = gen_tcp:send(Sock, "Some Data"),
    io:format("Socket: ~p~n", [Sock]),
    ok = gen_tcp:close(Sock).
