-module(interact).

-compile(export_all).

read(Prompt, Format) ->
    io:format("-------------------------- Input --------------------------~n"),
    io:fread(erlang:list_to_atom(Prompt ++ " > "), Format).

getch(Prompt) ->
    read(Prompt, "").

