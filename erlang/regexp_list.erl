-module(regexp_list).

-compile(export_all).

test() ->
    Fun = fun({Search, Replace}, Acc) ->
		  {ok, R, _} = regexp:gsub(Acc, Search, Replace),
		  R
	  end,
    lists:foldl(Fun, "foobar", [{"oo", "OO"}, {"OO", "oo"}, {"^o", "0"}]).


			
