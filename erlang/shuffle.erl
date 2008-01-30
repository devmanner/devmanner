-module(shuffle).

-compile(export_all).

random(Max) ->
    round(random:uniform()*(Max*100)) rem Max.

split2(L) ->
    Len = length(L),
    Random = random(Len-1),
    lists:split(Random, L).
split3(L) ->
    {First, Rest} = split2(L),
    {Second, Third} = split2(Rest),
    {First, Second, Third}.    

shuffle(L) ->
    shuffle(L, []).
shuffle([], _) ->
    [];
shuffle([X], Acc) ->
    [X|Acc];
shuffle(L, Acc) ->
    {First, Second} = split2(L),
    shuffle(lists:flatten([First, tl(Second)]), [hd(Second)|Acc]).


shuffle2(L) ->
    shuffle2(L, 10).
shuffle2(L, 0) ->
    L;
shuffle2(L, N) ->
    {First, Second, Third} = split3(L),
    case Second of
	[] -> shuffle2(First ++ Second ++ Third, N-1);
	_ ->
	    shuffle2(First ++ [hd(Third)] ++ tl(Second) ++ [hd(Second)] ++ tl(Third), N-1)
    end.
	    

    
