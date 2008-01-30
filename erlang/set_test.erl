-module(set_test).
-compile(export_all).

test() ->
    L1 = [1, 2, 3, 4, 5],
    L2 = [1, 2, 3],
    true = sets:is_subset(sets:from_list(L2), sets:from_list(L1)),
    sets:to_list(sets:subtract(sets:from_list(L1), sets:from_list(L2))).
    
			 
