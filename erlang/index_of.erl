-module(index_of).

-compile(export_all).

test() ->
    {found, 0} = index_of(1, [1, 2, 3, 4]),
    {found, 1} = index_of(2, [1, 2, 3, 4]),
    {found, 2} = index_of(3, [1, 2, 3, 4]),
    {not_found, _} = index_of(5, [1, 2, 3, 4]),
    ok.

index_of(What, List) ->
    F = fun(_, {found, Index}) -> {found, Index};
	   (X, {not_found, Index}) when X == What -> {found, Index};
	   (_, {not_found, Index}) -> {not_found, Index+1}
	end,
    lists:foldl(F,
		{not_found, 0},
		List).
