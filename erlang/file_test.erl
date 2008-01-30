-module(file_test).
-compile(export_all).

main() ->
    {ok, IoDevice} = file:open("temp.txt", [append]),
    ok = file:write(IoDevice, "foobar\n"),
    ok = file:close(IoDevice).
