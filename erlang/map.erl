-module(map).
-export([new/0, get/2, set/2]).

new() -> [].

get([{Key|Value]|_], Key) -> Value;
get([_|Tail], Key) -> get(Tail, Key).

set([{Key, V}|_, {Key, Value}) -> V = Value;
set([_|Tail], P) -> set(Tail, P);
set([], P) -> 