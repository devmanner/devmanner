-module(net_util).
-compile(export_all).

get_subnet_addr(_, MaskSize) when MaskSize > 32 ->
    mask_too_large;
get_subnet_addr([A|T], MaskSize) when MaskSize > 8 ->
    [A | get_subnet_addr(T, MaskSize-8)];
get_subnet_addr([A|T], MaskSize) ->
    Mask = (2#11111111 bsr (8-MaskSize)) bsl (8-MaskSize),
    [A band Mask | lists:map(fun(_) -> 0 end, T)].

