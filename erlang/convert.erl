-module(convert).
-compile(export_all).

test() ->
%%     doIt(mgw, h248,
%% 	 [{"141.0.1.0", 26, "255.255.255.192", "141.0.1.63", 105,
%% 	   [{"141.0.1.0", 27, "255.255.255.224","141.0.1.61", false},
%% 	    {"141.0.1.0", 27, "255.255.255.224","141.0.1.29", false}]}]),
    doIt("MGW","H.248",
	 [{"141.0.1.0", 26, 105,
	   [{"141.0.1.0", 27,"141.0.1.61", false},
	    {"141.0.1.0", 27,"141.0.1.29", false}
	   ]}]).

doIt(Type, User, Spec) ->
    Name = lists:concat([Type, "_", User, "_ln"]),
    Description = Name,
%%     {Name, Description, parse_sn(Type, Name, Spec)}.
    parse_sn(Type, Name, Spec).

parse_sn(_, _, []) ->
    [];
parse_sn(Type, User, [{SubnetAddr, SubnetMaskShort, VlanID, SNS}|T]) ->
    SnName = lists:concat([Type, "_", User, "_sn"]),
    SnDesc = SnName,
    [{SnName, SnDesc, SubnetAddr, SubnetMaskShort, VlanID, parse_sns(Type, User, SNS)} | parse_sn(Type, User, T)].

parse_sns(_Type, _User, []) -> [];
parse_sns(Type, User, [{Addr, Mask, RouterAddr, Bool}|T]) ->
    SnsName = lists:concat([Type, "_", User, "_sns"]),
    SnsDesc = SnsName,
    [{SnsName, SnsDesc, Addr, Mask, RouterAddr, Bool} | parse_sns(Type, User, T)].
