-module(io_perf).

-compile(export_all).


test() ->
    Name = 666,

    B = remove_html(lists:flatten(io_lib:format("foo ~s bar.~n", get_string()))),
    %% Get the headera and body.
    {ok, Header, _} = regexp:gsub(B, "\n.*", ""),
    {ok, Body, _} = regexp:gsub(B, "\n", "<br>\n"),

    %% Add unique identifier names to the fields.
    {ok, Wid1, _} = regexp:gsub(read_file(), "IDENTIFIER1", "id1_" ++ erlang:integer_to_list(Name)),
    {ok, Wid2, _} = regexp:gsub(Wid1, "IDENTIFIER2", "id2_" ++ erlang:integer_to_list(Name)),

    %%[Out] = io_lib:format("~s", [Wid2]),
    ct:log(Wid2, [Header, Body]).

read_file() ->
    "this is the so called file IDENTIFIER1~n~s~nIt goes on and on IDENTIFIER2 ~n~n~s~n~n sort of never ends...\n".

remove_html(S) ->
    {ok, S_nolt, _} = regexp:gsub(S, "<", "\\&lt;"),
    {ok, S_nogt, _} = regexp:gsub(S_nolt, ">", "\\&gt;"),
    S_nogt.

get_string() ->
    "[02:19:03 jpTinit(182)] Start logging  Conf:all TestCase: is_only_in_jpTrub  
[02:19:03 jpTstates(1005)]  ale do not exist 
[02:19:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,ale,1},
                                      {jpTinit,start_log,2},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3}] 
[02:19:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:03 jpTrpc(196)] sisom calling module: ets  func: tab2list arg: [isFmCurrentAlarmTable]
 [02:19:03 jpTrpc(218)] sisom rpc [{isFmCurrentAlarmTable,664,
                                  \"bs_MGW_4\",
                                  4,
                                  \"lossOfTransmitClockSourceAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,0,6,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"Its not possible to get synchronization from the link or both MXB clocks are unavailable, depending on netsynch configuration:  (0-19).\",
                                  15,
                                  \"Subrack 0, Slot 19 (X62). (BS name: mgw_1)  Error: 0x5230000\"},
           {isFmCurrentAlarmTable,667,
                                  \"bs_MGW_4\",
                                  6,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,0,6,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss Of Signal on link:  (0-19).\",
                                  29,
                                  \"Subrack 0, Slot 19 (X62). (BS name: mgw_1)  Error: 0x5010000\"},
           {isFmCurrentAlarmTable,666,
                                  \"bs_MGW_4\",
                                  19,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,0,6,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss of Signal on signalling link:  (0-15).\",
                                  29,
                                  \"Subrack 0, Slot 15 (X50). (BS name: mgw_1)  Error: 0x9010000\"},
           {isFmCurrentAlarmTable,472,
                                  \"bs_SIS_1\",
                                  395,
                                  \"ispDestAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,5,9,54,58,0,43,0,0],
                                  \"SIS:ISP\",
                                  2,
                                  3,
                                  \"Configuration error: Host\",
                                  5,
                                  []},
           {isFmCurrentAlarmTable,665,
                                  \"bs_MGW_4\",
                                  20,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,0,6,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss Of Signal on link:  (0-15).\",
                                  29,
                                  \"Subrack 0, Slot 15 (X50). (BS name: mgw_1)  Error: 0x5010000\"},
           {isFmCurrentAlarmTable,668,
                                  \"bs_MGW_4\",
                                  5,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,0,6,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss of Signal on signalling link:  (0-19).\",
                                  29,
                                  \"Subrack 0, Slot 19 (X62). (BS name: mgw_1)  Error: 0x9010000\"},
           {isFmCurrentAlarmTable,663,
                                  \"bs_MGW_4\",
                                  18,
                                  \"lossOfTransmitClockSourceAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,0,6,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"Its not possible to get synchronization from the link or both MXB clocks are unavailable, depending on netsynch configuration:  (0-15).\",
                                  15,
                                  \"Subrack 0, Slot 15 (X50). (BS name: mgw_1)  Error: 0x5230000\"}] 
[02:19:03 jpTrpc(279)] safesisom calling module: hwmI  func: get_all_bs_id_and_name 
[02:19:03 jpTrpc(284)] safesisom calling module: hwmI  func: get_all_bs_id_and_name arg: [] 
[02:19:03 jpTrpc(302)] sisom calling module: hwmI  func: get_all_bs_id_and_name arg: [] 
[02:19:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,pingE,1},
                                      {jpTrpc,impl_sisom,3},
                                      {jpTrpc,safesisom,4},
                                      {jpTnames,build_table,0},
                                      {jpTnames,update,0},
                                      {jpTnames,get_table,0}] 
[02:19:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTrpc,impl_sisom,3},
                                      {jpTrpc,safesisom,4},
                                      {jpTnames,build_table,0},
                                      {jpTnames,update,0},
                                      {jpTnames,get_table,0},
                                      {jpTnames,translate,3}] 
[02:19:03 jpTrpc(308)] sisom erlnode [sis1@sis1,sis2@sis2] 
[02:19:03 jpTrpc(401)] sisom Head sis1@sis1
[02:19:03 jpTrpc(401)] sisom Head sis2@sis2
[02:19:03 jpTrpc(310)] sisom omcp sis2@sis2 
[02:19:03 jpTnames(1132)] HwmBsIdList is  [{\"SIS\",\"bs_SIS_1\"},
                 {\"MXB slot 0\",\"bs_MXB_2\"},
                 {\"MXB slot 25\",\"bs_MXB_3\"},
                 {\"mgw_1\",\"bs_MGW_4\"},
                 {\"cer_1\",\"bs_ISER_5\"},
                 {\"exb_2\",\"bs_EXB_7\"},
                 {\"exb_1\",\"bs_EXB_6\"}] 
[02:19:03 jpTnames(1200)] H is: [{name,\"SIS\"},{slotSubrack,[{0,1},{0,13}]},{hostname,[sis1,sis2]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"MXB slot 0\"},{slotSubrack,[{0,0}]},{hostname,[mxb1]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"MXB slot 25\"},{slotSubrack,[{0,25}]},{hostname,[mxb2]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"mp_1\"},
       {slotSubrack,[{0,6},{0,21}]},
       {hostname,[blade_0_6,blade_0_21]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"mgw_1\"},
       {slotSubrack,[{0,15},{0,19}]},
       {hostname,[blade_0_15,blade_0_19]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"exb_1\"},{slotSubrack,[{0,5}]},{hostname,[blade_0_5]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"exb_2\"},{slotSubrack,[{0,24}]},{hostname,[blade_0_24]}]
[02:19:03 jpTnames(1200)] H is: [{name,\"cer_1\"},{slotSubrack,[{0,22}]},{hostname,[blade_0_22]}]
[02:19:03 jpTnames(1158)] Cannot create an erlang cookie from BsId: null, BsNo: null 
[02:19:03 jpTnames(1160)] You may have to run jpTnames:update()
[02:19:03 jpTnames(1119)] Updating jpTnames translation table.
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:04 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:04 jpTrpc(196)] sisom calling module: hwmDbg  func: bs arg: []
 [02:19:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,logging_loop,3}] 
[02:19:05 jpTrpc(218)] sisom rpc {ok,[{\"bs_SIS_1\",
                [{bs_no,1},
                 {bs_swg,\"CXS10138\",\"R2E23\"},
                 {cxr,\"CXR1010168\",\"R2B19\"},
                 {user_label,\"SIS\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_2\",
                [{bs_no,2},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_3\",
                [{bs_no,3},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MGW_4\",
                [{bs_no,4},
                 {bs_swg,\"CXS10176\",\"R3A08\"},
                 {cxr,[],[]},
                 {user_label,\"mgw_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_ISER_5\",
                [{bs_no,5},
                 {bs_swg,\"CXS10164\",\"R2A13\"},
                 {cxr,[],[]},
                 {user_label,\"cer_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_6\",
                [{bs_no,6},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_7\",
                [{bs_no,7},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[02:19:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTinit,start_hwm,1},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:05 jpTrpc(196)] sisom calling module: hwmDbg  func: bl arg: []
 [02:19:05 jpTrpc(218)] sisom rpc {ok,[{{0,0},
                [{bs_no,2},
                 {bs_id,\"bs_MXB_2\"},
                 {swg_lowest,\"CXS101039\",\"P2A\"},
                 {swg_actual,\"CXS101039\",\"R2E03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,1},
                [{bs_no,1},
                 {bs_id,\"bs_SIS_1\"},
                 {swg_lowest,\"CXS10137\",\"R2A\"},
                 {swg_actual,\"CXS10137\",\"R2E11\"},
                 {user_label,\"sis1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,5},
                [{bs_no,6},
                 {bs_id,\"bs_EXB_6\"},
                 {swg_lowest,\"CXS101040\",\"P2A\"},
                 {swg_actual,\"CXS101040\",\"R2E04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,13},
                [{bs_no,1},
                 {bs_id,\"bs_SIS_1\"},
                 {swg_lowest,\"CXS10137\",\"R2A\"},
                 {swg_actual,\"CXS10137\",\"R2E11\"},
                 {user_label,\"sis2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,15},
                [{bs_no,4},
                 {bs_id,\"bs_MGW_4\"},
                 {swg_lowest,\"CXS101059\",\"R2B\"},
                 {swg_actual,\"CXS101059\",\"R3A04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,19},
                [{bs_no,4},
                 {bs_id,\"bs_MGW_4\"},
                 {swg_lowest,\"CXS101059\",\"R2B\"},
                 {swg_actual,\"CXS101059\",\"R3A04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,22},
                [{bs_no,5},
                 {bs_id,\"bs_ISER_5\"},
                 {swg_lowest,\"CXS10163\",\"R2A13\"},
                 {swg_actual,\"CXS10163\",\"R2A13\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,24},
                [{bs_no,7},
                 {bs_id,\"bs_EXB_7\"},
                 {swg_lowest,\"CXS101040\",\"P2A\"},
                 {swg_actual,\"CXS101040\",\"R2E04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,25},
                [{bs_no,3},
                 {bs_id,\"bs_MXB_3\"},
                 {swg_lowest,\"CXS101039\",\"P2A\"},
                 {swg_actual,\"CXS101039\",\"R2E03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[02:19:05 jpTio(222)] Waiting for unique name for expander...[02:19:05 jpTio(225)] Got unique name for expander![02:19:05 jpTio(222)] Waiting for unique name for expander...[02:19:05 jpTio(225)] Got unique name for expander![02:19:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTinit,start_hwm,1},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:05 jpTrpc(196)] sisom calling module: hwmDbg  func: bs arg: []
 [02:19:05 jpTrpc(218)] sisom rpc {ok,[{\"bs_SIS_1\",
                [{bs_no,1},
                 {bs_swg,\"CXS10138\",\"R2E23\"},
                 {cxr,\"CXR1010168\",\"R2B19\"},
                 {user_label,\"SIS\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_2\",
                [{bs_no,2},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_3\",
                [{bs_no,3},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MGW_4\",
                [{bs_no,4},
                 {bs_swg,\"CXS10176\",\"R3A08\"},
                 {cxr,[],[]},
                 {user_label,\"mgw_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_ISER_5\",
                [{bs_no,5},
                 {bs_swg,\"CXS10164\",\"R2A13\"},
                 {cxr,[],[]},
                 {user_label,\"cer_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_6\",
                [{bs_no,6},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_7\",
                [{bs_no,7},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[02:19:05 jpTstates(1197)] wait_for_all_bs N = 60 Op = 2 Av =  1 
[02:19:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,2},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:05 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:19:05 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:19:05 jpTstates(1203)] wait_for_all_bs N = 6 AllBsNoList = [1,2,3,4,5,6,7] 
[02:19:05 jpTstates(1227)] wait_for_all_bs1 H 1 NokList [] 
[02:19:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [1]
 [02:19:05 jpTrpc(218)] sisom rpc {2,1} 
[02:19:05 jpTstates(1230)] Op1: 2 av1: 1
[02:19:05 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:05 jpTstates(1227)] wait_for_all_bs1 H 2 NokList [] 
[02:19:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:19:05 jpTrpc(218)] sisom rpc {2,1} 
[02:19:05 jpTstates(1230)] Op1: 2 av1: 1
[02:19:05 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:06 jpTstates(1227)] wait_for_all_bs1 H 3 NokList [] 
[02:19:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [3]
 [02:19:06 jpTrpc(218)] sisom rpc {2,1} 
[02:19:06 jpTstates(1230)] Op1: 2 av1: 1
[02:19:06 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:06 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:19:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:19:06 jpTrpc(218)] sisom rpc {2,1} 
[02:19:06 jpTstates(1230)] Op1: 2 av1: 1
[02:19:06 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:06 jpTstates(1227)] wait_for_all_bs1 H 5 NokList [] 
[02:19:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [5]
 [02:19:06 jpTrpc(218)] sisom rpc {2,1} 
[02:19:06 jpTstates(1230)] Op1: 2 av1: 1
[02:19:06 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:06 jpTstates(1227)] wait_for_all_bs1 H 6 NokList [] 
[02:19:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [6]
 [02:19:06 jpTrpc(218)] sisom rpc {2,1} 
[02:19:06 jpTstates(1230)] Op1: 2 av1: 1
[02:19:06 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:06 jpTstates(1227)] wait_for_all_bs1 H 7 NokList [] 
[02:19:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTinit,init_per_testcase,2},
                                      {test_server,my_apply,3},
                                      {test_server,init_per_testcase,3}] 
[02:19:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [7]
 [02:19:06 jpTrpc(218)] sisom rpc {2,1} 
[02:19:06 jpTstates(1230)] Op1: 2 av1: 1
[02:19:06 jpTstates(1234)] add_if_not_ok NokList [] 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:07 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:19:07 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"1307\",
            \"2006-12-06T00:06:30Z:752368\",
            \"-\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"1307\",
            \"2006-12-06T00:06:30Z:769821\",
            \"-\"]] 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:19:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:07 jpTrpc(196)] sisom calling module: lanFmDbg  func: reset_mxb_restart_prot arg: []
 [02:19:07 jpTrpc(218)] sisom rpc {atomic,ok} 
[02:19:07 jpTrub(296)] mxbReboot activmxb 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstartstop,mxbReboot,1},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,find_mxb_rule,1},
                                      {jpTstartstop,mxbReboot,1},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:19:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:07 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:19:07 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"1308\",
            \"2006-12-06T00:06:30Z:752368\",
            \"-\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"1308\",
            \"2006-12-06T00:06:30Z:769821\",
            \"-\"]] 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_single,1},
                                      {jpTstates,do_find_mxb_rule,2},
                                      {jpTstartstop,mxbReboot,1},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:07 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:19:07 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"1309\",
            \"2006-12-06T00:06:30Z:752368\",
            \"-\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"1309\",
            \"2006-12-06T00:06:30Z:769821\",
            \"-\"]] 
[02:19:07 jpTstates(417)] Is not running single emty[[\"0\",
                            \"25\",
                            \"active\",
                            \"yes\",
                            \"present\",
                            \"169.254.64.4\",
                            \"1308\",
                            \"2006-12-06T00:06:30Z:752368\",
                            \"-\"],
                           [\"0\",
                            \"0\",
                            \"passive\",
                            \"no\",
                            \"present\",
                            \"169.254.64.3\",
                            \"1308\",
                            \"2006-12-06T00:06:30Z:769821\",
                            \"-\"]] 
[02:19:07 jpTnames(217)] Name is  mxb2 Stack [{jpTnames,find_node_name,1},
                     {jpTstartstop,mxbReboot,1},
                     {jpTrub,rst_active_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3},
                     {test_server,run_test_case_eval1,4}] 
[02:19:07 jpTnames(217)] Name is  mxb2 Stack [{jpTnames,find_node_name,1},
                     {jpTstates,pingL,1},
                     {jpTstartstop,mxbReboot1,1},
                     {jpTrub,rst_active_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3}] 
[02:19:07 jpTnames(217)] Name is  mxb2 Stack [{jpTnames,find_node_name,1},
                     {jpTmxbOs,rst,1},
                     {jpTstartstop,do_mxbReboot,1},
                     {jpTstartstop,mxbReboot1,1},
                     {jpTrub,rst_active_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3}] 
[02:19:07 jpTmxbOs(474)] rst Mxb  mxb2
[02:19:07 jpTmxbOs(484)] rst cmd \"do_mxb.exp mxb2 tre,14 rst\"
[02:19:07 jpTmxbOs(486)] disable_mxb_isol_check 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTmxbOs,do_rst,2},
                                      {jpTstartstop,do_mxbReboot,1},
                                      {jpTstartstop,mxbReboot1,1},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:07 jpTrpc(196)] sisom calling module: lanFmDbg  func: disable_mxb_isol_check arg: []
 [02:19:07 jpTrpc(218)] sisom rpc ok 
[02:19:07 jpTmxbOs(489)] reset_mxb_restart_prot 
[02:19:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTmxbOs,do_rst,2},
                                      {jpTstartstop,do_mxbReboot,1},
                                      {jpTstartstop,mxbReboot1,1},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:07 jpTrpc(196)] sisom calling module: lanFmDbg  func: reset_mxb_restart_prot arg: []
 [02:19:07 jpTrpc(218)] sisom rpc {atomic,ok} 
[02:19:10 jpTmxbOs(499)] cmd data \"\n\" 
[02:19:10 jpTrub(298)] is_running_single mxb 
[02:19:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:40 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:19:40 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1318\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:19:40 jpTstates(554)] If running single 
[02:19:40 jpTinit(522)] get_mbs 
[02:19:41 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:19:41 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:19:41 jpTrpc(218)] sisom rpc \"SIS\" 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:19:41 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:19:41 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:19:41 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:19:41 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:19:41 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:19:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:19:42 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:19:42 jpTinit(531)] get_mbs \"mp_1\" 
[02:19:42 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:19:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:19:42 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:19:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:19:42 jpTrpc(218)] sisom rpc \"SIS\" 
[02:19:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:19:42 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:19:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:19:42 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:19:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:19:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:19:42 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:19:42 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:19:42 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:19:42 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:19:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:19:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:19:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:19:42 jpTrpc(218)] sisom rpc {2,1} 
[02:19:42 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:20:02 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:20:03 jpTrub(302)] is_running_dual mxb 
[02:20:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:33 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:33 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1334\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:34 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:34 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1335\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:35 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:35 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1336\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:36 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:36 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:36 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1337\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:37 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:37 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1338\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:38 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:38 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:38 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1339\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:39 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:39 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1340\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:40 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:40 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1341\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:41 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:41 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1342\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:42 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:42 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1343\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:44 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:44 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1344\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:45 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:45 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1345\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:46 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:46 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1346\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:47 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:47 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1347\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:48 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:48 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1348\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:49 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:49 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1349\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:50 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:50 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1350\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:51 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:51 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1351\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:52 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:52 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1352\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:54 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:54 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1353\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:55 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:55 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1354\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:56 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:56 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1355\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:57 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:57 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1356\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:58 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:58 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:58 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1357\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:20:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:20:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:20:59 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:20:59 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1358\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:00 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:00 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:00 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1359\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:01 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:01 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:02 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1360\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:03 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:03 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1361\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:04 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:04 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:04 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1362\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:05 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:05 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1363\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:06 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:06 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1364\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:07 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:07 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1365\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:08 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:08 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:08 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1366\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:09 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:09 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:10 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1367\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:11 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:11 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:11 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1368\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:12 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:12 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:12 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1369\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:13 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:13 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:13 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1370\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:14 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:14 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:14 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1371\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:15 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:15 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:15 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1372\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:16 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:16 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:16 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1373\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:17 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:17 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:18 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1374\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:19 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:19 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1375\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:20 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:20 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1376\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:21 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:21 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1377\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:22 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:22 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1378\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:23 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:23 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1379\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:24 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:24 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1380\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:26 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:26 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1381\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:27 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:27 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1382\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:28 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:28 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1383\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:29 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:29 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1384\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:30 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:30 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1385\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:31 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:31 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:31 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1386\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:33 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:33 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1387\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:34 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:34 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1388\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:35 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:35 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1389\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:36 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:36 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:36 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1390\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:37 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:37 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1391\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:38 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:39 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:39 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1392\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:40 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:40 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1393\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:41 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:41 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1394\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:42 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:42 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1395\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:43 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:44 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1396\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:45 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:45 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1397\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:46 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:46 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1398\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:47 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:47 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1399\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:48 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:48 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1400\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:50 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:50 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1401\",
            \"2006-12-06T01:19:34Z:877607\",
            \"-\"]] 
[02:21:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:51 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:21:51 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"4\",
            \"2006-12-06T01:21:50Z:838726\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1402\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:21:50Z:494528\"]] 
[02:21:51 jpTinit(522)] get_mbs 
[02:21:51 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:21:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:51 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:21:51 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:21:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:52 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:21:52 jpTrpc(218)] sisom rpc \"SIS\" 
[02:21:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:52 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:21:52 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:21:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:52 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:21:53 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:21:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:21:53 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:21:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:21:53 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:21:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:21:54 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:21:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:54 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:21:54 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:21:54 jpTinit(531)] get_mbs \"mp_1\" 
[02:21:54 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:21:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:54 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:21:54 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:21:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:55 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:21:55 jpTrpc(218)] sisom rpc \"SIS\" 
[02:21:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:55 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:21:55 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:21:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:56 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:21:56 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:21:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:21:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:57 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:21:57 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:21:57 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:21:57 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:21:57 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:21:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:21:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:21:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:21:57 jpTrpc(218)] sisom rpc {2,1} 
[02:21:57 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:22:17 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:22:17 jpTrub(306)] pingL mxb 
[02:22:17 jpTnames(217)] Name is  [mxb1,mxb2] Stack [{jpTnames,find_node_name,1},
                            {jpTstates,pingL,1},
                            {jpTrub,rst_active_mxb,0},
                            {jpTrub,is_only,0},
                            {test_server,my_apply,3},
                            {test_server,ts_tc,3},
                            {test_server,run_test_case_eval1,4}] 
[02:22:18 jpTinit(522)] get_mbs 
[02:22:18 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:22:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:18 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:22:18 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:22:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:19 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:22:19 jpTrpc(218)] sisom rpc \"SIS\" 
[02:22:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:19 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:22:19 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:22:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:19 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:22:20 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:22:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:20 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:22:20 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:22:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:20 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:22:20 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:22:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:20 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:22:21 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:22:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:21 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:22:21 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:22:21 jpTinit(531)] get_mbs \"mp_1\" 
[02:22:21 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:22:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:22 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:22:22 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:22:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:22 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:22:22 jpTrpc(218)] sisom rpc \"SIS\" 
[02:22:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:23 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:22:23 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:22:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:23 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:22:23 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:22:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:24 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:22:24 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:22:24 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:22:24 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:22:24 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:22:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:22:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:24 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:22:24 jpTrpc(218)] sisom rpc {2,1} 
[02:22:25 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:22:45 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:22:45 jpTrub(309)] PingL mxb pingE sis
[02:22:45 jpTnames(217)] Name is  [mxb1,mxb2] Stack [{jpTnames,find_node_name,1},
                            {jpTstates,pingL,1},
                            {jpTrub,rst_active_mxb,0},
                            {jpTrub,is_only,0},
                            {test_server,my_apply,3},
                            {test_server,ts_tc,3},
                            {test_server,run_test_case_eval1,4}] 
[02:22:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,pingE,1},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3},
                                      {test_server,run_test_case_eval1,4}] 
[02:22:45 jpTrub(312)] uptime diff mxb 
[02:22:45 jpTstates(649)] Uptime bs = mxb 
[02:22:45 jpTstates(958)] find_snmp_ip  mxb1
[02:22:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:46 jpTrpc(196)] sisom calling module: xom_lib  func: get_ip_addr arg: [0,0]
 [02:22:46 jpTrpc(218)] sisom rpc {169,254,64,3} 
[02:22:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:46 jpTrpc(196)] sisom calling module: xom_snmp  func: sync_get arg: [{169,254,64,3},
                                                     [[1,3,6,1,2,1,1,3,0]]]
 [02:22:46 jpTrpc(218)] sisom rpc {ok,[482442]} 
[02:22:46 jpTstates(687)] uptime mxb Cp  = mxb1 uptime = 4824 
[02:22:46 jpTstates(962)] find_snmp_ip  mxb2
[02:22:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:46 jpTrpc(196)] sisom calling module: xom_lib  func: get_ip_addr arg: [0,25]
 [02:22:47 jpTrpc(218)] sisom rpc {169,254,64,4} 
[02:22:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:47 jpTrpc(196)] sisom calling module: xom_snmp  func: sync_get arg: [{169,254,64,4},
                                                     [[1,3,6,1,2,1,1,3,0]]]
 [02:22:47 jpTrpc(218)] sisom rpc {ok,[11702]} 
[02:22:47 jpTstates(687)] uptime mxb Cp  = mxb2 uptime = 117 
[02:22:47 jpTstates(755)] mxb diff uptime 4707
[02:22:47 jpTstates(766)] check_diff_uptime 4707 300 
[02:22:47 jpTinit(522)] get_mbs 
[02:22:47 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:22:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:48 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:22:48 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:22:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:48 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:22:48 jpTrpc(218)] sisom rpc \"SIS\" 
[02:22:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:49 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:22:49 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:22:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:49 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:22:49 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:22:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:50 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:22:50 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:22:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:50 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:22:50 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:22:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:51 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:22:51 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:22:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:51 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:22:51 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:22:51 jpTinit(531)] get_mbs \"mp_1\" 
[02:22:52 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:22:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:52 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:22:52 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:22:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:52 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:22:53 jpTrpc(218)] sisom rpc \"SIS\" 
[02:22:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:22:53 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:22:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:22:53 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:22:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_active_mxb,0}] 
[02:22:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:54 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:22:54 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:22:54 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:22:54 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:22:54 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:22:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:22:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:22:55 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:22:55 jpTrpc(218)] sisom rpc {2,1} 
[02:22:55 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:23:15 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:23:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_active_mxb,0}] 
[02:23:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:23:45 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:23:45 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"39\",
            \"2006-12-06T01:21:50Z:838726\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1437\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:21:50Z:494528\"]] 
[02:23:45 jpTrub(747)] wait 4 Bs states 
[02:23:55 jpTstates(1197)] wait_for_all_bs N = 1200 Op = 2 Av =  1 
[02:23:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,2},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:23:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:23:56 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:23:56 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:23:56 jpTstates(1203)] wait_for_all_bs N = 120 AllBsNoList = [1,2,3,4,5,6,7] 
[02:23:56 jpTstates(1227)] wait_for_all_bs1 H 1 NokList [] 
[02:23:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:23:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:23:56 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [1]
 [02:23:56 jpTrpc(218)] sisom rpc {2,1} 
[02:23:57 jpTstates(1230)] Op1: 2 av1: 1
[02:23:57 jpTstates(1234)] add_if_not_ok NokList [] 
[02:23:57 jpTstates(1227)] wait_for_all_bs1 H 2 NokList [] 
[02:23:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:23:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:23:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:23:57 jpTrpc(218)] sisom rpc {2,1} 
[02:23:57 jpTstates(1230)] Op1: 2 av1: 1
[02:23:57 jpTstates(1234)] add_if_not_ok NokList [] 
[02:23:58 jpTstates(1227)] wait_for_all_bs1 H 3 NokList [] 
[02:23:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:23:58 jpTrpc(194)] sisom =  sis2@sis2
 [02:23:58 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [3]
 [02:23:58 jpTrpc(218)] sisom rpc {2,1} 
[02:23:58 jpTstates(1230)] Op1: 2 av1: 1
[02:23:58 jpTstates(1234)] add_if_not_ok NokList [] 
[02:23:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:23:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:23:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:23:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:23:59 jpTrpc(218)] sisom rpc {2,1} 
[02:23:59 jpTstates(1230)] Op1: 2 av1: 1
[02:23:59 jpTstates(1234)] add_if_not_ok NokList [] 
[02:24:00 jpTstates(1227)] wait_for_all_bs1 H 5 NokList [] 
[02:24:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:24:00 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [5]
 [02:24:00 jpTrpc(218)] sisom rpc {2,1} 
[02:24:00 jpTstates(1230)] Op1: 2 av1: 1
[02:24:00 jpTstates(1234)] add_if_not_ok NokList [] 
[02:24:00 jpTstates(1227)] wait_for_all_bs1 H 6 NokList [] 
[02:24:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:24:01 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:01 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [6]
 [02:24:01 jpTrpc(218)] sisom rpc {2,1} 
[02:24:01 jpTstates(1230)] Op1: 2 av1: 1
[02:24:01 jpTstates(1234)] add_if_not_ok NokList [] 
[02:24:01 jpTstates(1227)] wait_for_all_bs1 H 7 NokList [] 
[02:24:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:24:02 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:02 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [7]
 [02:24:02 jpTrpc(218)] sisom rpc {2,1} 
[02:24:02 jpTstates(1230)] Op1: 2 av1: 1
[02:24:02 jpTstates(1234)] add_if_not_ok NokList [] 
[02:24:02 jpTrub(752)] All bs is ok 
[02:24:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:02 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:02 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:24:02 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"45\",
            \"2006-12-06T01:21:50Z:838726\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1443\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:21:50Z:494528\"]] 
[02:24:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:24:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:03 jpTrpc(196)] sisom calling module: lanFmDbg  func: reset_mxb_restart_prot arg: []
 [02:24:03 jpTrpc(218)] sisom rpc {atomic,ok} 
[02:24:03 jpTrub(344)] mxbReboot passivmxb 
[02:24:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstartstop,mxbReboot,1},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:24:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,find_mxb_rule,1},
                                      {jpTstartstop,mxbReboot,1},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:24:04 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:04 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:24:04 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"46\",
            \"2006-12-06T01:21:50Z:838726\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1444\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:21:50Z:494528\"]] 
[02:24:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_single,1},
                                      {jpTstates,do_find_mxb_rule,2},
                                      {jpTstartstop,mxbReboot,1},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:04 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:05 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:24:05 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"47\",
            \"2006-12-06T01:21:50Z:838726\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1445\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:21:50Z:494528\"]] 
[02:24:05 jpTstates(417)] Is not running single emty[[\"0\",
                            \"25\",
                            \"passive\",
                            \"no\",
                            \"present\",
                            \"169.254.64.4\",
                            \"46\",
                            \"2006-12-06T01:21:50Z:838726\",
                            \"-\"],
                           [\"0\",
                            \"0\",
                            \"active\",
                            \"yes\",
                            \"present\",
                            \"169.254.64.3\",
                            \"1444\",
                            \"2006-12-06T01:19:34Z:877607\",
                            \"2006-12-06T01:21:50Z:494528\"]] 
[02:24:05 jpTnames(217)] Name is  mxb2 Stack [{jpTnames,find_node_name,1},
                     {jpTstartstop,mxbReboot,1},
                     {jpTrub,rst_passiv_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3},
                     {test_server,run_test_case_eval1,4}] 
[02:24:05 jpTnames(217)] Name is  mxb2 Stack [{jpTnames,find_node_name,1},
                     {jpTstates,pingL,1},
                     {jpTstartstop,mxbReboot1,1},
                     {jpTrub,rst_passiv_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3}] 
[02:24:05 jpTnames(217)] Name is  mxb2 Stack [{jpTnames,find_node_name,1},
                     {jpTmxbOs,rst,1},
                     {jpTstartstop,do_mxbReboot,1},
                     {jpTstartstop,mxbReboot1,1},
                     {jpTrub,rst_passiv_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3}] 
[02:24:06 jpTmxbOs(474)] rst Mxb  mxb2
[02:24:06 jpTmxbOs(484)] rst cmd \"do_mxb.exp mxb2 tre,14 rst\"
[02:24:06 jpTmxbOs(486)] disable_mxb_isol_check 
[02:24:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTmxbOs,do_rst,2},
                                      {jpTstartstop,do_mxbReboot,1},
                                      {jpTstartstop,mxbReboot1,1},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:06 jpTrpc(196)] sisom calling module: lanFmDbg  func: disable_mxb_isol_check arg: []
 [02:24:06 jpTrpc(218)] sisom rpc ok 
[02:24:07 jpTmxbOs(489)] reset_mxb_restart_prot 
[02:24:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTmxbOs,do_rst,2},
                                      {jpTstartstop,do_mxbReboot,1},
                                      {jpTstartstop,mxbReboot1,1},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:07 jpTrpc(196)] sisom calling module: lanFmDbg  func: reset_mxb_restart_prot arg: []
 [02:24:07 jpTrpc(218)] sisom rpc {atomic,ok} 
[02:24:10 jpTmxbOs(499)] cmd data \"\n\" 
[02:24:10 jpTrub(346)] is_running_single mxb 
[02:24:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:40 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:24:40 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1455\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:24:40 jpTstates(554)] If running single 
[02:24:40 jpTrub(349)] is_running_dual mxb 
[02:24:40 jpTinit(522)] get_mbs 
[02:24:40 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:24:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:24:41 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:24:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:24:42 jpTrpc(218)] sisom rpc \"SIS\" 
[02:24:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:24:42 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:24:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:24:43 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:24:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:43 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:24:43 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:24:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:43 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:24:44 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:24:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:44 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:24:44 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:24:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:45 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:24:45 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:24:45 jpTinit(531)] get_mbs \"mp_1\" 
[02:24:45 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:24:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:45 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:24:45 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:24:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:46 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:24:46 jpTrpc(218)] sisom rpc \"SIS\" 
[02:24:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:46 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:24:47 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:24:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:47 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:24:47 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:24:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:24:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:48 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:24:48 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:24:48 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:24:48 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:24:48 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:24:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:24:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:24:49 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:24:49 jpTrpc(218)] sisom rpc {2,1} 
[02:24:49 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:25:09 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:25:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:39 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:39 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1473\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:41 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:41 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1474\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:42 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:42 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1475\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:43 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:44 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1476\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:45 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:45 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1477\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:46 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:47 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1478\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:48 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:48 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1479\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:49 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:49 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1480\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:51 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:51 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1481\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:52 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:52 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1482\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:53 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:54 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1483\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:55 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:55 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1484\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:56 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:56 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1485\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:58 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:58 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:58 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1486\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:25:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:25:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:25:59 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:25:59 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1487\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:01 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:01 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:01 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1488\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:02 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:02 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:02 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1489\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:04 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:04 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1490\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:05 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:05 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1491\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:06 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:06 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1492\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:08 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:08 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:08 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1493\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:09 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:10 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:10 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1494\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:11 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:11 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:11 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1495\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:12 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:12 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:13 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1496\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:14 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:14 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:14 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1497\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:15 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:15 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:16 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1498\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:17 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:17 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:17 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1499\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:18 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:18 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1500\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:20 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:20 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1501\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:21 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:21 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1502\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:23 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:23 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1503\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:24 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:24 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1504\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:26 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:26 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1505\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:27 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:27 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1506\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:29 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:29 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1507\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:30 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:30 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1508\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:32 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:32 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1509\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:33 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:33 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1510\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:35 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:35 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1511\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:36 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:36 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:36 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1512\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:38 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:38 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1513\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:39 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:39 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1514\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:40 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:41 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1515\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:42 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:42 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1516\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:44 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:44 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1517\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:45 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:45 jpTrpc(218)] sisom rpc [[\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"absent\",
            \"169.254.64.3\",
            \"1518\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:24:28Z:495097\"]] 
[02:26:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:47 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:26:47 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"3\",
            \"2006-12-06T01:26:46Z:824903\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1519\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:26:46Z:498181\"]] 
[02:26:47 jpTrub(353)] pingL mxb 
[02:26:47 jpTnames(217)] Name is  [mxb1,mxb2] Stack [{jpTnames,find_node_name,1},
                            {jpTstates,pingL,1},
                            {jpTrub,rst_passiv_mxb,0},
                            {jpTrub,is_only,0},
                            {test_server,my_apply,3},
                            {test_server,ts_tc,3},
                            {test_server,run_test_case_eval1,4}] 
[02:26:48 jpTrub(355)] PingL mxb pingE sis
[02:26:48 jpTinit(522)] get_mbs 
[02:26:48 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:26:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:48 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:26:49 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:26:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:49 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:26:49 jpTrpc(218)] sisom rpc \"SIS\" 
[02:26:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:50 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:26:50 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:26:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:50 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:26:51 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:26:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:51 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:26:51 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:26:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:52 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:26:52 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:26:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:26:53 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:26:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:26:54 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:26:54 jpTinit(531)] get_mbs \"mp_1\" 
[02:26:54 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:26:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:54 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:26:55 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:26:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:55 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:26:55 jpTrpc(218)] sisom rpc \"SIS\" 
[02:26:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:56 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:26:56 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:26:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:57 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:26:57 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:26:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:26:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:58 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:26:58 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:26:58 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:26:58 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:26:58 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:26:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:26:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:26:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:26:59 jpTrpc(218)] sisom rpc {2,1} 
[02:26:59 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:27:19 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:27:19 jpTnames(217)] Name is  [mxb1,mxb2] Stack [{jpTnames,find_node_name,1},
                            {jpTstates,pingL,1},
                            {jpTrub,rst_passiv_mxb,0},
                            {jpTrub,is_only,0},
                            {test_server,my_apply,3},
                            {test_server,ts_tc,3},
                            {test_server,run_test_case_eval1,4}] 
[02:27:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,pingE,1},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3},
                                      {test_server,run_test_case_eval1,4}] 
[02:27:20 jpTrub(359)] uptime diff mxb 
[02:27:20 jpTstates(649)] Uptime bs = mxb 
[02:27:20 jpTstates(958)] find_snmp_ip  mxb1
[02:27:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:21 jpTrpc(196)] sisom calling module: xom_lib  func: get_ip_addr arg: [0,0]
 [02:27:21 jpTrpc(218)] sisom rpc {169,254,64,3} 
[02:27:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:22 jpTrpc(196)] sisom calling module: xom_snmp  func: sync_get arg: [{169,254,64,3},
                                                     [[1,3,6,1,2,1,1,3,0]]]
 [02:27:22 jpTrpc(218)] sisom rpc {ok,[510000]} 
[02:27:22 jpTstates(687)] uptime mxb Cp  = mxb1 uptime = 5100 
[02:27:22 jpTstates(962)] find_snmp_ip  mxb2
[02:27:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:23 jpTrpc(196)] sisom calling module: xom_lib  func: get_ip_addr arg: [0,25]
 [02:27:23 jpTrpc(218)] sisom rpc {169,254,64,4} 
[02:27:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,uptime_mxb,1},
                                      {jpTstates,uptime,1},
                                      {jpTstates,diff_uptime,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:23 jpTrpc(196)] sisom calling module: xom_snmp  func: sync_get arg: [{169,254,64,4},
                                                     [[1,3,6,1,2,1,1,3,0]]]
 [02:27:24 jpTrpc(218)] sisom rpc {ok,[9774]} 
[02:27:24 jpTstates(687)] uptime mxb Cp  = mxb2 uptime = 97 
[02:27:24 jpTstates(755)] mxb diff uptime 5003
[02:27:25 jpTstates(766)] check_diff_uptime 5003 300 
[02:27:25 jpTinit(522)] get_mbs 
[02:27:25 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:27:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:25 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:27:26 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:27:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:26 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:27:26 jpTrpc(218)] sisom rpc \"SIS\" 
[02:27:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:27 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:27:27 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:27:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:28 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:27:28 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:27:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:29 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:27:29 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:27:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:30 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:27:30 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:27:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:30 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:27:31 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:27:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:31 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:31 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:27:31 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:27:32 jpTinit(531)] get_mbs \"mp_1\" 
[02:27:32 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:27:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:32 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:27:32 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:27:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:33 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:27:33 jpTrpc(218)] sisom rpc \"SIS\" 
[02:27:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:34 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:27:34 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:27:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:35 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:27:35 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:27:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:27:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:36 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:27:36 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:27:36 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:27:36 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:27:36 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:27:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:27:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:27:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:27:37 jpTrpc(218)] sisom rpc {2,1} 
[02:27:37 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:27:57 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:28:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,rst_passiv_mxb,0}] 
[02:28:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:28 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:28:28 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"34\",
            \"2006-12-06T01:26:46Z:824903\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1550\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:26:46Z:498181\"]] 
[02:28:28 jpTrub(747)] wait 4 Bs states 
[02:28:39 jpTstates(1197)] wait_for_all_bs N = 1200 Op = 2 Av =  1 
[02:28:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,2},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:39 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:28:40 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:28:40 jpTstates(1203)] wait_for_all_bs N = 120 AllBsNoList = [1,2,3,4,5,6,7] 
[02:28:40 jpTstates(1227)] wait_for_all_bs1 H 1 NokList [] 
[02:28:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [1]
 [02:28:41 jpTrpc(218)] sisom rpc {2,1} 
[02:28:41 jpTstates(1230)] Op1: 2 av1: 1
[02:28:41 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:41 jpTstates(1227)] wait_for_all_bs1 H 2 NokList [] 
[02:28:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:28:42 jpTrpc(218)] sisom rpc {2,1} 
[02:28:42 jpTstates(1230)] Op1: 2 av1: 1
[02:28:42 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:42 jpTstates(1227)] wait_for_all_bs1 H 3 NokList [] 
[02:28:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:43 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [3]
 [02:28:43 jpTrpc(218)] sisom rpc {2,1} 
[02:28:43 jpTstates(1230)] Op1: 2 av1: 1
[02:28:43 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:44 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:28:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:45 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:28:45 jpTrpc(218)] sisom rpc {2,1} 
[02:28:45 jpTstates(1230)] Op1: 2 av1: 1
[02:28:45 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:45 jpTstates(1227)] wait_for_all_bs1 H 5 NokList [] 
[02:28:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [5]
 [02:28:46 jpTrpc(218)] sisom rpc {2,1} 
[02:28:46 jpTstates(1230)] Op1: 2 av1: 1
[02:28:46 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:47 jpTstates(1227)] wait_for_all_bs1 H 6 NokList [] 
[02:28:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:47 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [6]
 [02:28:47 jpTrpc(218)] sisom rpc {2,1} 
[02:28:48 jpTstates(1230)] Op1: 2 av1: 1
[02:28:48 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:48 jpTstates(1227)] wait_for_all_bs1 H 7 NokList [] 
[02:28:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,rst_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [7]
 [02:28:49 jpTrpc(218)] sisom rpc {2,1} 
[02:28:49 jpTstates(1230)] Op1: 2 av1: 1
[02:28:49 jpTstates(1234)] add_if_not_ok NokList [] 
[02:28:49 jpTrub(752)] All bs is ok 
[02:28:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:28:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:50 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:28:50 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"41\",
            \"2006-12-06T01:26:46Z:824903\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1557\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:26:46Z:498181\"]] 
[02:28:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:28:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,find_mxb_rule,1},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:28:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:51 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:28:51 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"42\",
            \"2006-12-06T01:26:46Z:824903\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1558\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:26:46Z:498181\"]] 
[02:28:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_single,1},
                                      {jpTstates,do_find_mxb_rule,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:52 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:28:52 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.4\",
            \"43\",
            \"2006-12-06T01:26:46Z:824903\",
            \"-\"],
           [\"0\",
            \"0\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.3\",
            \"1559\",
            \"2006-12-06T01:19:34Z:877607\",
            \"2006-12-06T01:26:46Z:498181\"]] 
[02:28:52 jpTstates(417)] Is not running single emty[[\"0\",
                            \"25\",
                            \"passive\",
                            \"no\",
                            \"present\",
                            \"169.254.64.4\",
                            \"42\",
                            \"2006-12-06T01:26:46Z:824903\",
                            \"-\"],
                           [\"0\",
                            \"0\",
                            \"active\",
                            \"yes\",
                            \"present\",
                            \"169.254.64.3\",
                            \"1558\",
                            \"2006-12-06T01:19:34Z:877607\",
                            \"2006-12-06T01:26:46Z:498181\"]] 
[02:28:53 jpTnames(217)] Name is  mxb1 Stack [{jpTnames,find_node_name,1},
                     {jpTrub,lock_un_active_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3},
                     {test_server,run_test_case_eval1,4},
                     {test_server,run_test_case_eval,6}] 
[02:28:53 jpTrub(390)] lock_un_active_mxb active mxb1 
[02:28:53 jpTrub(393)] lock_un_active_mxb \"MXB slot 0\" will bee locked 
[02:28:53 jpTchange_states(226)] lock bs Ownname \"MXB slot 0\" 
[02:28:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:54 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:28:54 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:28:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:28:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:55 jpTrpc(196)] sisom calling module: simGui  func: lock_bs arg: [\"MXB slot 0\"]
 [02:28:55 jpTrpc(200)] go simGui
[02:28:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:28:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:56 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:28:56 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:28:56 jpTrpc(208)] simGui rpc ok 
[02:28:56 jpTstates(1259)]  wait_for_bs 60sec OwnName = \"MXB slot 0\" {Op,Av} = {1,3} 
[02:28:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:28:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:28:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:28:57 jpTrpc(218)] sisom rpc {1,3} 
[02:28:57 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"MXB slot 0\"{Op,Av}: {1,3} == {1,3} 
[02:29:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:29:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:18 jpTrpc(196)] sisom calling module: lanFmDbg  func: reset_mxb_restart_prot arg: []
 [02:29:18 jpTrpc(218)] sisom rpc {atomic,ok} 
[02:29:18 jpTrub(397)] lock_un_active_mxb mxb1 is locked 
[02:29:18 jpTinit(522)] get_mbs 
[02:29:18 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:29:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:19 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:29:19 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:29:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:20 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:29:20 jpTrpc(218)] sisom rpc \"SIS\" 
[02:29:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:21 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:29:21 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:29:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:22 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:29:22 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:29:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:23 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:29:23 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:29:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:24 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:29:24 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:29:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:24 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:29:25 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:29:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:25 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:29:25 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:29:26 jpTinit(531)] get_mbs \"mp_1\" 
[02:29:26 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:29:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:26 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:29:27 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:29:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:27 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:29:28 jpTrpc(218)] sisom rpc \"SIS\" 
[02:29:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:29 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:29:29 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:29:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:29 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:29:30 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:29:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:29:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:30 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:29:30 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:29:31 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:29:31 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:29:31 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:29:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:29:31 jpTrpc(194)] sisom =  sis2@sis2
 [02:29:31 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:29:32 jpTrpc(218)] sisom rpc {2,1} 
[02:29:32 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:29:52 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:29:52 jpTrub(400)] checking Mxb  \"MXB slot 0\" Bs states 
[02:30:22 jpTstates(1259)]  wait_for_bs 60sec OwnName = \"MXB slot 0\" {Op,Av} = {1,3} 
[02:30:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:30:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:30:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:30:23 jpTrpc(218)] sisom rpc {1,3} 
[02:30:23 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"MXB slot 0\"{Op,Av}: {1,3} == {1,3} 
[02:30:43 jpTrub(404)]  mxb1 is locked will bee unlocked 
[02:31:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:31:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:31:44 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:31:44 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:31:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:31:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:31:45 jpTrpc(196)] sisom calling module: simGui  func: unlock_bs arg: [\"MXB slot 0\"]
 [02:31:45 jpTrpc(200)] go simGui
[02:31:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:31:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:31:46 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:31:46 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:31:46 jpTrpc(208)] simGui rpc ok 
[02:31:57 jpTpassWdfix(401)] is the door open on \"MXB slot 0\"
[02:31:57 jpTpassWdfix(405)] This is not a erl bs \"MXB slot 0\"
[02:31:57 jpTchange_states(334)] going 2 copy_patches with \"MXB slot 0\"  
[02:31:57 jpTstates(1259)]  wait_for_bs 600sec OwnName = \"MXB slot 0\" {Op,Av} = {2,1} 
[02:31:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:31:58 jpTrpc(194)] sisom =  sis2@sis2
 [02:31:58 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:31:58 jpTrpc(218)] sisom rpc {1,7} 
[02:31:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:00 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:00 jpTrpc(218)] sisom rpc {1,7} 
[02:32:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:01 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:02 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:02 jpTrpc(218)] sisom rpc {1,7} 
[02:32:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:03 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:03 jpTrpc(218)] sisom rpc {1,7} 
[02:32:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:05 jpTrpc(218)] sisom rpc {1,7} 
[02:32:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:07 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:07 jpTrpc(218)] sisom rpc {1,7} 
[02:32:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:08 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:08 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:08 jpTrpc(218)] sisom rpc {1,7} 
[02:32:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:10 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:10 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:10 jpTrpc(218)] sisom rpc {1,7} 
[02:32:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:11 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:12 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:12 jpTrpc(218)] sisom rpc {1,7} 
[02:32:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:13 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:13 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:14 jpTrpc(218)] sisom rpc {1,7} 
[02:32:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:15 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:15 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:15 jpTrpc(218)] sisom rpc {1,7} 
[02:32:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:17 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:17 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:17 jpTrpc(218)] sisom rpc {1,7} 
[02:32:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:18 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:19 jpTrpc(218)] sisom rpc {1,7} 
[02:32:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:20 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:20 jpTrpc(218)] sisom rpc {1,7} 
[02:32:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:22 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:22 jpTrpc(218)] sisom rpc {1,7} 
[02:32:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:24 jpTrpc(218)] sisom rpc {1,7} 
[02:32:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:25 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:25 jpTrpc(218)] sisom rpc {1,7} 
[02:32:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:27 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:27 jpTrpc(218)] sisom rpc {1,7} 
[02:32:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:29 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:29 jpTrpc(218)] sisom rpc {1,7} 
[02:32:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:30 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:30 jpTrpc(218)] sisom rpc {1,7} 
[02:32:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:32 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:32 jpTrpc(218)] sisom rpc {1,7} 
[02:32:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:34 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:34 jpTrpc(218)] sisom rpc {1,7} 
[02:32:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:35 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:36 jpTrpc(218)] sisom rpc {1,7} 
[02:32:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:37 jpTrpc(218)] sisom rpc {1,7} 
[02:32:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:38 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:39 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:39 jpTrpc(218)] sisom rpc {1,7} 
[02:32:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:41 jpTrpc(218)] sisom rpc {1,7} 
[02:32:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:42 jpTrpc(218)] sisom rpc {1,7} 
[02:32:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:44 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:44 jpTrpc(218)] sisom rpc {1,7} 
[02:32:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:46 jpTrpc(218)] sisom rpc {1,7} 
[02:32:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:48 jpTrpc(218)] sisom rpc {1,7} 
[02:32:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:50 jpTrpc(218)] sisom rpc {1,7} 
[02:32:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:51 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:52 jpTrpc(218)] sisom rpc {1,7} 
[02:32:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:53 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:53 jpTrpc(218)] sisom rpc {1,7} 
[02:32:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:55 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:55 jpTrpc(218)] sisom rpc {1,7} 
[02:32:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:57 jpTrpc(218)] sisom rpc {1,7} 
[02:32:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:32:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:32:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:32:59 jpTrpc(218)] sisom rpc {1,7} 
[02:33:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:00 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:01 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:01 jpTrpc(218)] sisom rpc {1,7} 
[02:33:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:02 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:03 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:03 jpTrpc(218)] sisom rpc {1,7} 
[02:33:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:04 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:04 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:05 jpTrpc(218)] sisom rpc {1,7} 
[02:33:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:06 jpTrpc(218)] sisom rpc {1,7} 
[02:33:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:08 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:08 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:08 jpTrpc(218)] sisom rpc {1,7} 
[02:33:10 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:10 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:10 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:10 jpTrpc(218)] sisom rpc {1,7} 
[02:33:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:11 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:12 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:12 jpTrpc(218)] sisom rpc {1,7} 
[02:33:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:13 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:14 jpTrpc(218)] sisom rpc {1,7} 
[02:33:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:15 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:15 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:16 jpTrpc(218)] sisom rpc {1,7} 
[02:33:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:17 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:17 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:17 jpTrpc(218)] sisom rpc {1,7} 
[02:33:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:19 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:19 jpTrpc(218)] sisom rpc {1,7} 
[02:33:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:21 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:21 jpTrpc(218)] sisom rpc {1,7} 
[02:33:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:23 jpTrpc(218)] sisom rpc {1,7} 
[02:33:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:24 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:25 jpTrpc(218)] sisom rpc {1,7} 
[02:33:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:26 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:27 jpTrpc(218)] sisom rpc {1,7} 
[02:33:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:28 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:28 jpTrpc(218)] sisom rpc {1,7} 
[02:33:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:30 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:30 jpTrpc(218)] sisom rpc {1,7} 
[02:33:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:32 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:32 jpTrpc(218)] sisom rpc {1,7} 
[02:33:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:34 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:34 jpTrpc(218)] sisom rpc {1,7} 
[02:33:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:36 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:36 jpTrpc(218)] sisom rpc {1,7} 
[02:33:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:38 jpTrpc(218)] sisom rpc {1,7} 
[02:33:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:39 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:39 jpTrpc(218)] sisom rpc {1,7} 
[02:33:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:41 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:41 jpTrpc(218)] sisom rpc {1,7} 
[02:33:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:43 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:43 jpTrpc(218)] sisom rpc {1,7} 
[02:33:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:45 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:45 jpTrpc(218)] sisom rpc {1,7} 
[02:33:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:47 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:47 jpTrpc(218)] sisom rpc {1,7} 
[02:33:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:33:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:33:49 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:33:49 jpTrpc(218)] sisom rpc {2,1} 
[02:33:49 jpTstates(1266)] wait_for_bs after 62sec OwnName = \"MXB slot 0\"{Op,Av}: {2,1} == {2,1} 
[02:34:09 jpTrpc(279)] safesisom calling module: hwmI  func: get_all_bs_id_and_name 
[02:34:10 jpTrpc(284)] safesisom calling module: hwmI  func: get_all_bs_id_and_name arg: [] 
[02:34:10 jpTrpc(302)] sisom calling module: hwmI  func: get_all_bs_id_and_name arg: [] 
[02:34:10 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,pingE,1},
                                      {jpTrpc,impl_sisom,3},
                                      {jpTrpc,safesisom,4},
                                      {jpTnames,build_table,0},
                                      {jpTnames,update,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTrpc,impl_sisom,3},
                                      {jpTrpc,safesisom,4},
                                      {jpTnames,build_table,0},
                                      {jpTnames,update,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:34:11 jpTrpc(308)] sisom erlnode [sis1@sis1,sis2@sis2] 
[02:34:11 jpTrpc(401)] sisom Head sis1@sis1
[02:34:11 jpTrpc(401)] sisom Head sis2@sis2
[02:34:12 jpTrpc(310)] sisom omcp sis2@sis2 
[02:34:12 jpTnames(1132)] HwmBsIdList is  [{\"SIS\",\"bs_SIS_1\"},
                 {\"MXB slot 0\",\"bs_MXB_2\"},
                 {\"MXB slot 25\",\"bs_MXB_3\"},
                 {\"mgw_1\",\"bs_MGW_4\"},
                 {\"cer_1\",\"bs_ISER_5\"},
                 {\"exb_2\",\"bs_EXB_7\"},
                 {\"exb_1\",\"bs_EXB_6\"}] 
[02:34:12 jpTnames(1200)] H is: [{name,\"SIS\"},{slotSubrack,[{0,1},{0,13}]},{hostname,[sis1,sis2]}]
[02:34:12 jpTnames(1200)] H is: [{name,\"MXB slot 0\"},{slotSubrack,[{0,0}]},{hostname,[mxb1]}]
[02:34:12 jpTnames(1200)] H is: [{name,\"MXB slot 25\"},{slotSubrack,[{0,25}]},{hostname,[mxb2]}]
[02:34:12 jpTnames(1200)] H is: [{name,\"mp_1\"},
       {slotSubrack,[{0,6},{0,21}]},
       {hostname,[blade_0_6,blade_0_21]}]
[02:34:13 jpTnames(1200)] H is: [{name,\"mgw_1\"},
       {slotSubrack,[{0,15},{0,19}]},
       {hostname,[blade_0_15,blade_0_19]}]
[02:34:13 jpTnames(1200)] H is: [{name,\"exb_1\"},{slotSubrack,[{0,5}]},{hostname,[blade_0_5]}]
[02:34:13 jpTnames(1200)] H is: [{name,\"exb_2\"},{slotSubrack,[{0,24}]},{hostname,[blade_0_24]}]
[02:34:14 jpTnames(1200)] H is: [{name,\"cer_1\"},{slotSubrack,[{0,22}]},{hostname,[blade_0_22]}]
[02:34:14 jpTnames(1158)] Cannot create an erlang cookie from BsId: null, BsNo: null 
[02:34:14 jpTnames(1160)] You may have to run jpTnames:update()
[02:34:14 jpTnames(1119)] Updating jpTnames translation table.
[02:34:15 jpTinit(522)] get_mbs 
[02:34:15 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:34:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:15 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:16 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:34:16 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:34:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:16 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:17 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:34:17 jpTrpc(218)] sisom rpc \"SIS\" 
[02:34:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:17 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:18 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:34:18 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:34:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:19 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:34:19 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:34:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:20 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:34:20 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:34:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:21 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:34:21 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:34:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:22 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:34:22 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:34:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:23 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:34:23 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:34:24 jpTinit(531)] get_mbs \"mp_1\" 
[02:34:24 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:34:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:25 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:34:25 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:34:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:26 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:34:26 jpTrpc(218)] sisom rpc \"SIS\" 
[02:34:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:27 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:34:27 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:34:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:28 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:34:28 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:34:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:34:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:29 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:34:29 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:34:29 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:34:30 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:34:30 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:34:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:34:31 jpTrpc(194)] sisom =  sis2@sis2
 [02:34:31 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:34:31 jpTrpc(218)] sisom rpc {2,1} 
[02:34:31 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:34:51 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:35:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,lock_un_active_mxb,0}] 
[02:35:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:22 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:35:22 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"158\",
            \"2006-12-06T01:29:20Z:824488\",
            \"2006-12-06T01:33:59Z:023879\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"25\",
            \"2006-12-06T01:34:00Z:460779\",
            \"-\"]] 
[02:35:22 jpTrub(747)] wait 4 Bs states 
[02:35:33 jpTstates(1197)] wait_for_all_bs N = 1200 Op = 2 Av =  1 
[02:35:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,2},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:33 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:35:34 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:35:34 jpTstates(1203)] wait_for_all_bs N = 120 AllBsNoList = [1,2,3,4,5,6,7] 
[02:35:35 jpTstates(1227)] wait_for_all_bs1 H 1 NokList [] 
[02:35:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:35 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [1]
 [02:35:36 jpTrpc(218)] sisom rpc {2,1} 
[02:35:36 jpTstates(1230)] Op1: 2 av1: 1
[02:35:36 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:36 jpTstates(1227)] wait_for_all_bs1 H 2 NokList [] 
[02:35:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:35:37 jpTrpc(218)] sisom rpc {2,1} 
[02:35:38 jpTstates(1230)] Op1: 2 av1: 1
[02:35:38 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:38 jpTstates(1227)] wait_for_all_bs1 H 3 NokList [] 
[02:35:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:39 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [3]
 [02:35:40 jpTrpc(218)] sisom rpc {2,1} 
[02:35:40 jpTstates(1230)] Op1: 2 av1: 1
[02:35:40 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:40 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:35:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:41 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:35:41 jpTrpc(218)] sisom rpc {2,1} 
[02:35:42 jpTstates(1230)] Op1: 2 av1: 1
[02:35:42 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:42 jpTstates(1227)] wait_for_all_bs1 H 5 NokList [] 
[02:35:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:43 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [5]
 [02:35:43 jpTrpc(218)] sisom rpc {2,1} 
[02:35:43 jpTstates(1230)] Op1: 2 av1: 1
[02:35:44 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:45 jpTstates(1227)] wait_for_all_bs1 H 6 NokList [] 
[02:35:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:45 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [6]
 [02:35:45 jpTrpc(218)] sisom rpc {2,1} 
[02:35:46 jpTstates(1230)] Op1: 2 av1: 1
[02:35:46 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:46 jpTstates(1227)] wait_for_all_bs1 H 7 NokList [] 
[02:35:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_active_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:47 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [7]
 [02:35:47 jpTrpc(218)] sisom rpc {2,1} 
[02:35:48 jpTstates(1230)] Op1: 2 av1: 1
[02:35:48 jpTstates(1234)] add_if_not_ok NokList [] 
[02:35:48 jpTrub(752)] All bs is ok 
[02:35:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:35:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:49 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:35:49 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"167\",
            \"2006-12-06T01:29:20Z:824488\",
            \"2006-12-06T01:33:59Z:023879\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"34\",
            \"2006-12-06T01:34:00Z:460779\",
            \"-\"]] 
[02:35:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:35:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,find_mxb_rule,1},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:35:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:50 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:35:51 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"168\",
            \"2006-12-06T01:29:20Z:824488\",
            \"2006-12-06T01:33:59Z:023879\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"35\",
            \"2006-12-06T01:34:00Z:460779\",
            \"-\"]] 
[02:35:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_single,1},
                                      {jpTstates,do_find_mxb_rule,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:52 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:35:52 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"169\",
            \"2006-12-06T01:29:20Z:824488\",
            \"2006-12-06T01:33:59Z:023879\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"36\",
            \"2006-12-06T01:34:00Z:460779\",
            \"-\"]] 
[02:35:52 jpTstates(417)] Is not running single emty[[\"0\",
                            \"25\",
                            \"active\",
                            \"yes\",
                            \"present\",
                            \"169.254.64.4\",
                            \"168\",
                            \"2006-12-06T01:29:20Z:824488\",
                            \"2006-12-06T01:33:59Z:023879\"],
                           [\"0\",
                            \"0\",
                            \"passive\",
                            \"no\",
                            \"present\",
                            \"169.254.64.3\",
                            \"35\",
                            \"2006-12-06T01:34:00Z:460779\",
                            \"-\"]] 
[02:35:53 jpTnames(217)] Name is  mxb1 Stack [{jpTnames,find_node_name,1},
                     {jpTrub,lock_un_passiv_mxb,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3},
                     {test_server,run_test_case_eval1,4},
                     {test_server,run_test_case_eval,6}] 
[02:35:53 jpTrub(436)] lock_un_active_mxb passiv mxb1 
[02:35:53 jpTrub(439)] lock_un_passiv_mxb \"MXB slot 0\" will bee locked 
[02:35:53 jpTchange_states(226)] lock bs Ownname \"MXB slot 0\" 
[02:35:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:54 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:35:54 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:35:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:35:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:55 jpTrpc(196)] sisom calling module: simGui  func: lock_bs arg: [\"MXB slot 0\"]
 [02:35:56 jpTrpc(200)] go simGui
[02:35:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:35:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:57 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:35:57 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:35:57 jpTrpc(208)] simGui rpc ok 
[02:35:57 jpTstates(1259)]  wait_for_bs 60sec OwnName = \"MXB slot 0\" {Op,Av} = {1,3} 
[02:35:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTchange_states,lock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:35:58 jpTrpc(194)] sisom =  sis2@sis2
 [02:35:58 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:35:58 jpTrpc(218)] sisom rpc {1,3} 
[02:35:59 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"MXB slot 0\"{Op,Av}: {1,3} == {1,3} 
[02:36:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:36:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:19 jpTrpc(196)] sisom calling module: lanFmDbg  func: reset_mxb_restart_prot arg: []
 [02:36:19 jpTrpc(218)] sisom rpc {atomic,ok} 
[02:36:20 jpTrub(443)] lock_un_passiv_mxb mxb1 is locked 
[02:36:20 jpTinit(522)] get_mbs 
[02:36:20 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:36:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:21 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:36:22 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:36:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:23 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:36:23 jpTrpc(218)] sisom rpc \"SIS\" 
[02:36:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:23 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:36:24 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:36:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:24 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:25 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:36:25 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:36:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:26 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:36:26 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:36:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:27 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:36:27 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:36:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:28 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:36:29 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:36:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:29 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:36:30 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:36:30 jpTinit(531)] get_mbs \"mp_1\" 
[02:36:30 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:36:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:31 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:31 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:36:31 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:36:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:32 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:36:33 jpTrpc(218)] sisom rpc \"SIS\" 
[02:36:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:34 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:36:34 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:36:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:35 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:36:35 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:36:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:36:36 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:36 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:36:36 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:36:37 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:36:37 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:36:37 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:36:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:36:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:36:38 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:36:38 jpTrpc(218)] sisom rpc {2,1} 
[02:36:39 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:36:59 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:36:59 jpTrub(446)] checking Mxb  \"MXB slot 0\" Bs states 
[02:37:29 jpTstates(1259)]  wait_for_bs 60sec OwnName = \"MXB slot 0\" {Op,Av} = {1,3} 
[02:37:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:37:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:37:30 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:37:30 jpTrpc(218)] sisom rpc {1,3} 
[02:37:31 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"MXB slot 0\"{Op,Av}: {1,3} == {1,3} 
[02:37:51 jpTrub(450)]  mxb1 is locked will bee unlocked 
[02:38:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:38:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:38:51 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:38:52 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:38:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:38:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:38:53 jpTrpc(196)] sisom calling module: simGui  func: unlock_bs arg: [\"MXB slot 0\"]
 [02:38:53 jpTrpc(200)] go simGui
[02:38:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTutil,go_simGui,0},
                                      {jpTrpc,sisom,3},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:38:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:38:54 jpTrpc(196)] sisom calling module: code  func: is_loaded arg: [simGui]
 [02:38:54 jpTrpc(218)] sisom rpc {file,\"/private/bs_SIS_1/sis_dev_patches/simGui.beam\"} 
[02:38:54 jpTrpc(208)] simGui rpc ok 
[02:39:05 jpTpassWdfix(401)] is the door open on \"MXB slot 0\"
[02:39:05 jpTpassWdfix(405)] This is not a erl bs \"MXB slot 0\"
[02:39:05 jpTchange_states(334)] going 2 copy_patches with \"MXB slot 0\"  
[02:39:05 jpTstates(1259)]  wait_for_bs 600sec OwnName = \"MXB slot 0\" {Op,Av} = {2,1} 
[02:39:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:06 jpTrpc(218)] sisom rpc {1,7} 
[02:39:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:08 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:08 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:08 jpTrpc(218)] sisom rpc {1,7} 
[02:39:10 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:10 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:10 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:10 jpTrpc(218)] sisom rpc {1,7} 
[02:39:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:12 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:12 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:12 jpTrpc(218)] sisom rpc {1,7} 
[02:39:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:14 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:14 jpTrpc(218)] sisom rpc {1,7} 
[02:39:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:16 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:16 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:16 jpTrpc(218)] sisom rpc {1,7} 
[02:39:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:18 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:18 jpTrpc(218)] sisom rpc {1,7} 
[02:39:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:20 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:20 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:20 jpTrpc(218)] sisom rpc {1,7} 
[02:39:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:22 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:22 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:22 jpTrpc(218)] sisom rpc {1,7} 
[02:39:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:24 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:24 jpTrpc(218)] sisom rpc {1,7} 
[02:39:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:26 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:26 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:26 jpTrpc(218)] sisom rpc {1,7} 
[02:39:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:28 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:28 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:28 jpTrpc(218)] sisom rpc {1,7} 
[02:39:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:30 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:30 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:31 jpTrpc(218)] sisom rpc {1,7} 
[02:39:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:32 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:32 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:32 jpTrpc(218)] sisom rpc {1,7} 
[02:39:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:34 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:34 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:35 jpTrpc(218)] sisom rpc {1,7} 
[02:39:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:36 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:36 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:37 jpTrpc(218)] sisom rpc {1,7} 
[02:39:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:38 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:38 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:38 jpTrpc(218)] sisom rpc {1,7} 
[02:39:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:40 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:41 jpTrpc(218)] sisom rpc {1,7} 
[02:39:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:43 jpTrpc(218)] sisom rpc {1,7} 
[02:39:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:44 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:44 jpTrpc(218)] sisom rpc {1,7} 
[02:39:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:46 jpTrpc(218)] sisom rpc {1,7} 
[02:39:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:48 jpTrpc(218)] sisom rpc {1,7} 
[02:39:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:50 jpTrpc(218)] sisom rpc {1,7} 
[02:39:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:53 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:53 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:53 jpTrpc(218)] sisom rpc {1,7} 
[02:39:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:55 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:55 jpTrpc(218)] sisom rpc {1,7} 
[02:39:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:57 jpTrpc(218)] sisom rpc {1,7} 
[02:39:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:39:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:39:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:39:59 jpTrpc(218)] sisom rpc {1,7} 
[02:40:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:01 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:01 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:01 jpTrpc(218)] sisom rpc {1,7} 
[02:40:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:03 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:03 jpTrpc(218)] sisom rpc {1,7} 
[02:40:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:05 jpTrpc(218)] sisom rpc {1,7} 
[02:40:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:08 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:08 jpTrpc(218)] sisom rpc {1,7} 
[02:40:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:09 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:09 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:09 jpTrpc(218)] sisom rpc {1,7} 
[02:40:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:11 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:11 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:11 jpTrpc(218)] sisom rpc {1,7} 
[02:40:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:13 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:14 jpTrpc(218)] sisom rpc {1,7} 
[02:40:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:15 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:16 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:16 jpTrpc(218)] sisom rpc {1,7} 
[02:40:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:17 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:18 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:18 jpTrpc(218)] sisom rpc {1,7} 
[02:40:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:19 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:20 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:20 jpTrpc(218)] sisom rpc {1,7} 
[02:40:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:21 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:21 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:21 jpTrpc(218)] sisom rpc {1,7} 
[02:40:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:23 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:23 jpTrpc(218)] sisom rpc {1,7} 
[02:40:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:25 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:25 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:25 jpTrpc(218)] sisom rpc {1,7} 
[02:40:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:27 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:27 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:27 jpTrpc(218)] sisom rpc {1,7} 
[02:40:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:29 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:30 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:30 jpTrpc(218)] sisom rpc {1,7} 
[02:40:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:31 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:31 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:32 jpTrpc(218)] sisom rpc {1,7} 
[02:40:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:33 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:33 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:33 jpTrpc(218)] sisom rpc {1,7} 
[02:40:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:35 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:35 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:35 jpTrpc(218)] sisom rpc {1,7} 
[02:40:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:37 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:38 jpTrpc(218)] sisom rpc {1,7} 
[02:40:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:39 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:40 jpTrpc(218)] sisom rpc {1,7} 
[02:40:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:42 jpTrpc(218)] sisom rpc {1,7} 
[02:40:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:44 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:44 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:44 jpTrpc(218)] sisom rpc {1,7} 
[02:40:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:46 jpTrpc(218)] sisom rpc {1,7} 
[02:40:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:48 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:48 jpTrpc(218)] sisom rpc {1,7} 
[02:40:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:50 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:51 jpTrpc(218)] sisom rpc {1,7} 
[02:40:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:52 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:53 jpTrpc(218)] sisom rpc {1,7} 
[02:40:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:54 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:55 jpTrpc(218)] sisom rpc {1,7} 
[02:40:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:56 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:40:57 jpTrpc(218)] sisom rpc {1,7} 
[02:40:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:40:59 jpTrpc(194)] sisom =  sis2@sis2
 [02:40:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:41:00 jpTrpc(218)] sisom rpc {1,7} 
[02:41:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:41:01 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:01 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:41:01 jpTrpc(218)] sisom rpc {1,7} 
[02:41:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:41:03 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:03 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:41:04 jpTrpc(218)] sisom rpc {1,7} 
[02:41:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:41:05 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:41:06 jpTrpc(218)] sisom rpc {1,7} 
[02:41:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:41:07 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:07 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:41:08 jpTrpc(218)] sisom rpc {1,7} 
[02:41:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,5},
                                      {jpTchange_states,unlock,2},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:41:09 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:09 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:41:10 jpTrpc(218)] sisom rpc {2,1} 
[02:41:10 jpTstates(1266)] wait_for_bs after 60sec OwnName = \"MXB slot 0\"{Op,Av}: {2,1} == {2,1} 
[02:41:30 jpTrpc(279)] safesisom calling module: hwmI  func: get_all_bs_id_and_name 
[02:41:30 jpTrpc(284)] safesisom calling module: hwmI  func: get_all_bs_id_and_name arg: [] 
[02:41:31 jpTrpc(302)] sisom calling module: hwmI  func: get_all_bs_id_and_name arg: [] 
[02:41:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,pingE,1},
                                      {jpTrpc,impl_sisom,3},
                                      {jpTrpc,safesisom,4},
                                      {jpTnames,build_table,0},
                                      {jpTnames,update,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTrpc,impl_sisom,3},
                                      {jpTrpc,safesisom,4},
                                      {jpTnames,build_table,0},
                                      {jpTnames,update,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:41:32 jpTrpc(308)] sisom erlnode [sis1@sis1,sis2@sis2] 
[02:41:32 jpTrpc(401)] sisom Head sis1@sis1
[02:41:32 jpTrpc(401)] sisom Head sis2@sis2
[02:41:33 jpTrpc(310)] sisom omcp sis2@sis2 
[02:41:33 jpTnames(1132)] HwmBsIdList is  [{\"SIS\",\"bs_SIS_1\"},
                 {\"MXB slot 0\",\"bs_MXB_2\"},
                 {\"MXB slot 25\",\"bs_MXB_3\"},
                 {\"mgw_1\",\"bs_MGW_4\"},
                 {\"cer_1\",\"bs_ISER_5\"},
                 {\"exb_2\",\"bs_EXB_7\"},
                 {\"exb_1\",\"bs_EXB_6\"}] 
[02:41:33 jpTnames(1200)] H is: [{name,\"SIS\"},{slotSubrack,[{0,1},{0,13}]},{hostname,[sis1,sis2]}]
[02:41:33 jpTnames(1200)] H is: [{name,\"MXB slot 0\"},{slotSubrack,[{0,0}]},{hostname,[mxb1]}]
[02:41:34 jpTnames(1200)] H is: [{name,\"MXB slot 25\"},{slotSubrack,[{0,25}]},{hostname,[mxb2]}]
[02:41:34 jpTnames(1200)] H is: [{name,\"mp_1\"},
       {slotSubrack,[{0,6},{0,21}]},
       {hostname,[blade_0_6,blade_0_21]}]
[02:41:35 jpTnames(1200)] H is: [{name,\"mgw_1\"},
       {slotSubrack,[{0,15},{0,19}]},
       {hostname,[blade_0_15,blade_0_19]}]
[02:41:35 jpTnames(1200)] H is: [{name,\"exb_1\"},{slotSubrack,[{0,5}]},{hostname,[blade_0_5]}]
[02:41:35 jpTnames(1200)] H is: [{name,\"exb_2\"},{slotSubrack,[{0,24}]},{hostname,[blade_0_24]}]
[02:41:35 jpTnames(1200)] H is: [{name,\"cer_1\"},{slotSubrack,[{0,22}]},{hostname,[blade_0_22]}]
[02:41:36 jpTnames(1158)] Cannot create an erlang cookie from BsId: null, BsNo: null 
[02:41:36 jpTnames(1160)] You may have to run jpTnames:update()
[02:41:37 jpTnames(1119)] Updating jpTnames translation table.
[02:41:37 jpTrub(454)] unlock Mxb  \"MXB slot 0\" Bs states 
[02:41:37 jpTinit(522)] get_mbs 
[02:41:37 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:41:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:38 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:38 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:41:39 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:41:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:39 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:40 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:41:40 jpTrpc(218)] sisom rpc \"SIS\" 
[02:41:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:41 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:41 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:41:41 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:41:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:42 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:42 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:41:43 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:41:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:43 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:44 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:41:44 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:41:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:45 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:45 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [02:41:46 jpTrpc(218)] sisom rpc \"cer_1\" 
[02:41:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:46 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:47 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [02:41:47 jpTrpc(218)] sisom rpc \"exb_1\" 
[02:41:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:47 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:48 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [02:41:48 jpTrpc(218)] sisom rpc \"exb_2\" 
[02:41:49 jpTinit(531)] get_mbs \"mp_1\" 
[02:41:49 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [02:41:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:50 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:41:50 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:41:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:51 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:51 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [02:41:52 jpTrpc(218)] sisom rpc \"SIS\" 
[02:41:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:52 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:53 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [02:41:53 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[02:41:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:54 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:54 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [02:41:54 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[02:41:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTrub,check_MBS,0},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:41:55 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:55 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [02:41:56 jpTrpc(218)] sisom rpc \"mgw_1\" 
[02:41:56 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[02:41:57 jpTrub(719)] checking Mbs  \"mgw_1\" Bs states 
[02:41:57 jpTstates(1259)]  wait_for_bs 10sec OwnName = \"mgw_1\" {Op,Av} = {2,1} 
[02:41:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_bs,3},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,check_MBS,0}] 
[02:41:57 jpTrpc(194)] sisom =  sis2@sis2
 [02:41:58 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:41:58 jpTrpc(218)] sisom rpc {2,1} 
[02:41:58 jpTstates(1266)] wait_for_bs after 0sec OwnName = \"mgw_1\"{Op,Av}: {2,1} == {2,1} 
[02:42:19 jpTrub(723)] checking Mbs  \"mgw_1\" Bs states is ok
[02:42:19 jpTrub(457)] check MBS Bs states 
[02:42:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,lock_un_passiv_mxb,0}] 
[02:42:49 jpTrpc(194)] sisom =  sis2@sis2
 [02:42:50 jpTrpc(196)] sisom calling module: rsm_test  func: get_shmcs arg: []
 [02:42:50 jpTrpc(218)] sisom rpc [[\"0\",
            \"25\",
            \"active\",
            \"yes\",
            \"present\",
            \"169.254.64.4\",
            \"292\",
            \"2006-12-06T01:29:20Z:824488\",
            \"2006-12-06T01:41:09Z:423084\"],
           [\"0\",
            \"0\",
            \"passive\",
            \"no\",
            \"present\",
            \"169.254.64.3\",
            \"30\",
            \"2006-12-06T01:41:10Z:483458\",
            \"-\"]] 
[02:42:51 jpTrub(461)] wait4 Bs states 
[02:42:51 jpTrub(747)] wait 4 Bs states 
[02:43:01 jpTstates(1197)] wait_for_all_bs N = 1200 Op = 2 Av =  1 
[02:43:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,2},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:02 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:02 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:43:03 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:43:03 jpTstates(1203)] wait_for_all_bs N = 120 AllBsNoList = [1,2,3,4,5,6,7] 
[02:43:03 jpTstates(1227)] wait_for_all_bs1 H 1 NokList [] 
[02:43:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:04 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:04 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [1]
 [02:43:04 jpTrpc(218)] sisom rpc {2,1} 
[02:43:05 jpTstates(1230)] Op1: 2 av1: 1
[02:43:05 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:05 jpTstates(1227)] wait_for_all_bs1 H 2 NokList [] 
[02:43:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:06 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:43:07 jpTrpc(218)] sisom rpc {2,1} 
[02:43:07 jpTstates(1230)] Op1: 2 av1: 1
[02:43:07 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:08 jpTstates(1227)] wait_for_all_bs1 H 3 NokList [] 
[02:43:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:08 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:09 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [3]
 [02:43:09 jpTrpc(218)] sisom rpc {2,1} 
[02:43:09 jpTstates(1230)] Op1: 2 av1: 1
[02:43:10 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:10 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:43:10 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:11 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:11 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:43:12 jpTrpc(218)] sisom rpc {2,1} 
[02:43:12 jpTstates(1230)] Op1: 2 av1: 1
[02:43:12 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:12 jpTstates(1227)] wait_for_all_bs1 H 5 NokList [] 
[02:43:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:13 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [5]
 [02:43:14 jpTrpc(218)] sisom rpc {2,1} 
[02:43:14 jpTstates(1230)] Op1: 2 av1: 1
[02:43:15 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:15 jpTstates(1227)] wait_for_all_bs1 H 6 NokList [] 
[02:43:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:16 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:16 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [6]
 [02:43:17 jpTrpc(218)] sisom rpc {2,1} 
[02:43:17 jpTstates(1230)] Op1: 2 av1: 1
[02:43:17 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:17 jpTstates(1227)] wait_for_all_bs1 H 7 NokList [] 
[02:43:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,lock_un_passiv_mxb,0},
                                      {jpTrub,is_only,0}] 
[02:43:18 jpTrpc(194)] sisom =  sis2@sis2
 [02:43:18 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [7]
 [02:43:19 jpTrpc(218)] sisom rpc {2,1} 
[02:43:19 jpTstates(1230)] Op1: 2 av1: 1
[02:43:19 jpTstates(1234)] add_if_not_ok NokList [] 
[02:43:20 jpTrub(752)] All bs is ok 
[02:43:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstartstop,sisReboot,1},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3},
                                      {test_server,ts_tc,3}] 
[02:43:20 jpTnames(217)] Name is  sis2 Stack [{jpTnames,find_node_name,1},
                     {jpTstartstop,sisReboot,1},
                     {jpTrub,reboot_om_sis,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3},
                     {test_server,run_test_case_eval1,4}] 
[02:43:21 jpTnames(217)] Name is  sis2 Stack [{jpTnames,find_node_name,1},
                     {jpTstates,pingL,1},
                     {jpTstartstop,sisReboot,2},
                     {jpTrub,reboot_om_sis,0},
                     {jpTrub,is_only,0},
                     {test_server,my_apply,3},
                     {test_server,ts_tc,3}] 
[02:43:22 jpTnames(217)] Name is  sis2@sis2 Stack [{jpTnames,find_node_name,1},
                          {jpTstartstop,do_sisReboot,1},
                          {jpTstartstop,sisReboot,2},
                          {jpTrub,reboot_om_sis,0},
                          {jpTrub,is_only,0},
                          {test_server,my_apply,3},
                          {test_server,ts_tc,3}] 
[02:43:27 jpTrub(487)] sisReboot sisoam sis
[02:43:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:43:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:43:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:43:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_single,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:17 jpTrub(489)] is sis running single 
[02:44:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:44:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:45:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:38 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:46 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:46:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:02 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTstates,is_running_dual,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:21 jpTrub(491)] is sis running dual
[02:47:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,fix_xom,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:47:21 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:22 jpTrpc(196)] sisom calling module: xom_mxb  func: set_loop_data arg: [{0,0},
                                                         [isolate_timer,
                                                          {3000,5000}]]
 [02:47:22 jpTrpc(218)] sisom rpc ok 
[02:47:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,fix_xom,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:47:23 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:24 jpTrpc(196)] sisom calling module: xom_mxb  func: set_loop_data arg: [{0,25},
                                                         [isolate_timer,
                                                          {3000,5000}]]
 [02:47:24 jpTrpc(218)] sisom rpc ok 
[02:47:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,fix_xom,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:47:26 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:26 jpTrpc(196)] sisom calling module: xom_mxb  func: get_loop_data arg: [{0,0},
                                                         [isolate_timer]]
 [02:47:26 jpTrpc(218)] sisom rpc {3000,5000} 
[02:47:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,fix_xom,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:47:27 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:28 jpTrpc(196)] sisom calling module: xom_mxb  func: get_loop_data arg: [{0,25},
                                                         [isolate_timer]]
 [02:47:28 jpTrpc(218)] sisom rpc {3000,5000} 
[02:47:29 jpTrub(743)] xom 0 {3000,5000} 1 {3000,5000} 
[02:47:29 jpTnames(217)] Name is  [mxb1,mxb2] Stack [{jpTnames,find_node_name,1},
                            {jpTstates,pingL,1},
                            {jpTutil,wait4,4},
                            {jpTutil,wait4,2},
                            {jpTrub,reboot_om_sis,0},
                            {jpTrub,is_only,0},
                            {test_server,my_apply,3}] 
[02:47:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,pingE,1},
                                      {jpTutil,wait4,4},
                                      {jpTutil,wait4,2},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[02:47:30 jpTrub(494)] PingL mxb pingE sis
[02:47:31 jpTrub(747)] wait 4 Bs states 
[02:47:42 jpTstates(1197)] wait_for_all_bs N = 1200 Op = 2 Av =  1 
[02:47:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,2},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:42 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:43 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [02:47:43 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[02:47:44 jpTstates(1203)] wait_for_all_bs N = 120 AllBsNoList = [1,2,3,4,5,6,7] 
[02:47:45 jpTstates(1227)] wait_for_all_bs1 H 1 NokList [] 
[02:47:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:45 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [1]
 [02:47:46 jpTrpc(218)] sisom rpc {2,1} 
[02:47:46 jpTstates(1230)] Op1: 2 av1: 1
[02:47:47 jpTstates(1234)] add_if_not_ok NokList [] 
[02:47:48 jpTstates(1227)] wait_for_all_bs1 H 2 NokList [] 
[02:47:48 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:49 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:49 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [2]
 [02:47:49 jpTrpc(218)] sisom rpc {2,1} 
[02:47:50 jpTstates(1230)] Op1: 2 av1: 1
[02:47:50 jpTstates(1234)] add_if_not_ok NokList [] 
[02:47:51 jpTstates(1227)] wait_for_all_bs1 H 3 NokList [] 
[02:47:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:52 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:52 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [3]
 [02:47:53 jpTrpc(218)] sisom rpc {2,1} 
[02:47:53 jpTstates(1230)] Op1: 2 av1: 1
[02:47:54 jpTstates(1234)] add_if_not_ok NokList [] 
[02:47:54 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:47:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:55 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:56 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:47:56 jpTrpc(218)] sisom rpc {2,5} 
[02:47:56 jpTstates(1230)] Op1: 2 av1: 5
[02:47:57 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:47:57 jpTstates(1227)] wait_for_all_bs1 H 5 NokList [4] 
[02:47:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:47:59 jpTrpc(194)] sisom =  sis1@sis1
 [02:47:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [5]
 [02:48:00 jpTrpc(218)] sisom rpc {2,1} 
[02:48:00 jpTstates(1230)] Op1: 2 av1: 1
[02:48:00 jpTstates(1234)] add_if_not_ok NokList [4] 
[02:48:01 jpTstates(1227)] wait_for_all_bs1 H 6 NokList [4] 
[02:48:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:48:02 jpTrpc(194)] sisom =  sis1@sis1
 [02:48:02 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [6]
 [02:48:03 jpTrpc(218)] sisom rpc {2,1} 
[02:48:03 jpTstates(1230)] Op1: 2 av1: 1
[02:48:03 jpTstates(1234)] add_if_not_ok NokList [4] 
[02:48:04 jpTstates(1227)] wait_for_all_bs1 H 7 NokList [4] 
[02:48:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:48:05 jpTrpc(194)] sisom =  sis1@sis1
 [02:48:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [7]
 [02:48:06 jpTrpc(218)] sisom rpc {2,1} 
[02:48:06 jpTstates(1230)] Op1: 2 av1: 1
[02:48:07 jpTstates(1234)] add_if_not_ok NokList [4] 
[02:48:17 jpTstates(1222)] wait_for_all_bs1 nok N = 120  listan =  [4] 
[02:48:17 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:48:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:48:18 jpTrpc(194)] sisom =  sis1@sis1
 [02:48:19 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:48:19 jpTrpc(218)] sisom rpc {2,5} 
[02:48:20 jpTstates(1230)] Op1: 2 av1: 5
[02:48:20 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:48:31 jpTstates(1222)] wait_for_all_bs1 nok N = 119  listan =  [4] 
[02:48:31 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:48:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:48:32 jpTrpc(194)] sisom =  sis1@sis1
 [02:48:33 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:48:33 jpTrpc(218)] sisom rpc {2,5} 
[02:48:33 jpTstates(1230)] Op1: 2 av1: 5
[02:48:34 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:48:44 jpTstates(1222)] wait_for_all_bs1 nok N = 118  listan =  [4] 
[02:48:45 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:48:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:48:45 jpTrpc(194)] sisom =  sis1@sis1
 [02:48:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:48:46 jpTrpc(218)] sisom rpc {2,5} 
[02:48:47 jpTstates(1230)] Op1: 2 av1: 5
[02:48:48 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:48:58 jpTstates(1222)] wait_for_all_bs1 nok N = 117  listan =  [4] 
[02:48:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:48:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:48:59 jpTrpc(194)] sisom =  sis1@sis1
 [02:48:59 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:49:00 jpTrpc(218)] sisom rpc {2,5} 
[02:49:01 jpTstates(1230)] Op1: 2 av1: 5
[02:49:01 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:49:11 jpTstates(1222)] wait_for_all_bs1 nok N = 116  listan =  [4] 
[02:49:12 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:49:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:49:13 jpTrpc(194)] sisom =  sis1@sis1
 [02:49:13 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:49:14 jpTrpc(218)] sisom rpc {2,5} 
[02:49:14 jpTstates(1230)] Op1: 2 av1: 5
[02:49:15 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:49:25 jpTstates(1222)] wait_for_all_bs1 nok N = 115  listan =  [4] 
[02:49:25 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:49:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:49:26 jpTrpc(194)] sisom =  sis1@sis1
 [02:49:26 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:49:27 jpTrpc(218)] sisom rpc {2,5} 
[02:49:27 jpTstates(1230)] Op1: 2 av1: 5
[02:49:28 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:49:38 jpTstates(1222)] wait_for_all_bs1 nok N = 114  listan =  [4] 
[02:49:38 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:49:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:49:39 jpTrpc(194)] sisom =  sis1@sis1
 [02:49:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:49:41 jpTrpc(218)] sisom rpc {2,5} 
[02:49:41 jpTstates(1230)] Op1: 2 av1: 5
[02:49:41 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:49:52 jpTstates(1222)] wait_for_all_bs1 nok N = 113  listan =  [4] 
[02:49:52 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:49:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:49:53 jpTrpc(194)] sisom =  sis1@sis1
 [02:49:54 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:49:54 jpTrpc(218)] sisom rpc {2,5} 
[02:49:54 jpTstates(1230)] Op1: 2 av1: 5
[02:49:55 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:50:05 jpTstates(1222)] wait_for_all_bs1 nok N = 112  listan =  [4] 
[02:50:05 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:50:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:50:07 jpTrpc(194)] sisom =  sis1@sis1
 [02:50:07 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:50:07 jpTrpc(218)] sisom rpc {2,5} 
[02:50:08 jpTstates(1230)] Op1: 2 av1: 5
[02:50:08 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:50:19 jpTstates(1222)] wait_for_all_bs1 nok N = 111  listan =  [4] 
[02:50:19 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:50:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:50:20 jpTrpc(194)] sisom =  sis1@sis1
 [02:50:20 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:50:21 jpTrpc(218)] sisom rpc {2,5} 
[02:50:21 jpTstates(1230)] Op1: 2 av1: 5
[02:50:22 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:50:32 jpTstates(1222)] wait_for_all_bs1 nok N = 110  listan =  [4] 
[02:50:32 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:50:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:50:34 jpTrpc(194)] sisom =  sis1@sis1
 [02:50:34 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:50:34 jpTrpc(218)] sisom rpc {2,5} 
[02:50:35 jpTstates(1230)] Op1: 2 av1: 5
[02:50:35 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:50:46 jpTstates(1222)] wait_for_all_bs1 nok N = 109  listan =  [4] 
[02:50:46 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:50:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:50:47 jpTrpc(194)] sisom =  sis1@sis1
 [02:50:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:50:48 jpTrpc(218)] sisom rpc {2,5} 
[02:50:49 jpTstates(1230)] Op1: 2 av1: 5
[02:50:49 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:51:00 jpTstates(1222)] wait_for_all_bs1 nok N = 108  listan =  [4] 
[02:51:00 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:51:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:51:01 jpTrpc(194)] sisom =  sis1@sis1
 [02:51:01 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:51:02 jpTrpc(218)] sisom rpc {2,5} 
[02:51:03 jpTstates(1230)] Op1: 2 av1: 5
[02:51:03 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:51:14 jpTstates(1222)] wait_for_all_bs1 nok N = 107  listan =  [4] 
[02:51:14 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:51:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:51:15 jpTrpc(194)] sisom =  sis1@sis1
 [02:51:15 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:51:16 jpTrpc(218)] sisom rpc {2,5} 
[02:51:16 jpTstates(1230)] Op1: 2 av1: 5
[02:51:16 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:51:27 jpTstates(1222)] wait_for_all_bs1 nok N = 106  listan =  [4] 
[02:51:28 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:51:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:51:29 jpTrpc(194)] sisom =  sis1@sis1
 [02:51:29 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:51:29 jpTrpc(218)] sisom rpc {2,5} 
[02:51:30 jpTstates(1230)] Op1: 2 av1: 5
[02:51:30 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:51:41 jpTstates(1222)] wait_for_all_bs1 nok N = 105  listan =  [4] 
[02:51:41 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:51:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:51:42 jpTrpc(194)] sisom =  sis1@sis1
 [02:51:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:51:43 jpTrpc(218)] sisom rpc {2,5} 
[02:51:44 jpTstates(1230)] Op1: 2 av1: 5
[02:51:44 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:51:54 jpTstates(1222)] wait_for_all_bs1 nok N = 104  listan =  [4] 
[02:51:54 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:51:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:51:56 jpTrpc(194)] sisom =  sis1@sis1
 [02:51:56 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:51:56 jpTrpc(218)] sisom rpc {2,5} 
[02:51:57 jpTstates(1230)] Op1: 2 av1: 5
[02:51:57 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:52:08 jpTstates(1222)] wait_for_all_bs1 nok N = 103  listan =  [4] 
[02:52:08 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:52:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:52:09 jpTrpc(194)] sisom =  sis1@sis1
 [02:52:10 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:52:10 jpTrpc(218)] sisom rpc {2,5} 
[02:52:11 jpTstates(1230)] Op1: 2 av1: 5
[02:52:11 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:52:22 jpTstates(1222)] wait_for_all_bs1 nok N = 102  listan =  [4] 
[02:52:22 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:52:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:52:23 jpTrpc(194)] sisom =  sis1@sis1
 [02:52:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:52:24 jpTrpc(218)] sisom rpc {2,5} 
[02:52:24 jpTstates(1230)] Op1: 2 av1: 5
[02:52:25 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:52:35 jpTstates(1222)] wait_for_all_bs1 nok N = 101  listan =  [4] 
[02:52:35 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:52:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:52:37 jpTrpc(194)] sisom =  sis1@sis1
 [02:52:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:52:38 jpTrpc(218)] sisom rpc {2,5} 
[02:52:38 jpTstates(1230)] Op1: 2 av1: 5
[02:52:38 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:52:49 jpTstates(1222)] wait_for_all_bs1 nok N = 100  listan =  [4] 
[02:52:49 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:52:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:52:50 jpTrpc(194)] sisom =  sis1@sis1
 [02:52:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:52:51 jpTrpc(218)] sisom rpc {2,5} 
[02:52:51 jpTstates(1230)] Op1: 2 av1: 5
[02:52:52 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:53:02 jpTstates(1222)] wait_for_all_bs1 nok N = 99  listan =  [4] 
[02:53:03 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:53:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:53:04 jpTrpc(194)] sisom =  sis1@sis1
 [02:53:04 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:53:05 jpTrpc(218)] sisom rpc {2,5} 
[02:53:05 jpTstates(1230)] Op1: 2 av1: 5
[02:53:06 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:53:16 jpTstates(1222)] wait_for_all_bs1 nok N = 98  listan =  [4] 
[02:53:16 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:53:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:53:18 jpTrpc(194)] sisom =  sis1@sis1
 [02:53:19 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:53:19 jpTrpc(218)] sisom rpc {2,5} 
[02:53:19 jpTstates(1230)] Op1: 2 av1: 5
[02:53:20 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:53:30 jpTstates(1222)] wait_for_all_bs1 nok N = 97  listan =  [4] 
[02:53:31 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:53:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:53:32 jpTrpc(194)] sisom =  sis1@sis1
 [02:53:32 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:53:33 jpTrpc(218)] sisom rpc {2,5} 
[02:53:33 jpTstates(1230)] Op1: 2 av1: 5
[02:53:34 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:53:44 jpTstates(1222)] wait_for_all_bs1 nok N = 96  listan =  [4] 
[02:53:44 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:53:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:53:45 jpTrpc(194)] sisom =  sis1@sis1
 [02:53:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:53:47 jpTrpc(218)] sisom rpc {2,5} 
[02:53:47 jpTstates(1230)] Op1: 2 av1: 5
[02:53:47 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:53:58 jpTstates(1222)] wait_for_all_bs1 nok N = 95  listan =  [4] 
[02:53:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:53:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:53:59 jpTrpc(194)] sisom =  sis1@sis1
 [02:54:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:54:00 jpTrpc(218)] sisom rpc {2,5} 
[02:54:00 jpTstates(1230)] Op1: 2 av1: 5
[02:54:01 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:54:11 jpTstates(1222)] wait_for_all_bs1 nok N = 94  listan =  [4] 
[02:54:11 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:54:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:54:12 jpTrpc(194)] sisom =  sis1@sis1
 [02:54:13 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:54:13 jpTrpc(218)] sisom rpc {2,5} 
[02:54:14 jpTstates(1230)] Op1: 2 av1: 5
[02:54:15 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:54:25 jpTstates(1222)] wait_for_all_bs1 nok N = 93  listan =  [4] 
[02:54:25 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:54:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:54:26 jpTrpc(194)] sisom =  sis1@sis1
 [02:54:27 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:54:27 jpTrpc(218)] sisom rpc {2,5} 
[02:54:28 jpTstates(1230)] Op1: 2 av1: 5
[02:54:28 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:54:38 jpTstates(1222)] wait_for_all_bs1 nok N = 92  listan =  [4] 
[02:54:39 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:54:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:54:40 jpTrpc(194)] sisom =  sis1@sis1
 [02:54:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:54:41 jpTrpc(218)] sisom rpc {2,5} 
[02:54:41 jpTstates(1230)] Op1: 2 av1: 5
[02:54:42 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:54:52 jpTstates(1222)] wait_for_all_bs1 nok N = 91  listan =  [4] 
[02:54:52 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:54:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:54:53 jpTrpc(194)] sisom =  sis1@sis1
 [02:54:53 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:54:54 jpTrpc(218)] sisom rpc {2,5} 
[02:54:54 jpTstates(1230)] Op1: 2 av1: 5
[02:54:55 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:55:05 jpTstates(1222)] wait_for_all_bs1 nok N = 90  listan =  [4] 
[02:55:05 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:55:06 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:55:06 jpTrpc(194)] sisom =  sis1@sis1
 [02:55:07 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:55:08 jpTrpc(218)] sisom rpc {2,5} 
[02:55:08 jpTstates(1230)] Op1: 2 av1: 5
[02:55:09 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:55:19 jpTstates(1222)] wait_for_all_bs1 nok N = 89  listan =  [4] 
[02:55:19 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:55:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:55:20 jpTrpc(194)] sisom =  sis1@sis1
 [02:55:21 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:55:21 jpTrpc(218)] sisom rpc {2,5} 
[02:55:22 jpTstates(1230)] Op1: 2 av1: 5
[02:55:22 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:55:32 jpTstates(1222)] wait_for_all_bs1 nok N = 88  listan =  [4] 
[02:55:33 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:55:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:55:34 jpTrpc(194)] sisom =  sis1@sis1
 [02:55:34 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:55:35 jpTrpc(218)] sisom rpc {2,5} 
[02:55:35 jpTstates(1230)] Op1: 2 av1: 5
[02:55:36 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:55:46 jpTstates(1222)] wait_for_all_bs1 nok N = 87  listan =  [4] 
[02:55:46 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:55:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:55:47 jpTrpc(194)] sisom =  sis1@sis1
 [02:55:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:55:48 jpTrpc(218)] sisom rpc {2,5} 
[02:55:49 jpTstates(1230)] Op1: 2 av1: 5
[02:55:49 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:55:59 jpTstates(1222)] wait_for_all_bs1 nok N = 86  listan =  [4] 
[02:55:59 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:56:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:56:01 jpTrpc(194)] sisom =  sis1@sis1
 [02:56:01 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:56:02 jpTrpc(218)] sisom rpc {2,5} 
[02:56:02 jpTstates(1230)] Op1: 2 av1: 5
[02:56:03 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:56:13 jpTstates(1222)] wait_for_all_bs1 nok N = 85  listan =  [4] 
[02:56:13 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:56:14 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:56:14 jpTrpc(194)] sisom =  sis1@sis1
 [02:56:15 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:56:15 jpTrpc(218)] sisom rpc {2,5} 
[02:56:16 jpTstates(1230)] Op1: 2 av1: 5
[02:56:17 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:56:27 jpTstates(1222)] wait_for_all_bs1 nok N = 84  listan =  [4] 
[02:56:27 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:56:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:56:28 jpTrpc(194)] sisom =  sis1@sis1
 [02:56:28 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:56:29 jpTrpc(218)] sisom rpc {2,5} 
[02:56:30 jpTstates(1230)] Op1: 2 av1: 5
[02:56:30 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:56:40 jpTstates(1222)] wait_for_all_bs1 nok N = 83  listan =  [4] 
[02:56:40 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:56:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:56:41 jpTrpc(194)] sisom =  sis1@sis1
 [02:56:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:56:42 jpTrpc(218)] sisom rpc {2,5} 
[02:56:42 jpTstates(1230)] Op1: 2 av1: 5
[02:56:43 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:56:54 jpTstates(1222)] wait_for_all_bs1 nok N = 82  listan =  [4] 
[02:56:54 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:56:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:56:55 jpTrpc(194)] sisom =  sis1@sis1
 [02:56:56 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:56:56 jpTrpc(218)] sisom rpc {2,5} 
[02:56:57 jpTstates(1230)] Op1: 2 av1: 5
[02:56:57 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:57:08 jpTstates(1222)] wait_for_all_bs1 nok N = 81  listan =  [4] 
[02:57:08 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:57:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:57:09 jpTrpc(194)] sisom =  sis1@sis1
 [02:57:09 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:57:10 jpTrpc(218)] sisom rpc {2,5} 
[02:57:11 jpTstates(1230)] Op1: 2 av1: 5
[02:57:11 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:57:21 jpTstates(1222)] wait_for_all_bs1 nok N = 80  listan =  [4] 
[02:57:21 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:57:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:57:23 jpTrpc(194)] sisom =  sis1@sis1
 [02:57:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:57:23 jpTrpc(218)] sisom rpc {2,5} 
[02:57:24 jpTstates(1230)] Op1: 2 av1: 5
[02:57:25 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:57:35 jpTstates(1222)] wait_for_all_bs1 nok N = 79  listan =  [4] 
[02:57:35 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:57:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:57:36 jpTrpc(194)] sisom =  sis1@sis1
 [02:57:37 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:57:38 jpTrpc(218)] sisom rpc {2,5} 
[02:57:38 jpTstates(1230)] Op1: 2 av1: 5
[02:57:39 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:57:49 jpTstates(1222)] wait_for_all_bs1 nok N = 78  listan =  [4] 
[02:57:49 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:57:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:57:50 jpTrpc(194)] sisom =  sis1@sis1
 [02:57:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:57:51 jpTrpc(218)] sisom rpc {2,5} 
[02:57:52 jpTstates(1230)] Op1: 2 av1: 5
[02:57:52 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:58:02 jpTstates(1222)] wait_for_all_bs1 nok N = 77  listan =  [4] 
[02:58:03 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:58:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:58:04 jpTrpc(194)] sisom =  sis1@sis1
 [02:58:04 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:58:05 jpTrpc(218)] sisom rpc {2,5} 
[02:58:05 jpTstates(1230)] Op1: 2 av1: 5
[02:58:06 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:58:16 jpTstates(1222)] wait_for_all_bs1 nok N = 76  listan =  [4] 
[02:58:16 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:58:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:58:17 jpTrpc(194)] sisom =  sis1@sis1
 [02:58:18 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:58:18 jpTrpc(218)] sisom rpc {2,5} 
[02:58:19 jpTstates(1230)] Op1: 2 av1: 5
[02:58:20 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:58:30 jpTstates(1222)] wait_for_all_bs1 nok N = 75  listan =  [4] 
[02:58:31 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:58:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:58:31 jpTrpc(194)] sisom =  sis1@sis1
 [02:58:32 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:58:33 jpTrpc(218)] sisom rpc {2,5} 
[02:58:33 jpTstates(1230)] Op1: 2 av1: 5
[02:58:33 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:58:44 jpTstates(1222)] wait_for_all_bs1 nok N = 74  listan =  [4] 
[02:58:44 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:58:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:58:45 jpTrpc(194)] sisom =  sis1@sis1
 [02:58:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:58:46 jpTrpc(218)] sisom rpc {2,5} 
[02:58:47 jpTstates(1230)] Op1: 2 av1: 5
[02:58:47 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:58:58 jpTstates(1222)] wait_for_all_bs1 nok N = 73  listan =  [4] 
[02:58:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:58:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:59:00 jpTrpc(194)] sisom =  sis1@sis1
 [02:59:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:59:00 jpTrpc(218)] sisom rpc {2,5} 
[02:59:01 jpTstates(1230)] Op1: 2 av1: 5
[02:59:02 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:59:12 jpTstates(1222)] wait_for_all_bs1 nok N = 72  listan =  [4] 
[02:59:12 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:59:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:59:13 jpTrpc(194)] sisom =  sis1@sis1
 [02:59:13 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:59:15 jpTrpc(218)] sisom rpc {2,5} 
[02:59:15 jpTstates(1230)] Op1: 2 av1: 5
[02:59:15 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:59:26 jpTstates(1222)] wait_for_all_bs1 nok N = 71  listan =  [4] 
[02:59:26 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:59:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:59:27 jpTrpc(194)] sisom =  sis1@sis1
 [02:59:28 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:59:28 jpTrpc(218)] sisom rpc {2,5} 
[02:59:29 jpTstates(1230)] Op1: 2 av1: 5
[02:59:29 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:59:39 jpTstates(1222)] wait_for_all_bs1 nok N = 70  listan =  [4] 
[02:59:40 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:59:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:59:41 jpTrpc(194)] sisom =  sis1@sis1
 [02:59:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:59:42 jpTrpc(218)] sisom rpc {2,5} 
[02:59:43 jpTstates(1230)] Op1: 2 av1: 5
[02:59:43 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[02:59:54 jpTstates(1222)] wait_for_all_bs1 nok N = 69  listan =  [4] 
[02:59:54 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[02:59:54 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[02:59:55 jpTrpc(194)] sisom =  sis1@sis1
 [02:59:55 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [02:59:56 jpTrpc(218)] sisom rpc {2,5} 
[02:59:57 jpTstates(1230)] Op1: 2 av1: 5
[02:59:57 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:00:08 jpTstates(1222)] wait_for_all_bs1 nok N = 68  listan =  [4] 
[03:00:08 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:00:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:00:09 jpTrpc(194)] sisom =  sis1@sis1
 [03:00:09 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:00:10 jpTrpc(218)] sisom rpc {2,5} 
[03:00:10 jpTstates(1230)] Op1: 2 av1: 5
[03:00:11 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:00:21 jpTstates(1222)] wait_for_all_bs1 nok N = 67  listan =  [4] 
[03:00:22 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:00:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:00:23 jpTrpc(194)] sisom =  sis1@sis1
 [03:00:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:00:23 jpTrpc(218)] sisom rpc {2,5} 
[03:00:24 jpTstates(1230)] Op1: 2 av1: 5
[03:00:25 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:00:35 jpTstates(1222)] wait_for_all_bs1 nok N = 66  listan =  [4] 
[03:00:35 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:00:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:00:36 jpTrpc(194)] sisom =  sis1@sis1
 [03:00:36 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:00:37 jpTrpc(218)] sisom rpc {2,5} 
[03:00:38 jpTstates(1230)] Op1: 2 av1: 5
[03:00:38 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:00:48 jpTstates(1222)] wait_for_all_bs1 nok N = 65  listan =  [4] 
[03:00:49 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:00:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:00:50 jpTrpc(194)] sisom =  sis1@sis1
 [03:00:51 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:00:51 jpTrpc(218)] sisom rpc {2,5} 
[03:00:52 jpTstates(1230)] Op1: 2 av1: 5
[03:00:52 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:01:03 jpTstates(1222)] wait_for_all_bs1 nok N = 64  listan =  [4] 
[03:01:03 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:01:04 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:01:05 jpTrpc(194)] sisom =  sis1@sis1
 [03:01:05 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:01:05 jpTrpc(218)] sisom rpc {2,5} 
[03:01:06 jpTstates(1230)] Op1: 2 av1: 5
[03:01:07 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:01:17 jpTstates(1222)] wait_for_all_bs1 nok N = 63  listan =  [4] 
[03:01:17 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:01:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:01:18 jpTrpc(194)] sisom =  sis1@sis1
 [03:01:19 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:01:19 jpTrpc(218)] sisom rpc {2,5} 
[03:01:20 jpTstates(1230)] Op1: 2 av1: 5
[03:01:20 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:01:31 jpTstates(1222)] wait_for_all_bs1 nok N = 62  listan =  [4] 
[03:01:31 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:01:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:01:32 jpTrpc(194)] sisom =  sis1@sis1
 [03:01:33 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:01:33 jpTrpc(218)] sisom rpc {2,5} 
[03:01:34 jpTstates(1230)] Op1: 2 av1: 5
[03:01:34 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:01:44 jpTstates(1222)] wait_for_all_bs1 nok N = 61  listan =  [4] 
[03:01:45 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:01:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:01:46 jpTrpc(194)] sisom =  sis1@sis1
 [03:01:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:01:47 jpTrpc(218)] sisom rpc {2,5} 
[03:01:47 jpTstates(1230)] Op1: 2 av1: 5
[03:01:48 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:01:58 jpTstates(1222)] wait_for_all_bs1 nok N = 60  listan =  [4] 
[03:01:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:01:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:01:59 jpTrpc(194)] sisom =  sis1@sis1
 [03:02:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:02:01 jpTrpc(218)] sisom rpc {2,5} 
[03:02:01 jpTstates(1230)] Op1: 2 av1: 5
[03:02:02 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:02:12 jpTstates(1222)] wait_for_all_bs1 nok N = 59  listan =  [4] 
[03:02:12 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:02:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:02:13 jpTrpc(194)] sisom =  sis1@sis1
 [03:02:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:02:14 jpTrpc(218)] sisom rpc {2,5} 
[03:02:15 jpTstates(1230)] Op1: 2 av1: 5
[03:02:15 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:02:25 jpTstates(1222)] wait_for_all_bs1 nok N = 58  listan =  [4] 
[03:02:26 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:02:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:02:27 jpTrpc(194)] sisom =  sis1@sis1
 [03:02:27 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:02:28 jpTrpc(218)] sisom rpc {2,5} 
[03:02:29 jpTstates(1230)] Op1: 2 av1: 5
[03:02:29 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:02:40 jpTstates(1222)] wait_for_all_bs1 nok N = 57  listan =  [4] 
[03:02:40 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:02:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:02:41 jpTrpc(194)] sisom =  sis1@sis1
 [03:02:41 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:02:42 jpTrpc(218)] sisom rpc {2,5} 
[03:02:43 jpTstates(1230)] Op1: 2 av1: 5
[03:02:43 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:02:54 jpTstates(1222)] wait_for_all_bs1 nok N = 56  listan =  [4] 
[03:02:54 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:02:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:02:56 jpTrpc(194)] sisom =  sis1@sis1
 [03:02:56 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:02:56 jpTrpc(218)] sisom rpc {2,5} 
[03:02:57 jpTstates(1230)] Op1: 2 av1: 5
[03:02:57 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:03:08 jpTstates(1222)] wait_for_all_bs1 nok N = 55  listan =  [4] 
[03:03:08 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:03:09 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:03:09 jpTrpc(194)] sisom =  sis1@sis1
 [03:03:10 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:03:10 jpTrpc(218)] sisom rpc {2,5} 
[03:03:11 jpTstates(1230)] Op1: 2 av1: 5
[03:03:12 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:03:22 jpTstates(1222)] wait_for_all_bs1 nok N = 54  listan =  [4] 
[03:03:22 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:03:23 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:03:23 jpTrpc(194)] sisom =  sis1@sis1
 [03:03:24 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:03:24 jpTrpc(218)] sisom rpc {2,5} 
[03:03:25 jpTstates(1230)] Op1: 2 av1: 5
[03:03:25 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:03:36 jpTstates(1222)] wait_for_all_bs1 nok N = 53  listan =  [4] 
[03:03:36 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:03:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:03:38 jpTrpc(194)] sisom =  sis1@sis1
 [03:03:38 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:03:38 jpTrpc(218)] sisom rpc {2,5} 
[03:03:39 jpTstates(1230)] Op1: 2 av1: 5
[03:03:39 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:03:50 jpTstates(1222)] wait_for_all_bs1 nok N = 52  listan =  [4] 
[03:03:51 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:03:51 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:03:52 jpTrpc(194)] sisom =  sis1@sis1
 [03:03:52 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:03:53 jpTrpc(218)] sisom rpc {2,5} 
[03:03:53 jpTstates(1230)] Op1: 2 av1: 5
[03:03:54 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:04:04 jpTstates(1222)] wait_for_all_bs1 nok N = 51  listan =  [4] 
[03:04:05 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:04:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:04:05 jpTrpc(194)] sisom =  sis1@sis1
 [03:04:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:04:07 jpTrpc(218)] sisom rpc {2,5} 
[03:04:07 jpTstates(1230)] Op1: 2 av1: 5
[03:04:08 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:04:18 jpTstates(1222)] wait_for_all_bs1 nok N = 50  listan =  [4] 
[03:04:18 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:04:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:04:20 jpTrpc(194)] sisom =  sis1@sis1
 [03:04:20 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:04:20 jpTrpc(218)] sisom rpc {2,5} 
[03:04:21 jpTstates(1230)] Op1: 2 av1: 5
[03:04:21 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:04:32 jpTstates(1222)] wait_for_all_bs1 nok N = 49  listan =  [4] 
[03:04:32 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:04:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:04:33 jpTrpc(194)] sisom =  sis1@sis1
 [03:04:33 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:04:34 jpTrpc(218)] sisom rpc {2,5} 
[03:04:34 jpTstates(1230)] Op1: 2 av1: 5
[03:04:35 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:04:46 jpTstates(1222)] wait_for_all_bs1 nok N = 48  listan =  [4] 
[03:04:46 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:04:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:04:47 jpTrpc(194)] sisom =  sis1@sis1
 [03:04:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:04:48 jpTrpc(218)] sisom rpc {2,5} 
[03:04:49 jpTstates(1230)] Op1: 2 av1: 5
[03:04:49 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:04:59 jpTstates(1222)] wait_for_all_bs1 nok N = 47  listan =  [4] 
[03:05:00 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:05:00 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:05:01 jpTrpc(194)] sisom =  sis1@sis1
 [03:05:02 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:05:02 jpTrpc(218)] sisom rpc {2,5} 
[03:05:03 jpTstates(1230)] Op1: 2 av1: 5
[03:05:03 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:05:14 jpTstates(1222)] wait_for_all_bs1 nok N = 46  listan =  [4] 
[03:05:14 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:05:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:05:15 jpTrpc(194)] sisom =  sis1@sis1
 [03:05:16 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:05:16 jpTrpc(218)] sisom rpc {2,5} 
[03:05:17 jpTstates(1230)] Op1: 2 av1: 5
[03:05:18 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:05:28 jpTstates(1222)] wait_for_all_bs1 nok N = 45  listan =  [4] 
[03:05:28 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:05:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:05:30 jpTrpc(194)] sisom =  sis1@sis1
 [03:05:30 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:05:31 jpTrpc(218)] sisom rpc {2,5} 
[03:05:31 jpTstates(1230)] Op1: 2 av1: 5
[03:05:32 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:05:42 jpTstates(1222)] wait_for_all_bs1 nok N = 44  listan =  [4] 
[03:05:42 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:05:43 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:05:43 jpTrpc(194)] sisom =  sis1@sis1
 [03:05:44 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:05:45 jpTrpc(218)] sisom rpc {2,5} 
[03:05:45 jpTstates(1230)] Op1: 2 av1: 5
[03:05:46 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:05:56 jpTstates(1222)] wait_for_all_bs1 nok N = 43  listan =  [4] 
[03:05:57 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:05:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:05:58 jpTrpc(194)] sisom =  sis1@sis1
 [03:05:58 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:05:59 jpTrpc(218)] sisom rpc {2,5} 
[03:05:59 jpTstates(1230)] Op1: 2 av1: 5
[03:06:00 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:06:10 jpTstates(1222)] wait_for_all_bs1 nok N = 42  listan =  [4] 
[03:06:10 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:06:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:06:11 jpTrpc(194)] sisom =  sis1@sis1
 [03:06:11 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:06:12 jpTrpc(218)] sisom rpc {2,5} 
[03:06:13 jpTstates(1230)] Op1: 2 av1: 5
[03:06:13 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:06:24 jpTstates(1222)] wait_for_all_bs1 nok N = 41  listan =  [4] 
[03:06:24 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:06:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:06:26 jpTrpc(194)] sisom =  sis1@sis1
 [03:06:26 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:06:26 jpTrpc(218)] sisom rpc {2,5} 
[03:06:27 jpTstates(1230)] Op1: 2 av1: 5
[03:06:27 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:06:38 jpTstates(1222)] wait_for_all_bs1 nok N = 40  listan =  [4] 
[03:06:38 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:06:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:06:39 jpTrpc(194)] sisom =  sis1@sis1
 [03:06:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:06:40 jpTrpc(218)] sisom rpc {2,5} 
[03:06:41 jpTstates(1230)] Op1: 2 av1: 5
[03:06:41 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:06:52 jpTstates(1222)] wait_for_all_bs1 nok N = 39  listan =  [4] 
[03:06:52 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:06:52 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:06:53 jpTrpc(194)] sisom =  sis1@sis1
 [03:06:53 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:06:54 jpTrpc(218)] sisom rpc {2,5} 
[03:06:55 jpTstates(1230)] Op1: 2 av1: 5
[03:06:55 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:07:06 jpTstates(1222)] wait_for_all_bs1 nok N = 38  listan =  [4] 
[03:07:06 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:07:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:07:08 jpTrpc(194)] sisom =  sis1@sis1
 [03:07:08 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:07:08 jpTrpc(218)] sisom rpc {2,5} 
[03:07:09 jpTstates(1230)] Op1: 2 av1: 5
[03:07:10 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:07:20 jpTstates(1222)] wait_for_all_bs1 nok N = 37  listan =  [4] 
[03:07:20 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:07:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:07:21 jpTrpc(194)] sisom =  sis1@sis1
 [03:07:22 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:07:22 jpTrpc(218)] sisom rpc {2,5} 
[03:07:23 jpTstates(1230)] Op1: 2 av1: 5
[03:07:24 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:07:34 jpTstates(1222)] wait_for_all_bs1 nok N = 36  listan =  [4] 
[03:07:34 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:07:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:07:35 jpTrpc(194)] sisom =  sis1@sis1
 [03:07:36 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:07:36 jpTrpc(218)] sisom rpc {2,5} 
[03:07:37 jpTstates(1230)] Op1: 2 av1: 5
[03:07:37 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:07:48 jpTstates(1222)] wait_for_all_bs1 nok N = 35  listan =  [4] 
[03:07:48 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:07:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:07:50 jpTrpc(194)] sisom =  sis1@sis1
 [03:07:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:07:51 jpTrpc(218)] sisom rpc {2,5} 
[03:07:51 jpTstates(1230)] Op1: 2 av1: 5
[03:07:52 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:08:02 jpTstates(1222)] wait_for_all_bs1 nok N = 34  listan =  [4] 
[03:08:03 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:08:03 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:08:03 jpTrpc(194)] sisom =  sis1@sis1
 [03:08:04 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:08:04 jpTrpc(218)] sisom rpc {2,5} 
[03:08:04 jpTstates(1230)] Op1: 2 av1: 5
[03:08:06 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:08:16 jpTstates(1222)] wait_for_all_bs1 nok N = 33  listan =  [4] 
[03:08:16 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:08:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:08:17 jpTrpc(194)] sisom =  sis1@sis1
 [03:08:18 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:08:18 jpTrpc(218)] sisom rpc {2,5} 
[03:08:19 jpTstates(1230)] Op1: 2 av1: 5
[03:08:19 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:08:29 jpTstates(1222)] wait_for_all_bs1 nok N = 32  listan =  [4] 
[03:08:30 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:08:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:08:31 jpTrpc(194)] sisom =  sis1@sis1
 [03:08:32 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:08:32 jpTrpc(218)] sisom rpc {2,5} 
[03:08:33 jpTstates(1230)] Op1: 2 av1: 5
[03:08:33 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:08:44 jpTstates(1222)] wait_for_all_bs1 nok N = 31  listan =  [4] 
[03:08:44 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:08:45 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:08:45 jpTrpc(194)] sisom =  sis1@sis1
 [03:08:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:08:46 jpTrpc(218)] sisom rpc {2,5} 
[03:08:47 jpTstates(1230)] Op1: 2 av1: 5
[03:08:48 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:08:58 jpTstates(1222)] wait_for_all_bs1 nok N = 30  listan =  [4] 
[03:08:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:08:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:09:00 jpTrpc(194)] sisom =  sis1@sis1
 [03:09:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:09:01 jpTrpc(218)] sisom rpc {2,5} 
[03:09:01 jpTstates(1230)] Op1: 2 av1: 5
[03:09:02 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:09:12 jpTstates(1222)] wait_for_all_bs1 nok N = 29  listan =  [4] 
[03:09:12 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:09:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:09:14 jpTrpc(194)] sisom =  sis1@sis1
 [03:09:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:09:15 jpTrpc(218)] sisom rpc {2,5} 
[03:09:15 jpTstates(1230)] Op1: 2 av1: 5
[03:09:16 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:09:26 jpTstates(1222)] wait_for_all_bs1 nok N = 28  listan =  [4] 
[03:09:27 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:09:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:09:27 jpTrpc(194)] sisom =  sis1@sis1
 [03:09:28 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:09:29 jpTrpc(218)] sisom rpc {2,5} 
[03:09:29 jpTstates(1230)] Op1: 2 av1: 5
[03:09:30 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:09:40 jpTstates(1222)] wait_for_all_bs1 nok N = 27  listan =  [4] 
[03:09:40 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:09:41 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:09:41 jpTrpc(194)] sisom =  sis1@sis1
 [03:09:42 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:09:43 jpTrpc(218)] sisom rpc {2,5} 
[03:09:43 jpTstates(1230)] Op1: 2 av1: 5
[03:09:44 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:09:54 jpTstates(1222)] wait_for_all_bs1 nok N = 26  listan =  [4] 
[03:09:54 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:09:55 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:09:55 jpTrpc(194)] sisom =  sis1@sis1
 [03:09:56 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:09:56 jpTrpc(218)] sisom rpc {2,5} 
[03:09:57 jpTstates(1230)] Op1: 2 av1: 5
[03:09:57 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:10:07 jpTstates(1222)] wait_for_all_bs1 nok N = 25  listan =  [4] 
[03:10:08 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:10:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:10:09 jpTrpc(194)] sisom =  sis1@sis1
 [03:10:10 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:10:10 jpTrpc(218)] sisom rpc {2,5} 
[03:10:10 jpTstates(1230)] Op1: 2 av1: 5
[03:10:11 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:10:22 jpTstates(1222)] wait_for_all_bs1 nok N = 24  listan =  [4] 
[03:10:22 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:10:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:10:23 jpTrpc(194)] sisom =  sis1@sis1
 [03:10:23 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:10:24 jpTrpc(218)] sisom rpc {2,5} 
[03:10:25 jpTstates(1230)] Op1: 2 av1: 5
[03:10:25 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:10:36 jpTstates(1222)] wait_for_all_bs1 nok N = 23  listan =  [4] 
[03:10:36 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:10:36 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:10:37 jpTrpc(194)] sisom =  sis1@sis1
 [03:10:38 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:10:38 jpTrpc(218)] sisom rpc {2,5} 
[03:10:39 jpTstates(1230)] Op1: 2 av1: 5
[03:10:39 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:10:49 jpTstates(1222)] wait_for_all_bs1 nok N = 22  listan =  [4] 
[03:10:50 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:10:50 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:10:51 jpTrpc(194)] sisom =  sis1@sis1
 [03:10:52 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:10:52 jpTrpc(218)] sisom rpc {2,5} 
[03:10:53 jpTstates(1230)] Op1: 2 av1: 5
[03:10:53 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:11:04 jpTstates(1222)] wait_for_all_bs1 nok N = 21  listan =  [4] 
[03:11:04 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:11:05 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:11:05 jpTrpc(194)] sisom =  sis1@sis1
 [03:11:06 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:11:06 jpTrpc(218)] sisom rpc {2,5} 
[03:11:07 jpTstates(1230)] Op1: 2 av1: 5
[03:11:07 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:11:18 jpTstates(1222)] wait_for_all_bs1 nok N = 20  listan =  [4] 
[03:11:18 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:11:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:11:20 jpTrpc(194)] sisom =  sis1@sis1
 [03:11:20 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:11:20 jpTrpc(218)] sisom rpc {2,5} 
[03:11:21 jpTstates(1230)] Op1: 2 av1: 5
[03:11:21 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:11:32 jpTstates(1222)] wait_for_all_bs1 nok N = 19  listan =  [4] 
[03:11:32 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:11:33 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:11:33 jpTrpc(194)] sisom =  sis1@sis1
 [03:11:34 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:11:34 jpTrpc(218)] sisom rpc {2,5} 
[03:11:35 jpTstates(1230)] Op1: 2 av1: 5
[03:11:36 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:11:46 jpTstates(1222)] wait_for_all_bs1 nok N = 18  listan =  [4] 
[03:11:46 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:11:47 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:11:47 jpTrpc(194)] sisom =  sis1@sis1
 [03:11:48 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:11:48 jpTrpc(218)] sisom rpc {2,5} 
[03:11:49 jpTstates(1230)] Op1: 2 av1: 5
[03:11:49 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:12:00 jpTstates(1222)] wait_for_all_bs1 nok N = 17  listan =  [4] 
[03:12:00 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:12:01 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:12:02 jpTrpc(194)] sisom =  sis1@sis1
 [03:12:02 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:12:03 jpTrpc(218)] sisom rpc {2,5} 
[03:12:03 jpTstates(1230)] Op1: 2 av1: 5
[03:12:04 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:12:14 jpTstates(1222)] wait_for_all_bs1 nok N = 16  listan =  [4] 
[03:12:15 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:12:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:12:16 jpTrpc(194)] sisom =  sis1@sis1
 [03:12:17 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:12:17 jpTrpc(218)] sisom rpc {2,5} 
[03:12:18 jpTstates(1230)] Op1: 2 av1: 5
[03:12:18 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:12:28 jpTstates(1222)] wait_for_all_bs1 nok N = 15  listan =  [4] 
[03:12:29 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:12:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:12:30 jpTrpc(194)] sisom =  sis1@sis1
 [03:12:31 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:12:31 jpTrpc(218)] sisom rpc {2,5} 
[03:12:32 jpTstates(1230)] Op1: 2 av1: 5
[03:12:32 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:12:43 jpTstates(1222)] wait_for_all_bs1 nok N = 14  listan =  [4] 
[03:12:43 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:12:44 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:12:45 jpTrpc(194)] sisom =  sis1@sis1
 [03:12:46 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:12:46 jpTrpc(218)] sisom rpc {2,5} 
[03:12:46 jpTstates(1230)] Op1: 2 av1: 5
[03:12:47 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:12:57 jpTstates(1222)] wait_for_all_bs1 nok N = 13  listan =  [4] 
[03:12:58 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:12:58 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:12:59 jpTrpc(194)] sisom =  sis1@sis1
 [03:13:00 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:13:00 jpTrpc(218)] sisom rpc {2,5} 
[03:13:01 jpTstates(1230)] Op1: 2 av1: 5
[03:13:01 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:13:12 jpTstates(1222)] wait_for_all_bs1 nok N = 12  listan =  [4] 
[03:13:12 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:13:13 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:13:14 jpTrpc(194)] sisom =  sis1@sis1
 [03:13:14 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:13:15 jpTrpc(218)] sisom rpc {2,5} 
[03:13:15 jpTstates(1230)] Op1: 2 av1: 5
[03:13:16 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:13:27 jpTstates(1222)] wait_for_all_bs1 nok N = 11  listan =  [4] 
[03:13:27 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:13:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:13:28 jpTrpc(194)] sisom =  sis1@sis1
 [03:13:29 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:13:29 jpTrpc(218)] sisom rpc {2,5} 
[03:13:30 jpTstates(1230)] Op1: 2 av1: 5
[03:13:30 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:13:41 jpTstates(1222)] wait_for_all_bs1 nok N = 10  listan =  [4] 
[03:13:41 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:13:42 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:13:42 jpTrpc(194)] sisom =  sis1@sis1
 [03:13:43 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:13:44 jpTrpc(218)] sisom rpc {2,5} 
[03:13:44 jpTstates(1230)] Op1: 2 av1: 5
[03:13:44 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:13:55 jpTstates(1222)] wait_for_all_bs1 nok N = 9  listan =  [4] 
[03:13:56 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:13:56 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:13:57 jpTrpc(194)] sisom =  sis1@sis1
 [03:13:57 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:13:58 jpTrpc(218)] sisom rpc {2,5} 
[03:13:58 jpTstates(1230)] Op1: 2 av1: 5
[03:13:59 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:14:10 jpTstates(1222)] wait_for_all_bs1 nok N = 8  listan =  [4] 
[03:14:10 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:14:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:14:11 jpTrpc(194)] sisom =  sis1@sis1
 [03:14:12 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:14:12 jpTrpc(218)] sisom rpc {2,5} 
[03:14:13 jpTstates(1230)] Op1: 2 av1: 5
[03:14:13 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:14:24 jpTstates(1222)] wait_for_all_bs1 nok N = 7  listan =  [4] 
[03:14:24 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:14:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:14:25 jpTrpc(194)] sisom =  sis1@sis1
 [03:14:26 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:14:26 jpTrpc(218)] sisom rpc {2,5} 
[03:14:27 jpTstates(1230)] Op1: 2 av1: 5
[03:14:28 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:14:38 jpTstates(1222)] wait_for_all_bs1 nok N = 6  listan =  [4] 
[03:14:39 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:14:39 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:14:40 jpTrpc(194)] sisom =  sis1@sis1
 [03:14:40 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:14:41 jpTrpc(218)] sisom rpc {2,5} 
[03:14:41 jpTstates(1230)] Op1: 2 av1: 5
[03:14:42 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:14:52 jpTstates(1222)] wait_for_all_bs1 nok N = 5  listan =  [4] 
[03:14:52 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:14:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:14:53 jpTrpc(194)] sisom =  sis1@sis1
 [03:14:54 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:14:55 jpTrpc(218)] sisom rpc {2,5} 
[03:14:55 jpTstates(1230)] Op1: 2 av1: 5
[03:14:55 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:15:06 jpTstates(1222)] wait_for_all_bs1 nok N = 4  listan =  [4] 
[03:15:06 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:15:07 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:15:08 jpTrpc(194)] sisom =  sis1@sis1
 [03:15:08 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:15:09 jpTrpc(218)] sisom rpc {2,5} 
[03:15:09 jpTstates(1230)] Op1: 2 av1: 5
[03:15:10 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:15:20 jpTstates(1222)] wait_for_all_bs1 nok N = 3  listan =  [4] 
[03:15:21 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:15:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:15:22 jpTrpc(194)] sisom =  sis1@sis1
 [03:15:22 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:15:23 jpTrpc(218)] sisom rpc {2,5} 
[03:15:23 jpTstates(1230)] Op1: 2 av1: 5
[03:15:24 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:15:34 jpTstates(1222)] wait_for_all_bs1 nok N = 2  listan =  [4] 
[03:15:35 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:15:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:15:36 jpTrpc(194)] sisom =  sis1@sis1
 [03:15:36 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:15:37 jpTrpc(218)] sisom rpc {2,5} 
[03:15:38 jpTstates(1230)] Op1: 2 av1: 5
[03:15:38 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:15:48 jpTstates(1222)] wait_for_all_bs1 nok N = 1  listan =  [4] 
[03:15:49 jpTstates(1227)] wait_for_all_bs1 H 4 NokList [] 
[03:15:49 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0}] 
[03:15:50 jpTrpc(194)] sisom =  sis1@sis1
 [03:15:50 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:15:51 jpTrpc(218)] sisom rpc {2,5} 
[03:15:52 jpTstates(1230)] Op1: 2 av1: 5
[03:15:52 jpTstates(1239)] add_if_not_ok BsNo 4  nok listan =  [] 
[03:15:53 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,pwfab,1},
                                      {jpTstates,wait_for_all_bs1,4},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0}] 
[03:15:53 jpTrpc(194)] sisom =  sis1@sis1
 [03:15:54 jpTrpc(196)] sisom calling module: hwmMiState  func: get_bs_op_and_avail_status arg: [4]
 [03:15:54 jpTrpc(218)] sisom rpc {2,5} 
[03:15:55 jpTstates(1249)] pwfab H= 4 Op = 2 Av = 5 
[03:15:55 jpTstates(1244)] pwfab  
[03:15:56 jpTstates(1215)] wait_for_all_bs1 nok listan =  [4] 
[03:15:57 jpTrub(755)] All bs is not ok  {nok,[4]} Bs states 
[03:15:57 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[03:15:58 jpTrpc(194)] sisom =  sis1@sis1
 [03:15:58 jpTrpc(196)] sisom calling module: hwmDbg  func: bs arg: []
 [03:15:59 jpTrpc(218)] sisom rpc {ok,[{\"bs_SIS_1\",
                [{bs_no,1},
                 {bs_swg,\"CXS10138\",\"R2E23\"},
                 {cxr,\"CXR1010168\",\"R2B19\"},
                 {user_label,\"SIS\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_2\",
                [{bs_no,2},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_3\",
                [{bs_no,3},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MGW_4\",
                [{bs_no,4},
                 {bs_swg,\"CXS10176\",\"R3A08\"},
                 {cxr,[],[]},
                 {user_label,\"mgw_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,degraded}]},
               {\"bs_ISER_5\",
                [{bs_no,5},
                 {bs_swg,\"CXS10164\",\"R2A13\"},
                 {cxr,[],[]},
                 {user_label,\"cer_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_6\",
                [{bs_no,6},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_7\",
                [{bs_no,7},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[03:15:59 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTrub,wait4,0},
                                      {jpTrub,reboot_om_sis,0},
                                      {jpTrub,is_only,0},
                                      {test_server,my_apply,3}] 
[03:16:00 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:01 jpTrpc(196)] sisom calling module: hwmDbg  func: bl arg: []
 [03:16:01 jpTrpc(218)] sisom rpc {ok,[{{0,0},
                [{bs_no,2},
                 {bs_id,\"bs_MXB_2\"},
                 {swg_lowest,\"CXS101039\",\"P2A\"},
                 {swg_actual,\"CXS101039\",\"R2E03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,1},
                [{bs_no,1},
                 {bs_id,\"bs_SIS_1\"},
                 {swg_lowest,\"CXS10137\",\"R2A\"},
                 {swg_actual,\"CXS10137\",\"R2E11\"},
                 {user_label,\"sis1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,5},
                [{bs_no,6},
                 {bs_id,\"bs_EXB_6\"},
                 {swg_lowest,\"CXS101040\",\"P2A\"},
                 {swg_actual,\"CXS101040\",\"R2E04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,13},
                [{bs_no,1},
                 {bs_id,\"bs_SIS_1\"},
                 {swg_lowest,\"CXS10137\",\"R2A\"},
                 {swg_actual,\"CXS10137\",\"R2E11\"},
                 {user_label,\"sis2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,15},
                [{bs_no,4},
                 {bs_id,\"bs_MGW_4\"},
                 {swg_lowest,\"CXS101059\",\"R2B\"},
                 {swg_actual,\"CXS101059\",\"R3A04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,19},
                [{bs_no,4},
                 {bs_id,\"bs_MGW_4\"},
                 {swg_lowest,\"CXS101059\",\"R2B\"},
                 {swg_actual,\"CXS101059\",\"R3A04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,disabled},
                 {avail_state,failed}]},
               {{0,22},
                [{bs_no,5},
                 {bs_id,\"bs_ISER_5\"},
                 {swg_lowest,\"CXS10163\",\"R2A13\"},
                 {swg_actual,\"CXS10163\",\"R2A13\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,24},
                [{bs_no,7},
                 {bs_id,\"bs_EXB_7\"},
                 {swg_lowest,\"CXS101040\",\"P2A\"},
                 {swg_actual,\"CXS101040\",\"R2E04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,25},
                [{bs_no,3},
                 {bs_id,\"bs_MXB_3\"},
                 {swg_lowest,\"CXS101039\",\"P2A\"},
                 {swg_actual,\"CXS101039\",\"R2E03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[03:16:02 jpTio(222)] Waiting for unique name for expander...[03:16:03 jpTio(225)] Got unique name for expander![03:16:04 jpTio(222)] Waiting for unique name for expander...[03:16:05 jpTio(225)] Got unique name for expander![03:16:06 jpTinit(267)] Stop logging  Conf:all TestCase: is_only_in_jpTrub  
[03:16:06 jpTinit(522)] get_mbs 
[03:16:07 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [03:16:08 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:08 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:09 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [03:16:10 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[03:16:10 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:10 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:11 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [03:16:12 jpTrpc(218)] sisom rpc \"SIS\" 
[03:16:12 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:13 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:14 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [03:16:14 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[03:16:15 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:15 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:16 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [03:16:16 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[03:16:17 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:17 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:18 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [03:16:18 jpTrpc(218)] sisom rpc \"mgw_1\" 
[03:16:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:20 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:21 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [5]
 [03:16:21 jpTrpc(218)] sisom rpc \"cer_1\" 
[03:16:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:22 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:22 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [6]
 [03:16:23 jpTrpc(218)] sisom rpc \"exb_1\" 
[03:16:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:24 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:25 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [7]
 [03:16:25 jpTrpc(218)] sisom rpc \"exb_2\" 
[03:16:26 jpTinit(531)] get_mbs \"mp_1\" 
[03:16:27 jpTrpc(188)] sisom calling module: hwmDbase  func: get_all_bs_no
 [03:16:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,1},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:28 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:28 jpTrpc(196)] sisom calling module: hwmDbase  func: get_all_bs_no arg: []
 [03:16:29 jpTrpc(218)] sisom rpc [1,2,3,4,5,6,7] 
[03:16:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:30 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:31 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [1]
 [03:16:31 jpTrpc(218)] sisom rpc \"SIS\" 
[03:16:32 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:32 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:32 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [2]
 [03:16:33 jpTrpc(218)] sisom rpc \"MXB slot 0\" 
[03:16:34 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:34 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:35 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [3]
 [03:16:35 jpTrpc(218)] sisom rpc \"MXB slot 25\" 
[03:16:35 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTnames,find_bs_no,2},
                                      {jpTinit,get_mbs,1},
                                      {jpTinit,get_mbs_alarms,0},
                                      {jpTinit,stop_log,2}] 
[03:16:36 jpTrpc(194)] sisom =  sis1@sis1
 [03:16:37 jpTrpc(196)] sisom calling module: hwmDbase  func: get_bs_user_name arg: [4]
 [03:16:38 jpTrpc(218)] sisom rpc \"mgw_1\" 
[03:16:38 jpTinit(535)] get_mbs nr: 4 name: \"mgw_1\" 
[03:16:39 jpTinit(516)] get_mbs_alarms from \"mgw_1\"  
[03:16:39 jpTmbs(121)] checking alarms on  Blade system: \"mgw_1\"
 [03:16:40 jpTstates(322)] Cp \"mgw_1\" 
[03:16:40 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:41 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:41 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:42 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:42 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:43 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:16:43 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:44 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:44 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:45 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:45 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:45 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:16:47 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:47 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:48 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:48 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:48 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:49 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:16:50 jpTstates(322)] Cp \"mgw_1\" 
[03:16:50 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:51 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:51 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:51 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:52 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:53 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:16:54 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:54 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:54 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:55 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:55 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:56 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:16:57 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:57 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:58 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:58 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:16:59 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:00 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:17:00 jpTstates(322)] Cp \"mgw_1\" 
[03:17:01 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:01 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:01 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:02 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:03 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:04 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:17:04 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:05 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:05 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:05 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:06 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:07 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:17:07 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:08 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:08 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:09 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:10 jpTrpc(755)] translate return nok  \"Cannot find keyword in table\" 
[03:17:10 jpTrpc(738)] Set cookie bs_MGW_4 to [ppb1_bs4@blade_0_15,ppb2_bs4@blade_0_19] 
[03:17:10 jpTio(222)] Waiting for unique name for expander...[03:17:11 jpTio(225)] Got unique name for expander![03:17:11 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTstates,ale,1},
                                      {jpTinit,stop_log,2},
                                      {jpTinit,end_per_testcase,2},
                                      {basic_SUITE,end_per_testcase,2}] 
[03:17:12 jpTrpc(194)] sisom =  sis1@sis1
 [03:17:13 jpTrpc(196)] sisom calling module: ets  func: tab2list arg: [isFmCurrentAlarmTable]
 [03:17:14 jpTrpc(218)] sisom rpc [{isFmCurrentAlarmTable,472,
                                  \"bs_SIS_1\",
                                  395,
                                  \"ispDestAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,5,9,54,58,0,43,0,0],
                                  \"SIS:ISP\",
                                  2,
                                  3,
                                  \"Configuration error: Host\",
                                  5,
                                  []},
           {isFmCurrentAlarmTable,685,
                                  \"bs_MGW_4\",
                                  18,
                                  \"lossOfTransmitClockSourceAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,1,44,6,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"Its not possible to get synchronization from the link or both MXB clocks are unavailable, depending on netsynch configuration:  (0-15).\",
                                  15,
                                  \"Subrack 0, Slot 15 (X50). (BS name: mgw_1)  Error: 0x5230000\"},
           {isFmCurrentAlarmTable,696,
                                  \"bs_MGW_4\",
                                  26,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,2,17,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss of Signal on signalling link:  (0-19).\",
                                  29,
                                  \"Subrack 0, Slot 19 (X62). (BS name: mgw_1)  Error: 0x9010000\"},
           {isFmCurrentAlarmTable,697,
                                  \"bs_MGW_4\",
                                  27,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,2,17,4,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss Of Signal on link:  (0-19).\",
                                  29,
                                  \"Subrack 0, Slot 19 (X62). (BS name: mgw_1)  Error: 0x5010000\"},
           {isFmCurrentAlarmTable,695,
                                  \"bs_MGW_4\",
                                  25,
                                  \"lossOfTransmitClockSourceAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,2,17,2,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"Its not possible to get synchronization from the link or both MXB clocks are unavailable, depending on netsynch configuration:  (0-19).\",
                                  15,
                                  \"Subrack 0, Slot 19 (X62). (BS name: mgw_1)  Error: 0x5230000\"},
           {isFmCurrentAlarmTable,686,
                                  \"bs_MGW_4\",
                                  19,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,1,44,6,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss of Signal on signalling link:  (0-15).\",
                                  29,
                                  \"Subrack 0, Slot 15 (X50). (BS name: mgw_1)  Error: 0x9010000\"},
           {isFmCurrentAlarmTable,688,
                                  \"bs_MGW_4\",
                                  20,
                                  \"physicalLinkAlarm\",
                                  \"isMinorAlarm\",
                                  [7,214,12,6,1,44,6,0,43,0,0],
                                  \"mgw_1:bs_MGW_4\",
                                  2,
                                  3,
                                  \"LOS, Loss Of Signal on link:  (0-15).\",
                                  29,
                                  \"Subrack 0, Slot 15 (X50). (BS name: mgw_1)  Error: 0x5010000\"}] 
[03:17:14 jpTinit(273)] OwnNameList [\"mp_1\",\"mgw_1\"]
[03:17:15 jpTinit(401)] stoplogging \"mp_1\" 
[03:17:16 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:18 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:19 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:20 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:21 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:21 jpTinit(401)] stoplogging \"mgw_1\" 
[03:17:22 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:24 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:25 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:26 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:27 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:28 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:29 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,get_log_info,1},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,same_file,5},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:30 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,same_file,5},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,same_file,5},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:31 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTlogging,logpath,1},
                                      {jpTlogging,same_file,5},
                                      {jpTlogging,get_logging_loop_reply,4},
                                      {jpTlogging,wait_for_stop_command,4}] 
[03:17:32 jpTinit(398)] stoplogging dune 
[03:17:36 jpTinit(283)] No crash in the SIS logs [03:17:37 jpTinit(299)] No crash in the MBS logs [03:17:37 jpTinit(333)] Stop hwm Conf:all 
[03:17:37 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTinit,stop_hwm,1},
                                      {jpTinit,end_per_testcase,2},
                                      {basic_SUITE,end_per_testcase,2},
                                      {test_server,my_apply,3}] 
[03:17:38 jpTrpc(194)] sisom =  sis1@sis1
 [03:17:38 jpTrpc(196)] sisom calling module: hwmDbg  func: bs arg: []
 [03:17:39 jpTrpc(218)] sisom rpc {ok,[{\"bs_SIS_1\",
                [{bs_no,1},
                 {bs_swg,\"CXS10138\",\"R2E23\"},
                 {cxr,\"CXR1010168\",\"R2B19\"},
                 {user_label,\"SIS\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_2\",
                [{bs_no,2},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MXB_3\",
                [{bs_no,3},
                 {bs_swg,\"CXS10144\",\"R2E02\"},
                 {cxr,\"CXR1010336\",\"R2B03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_MGW_4\",
                [{bs_no,4},
                 {bs_swg,\"CXS10176\",\"R3A08\"},
                 {cxr,[],[]},
                 {user_label,\"mgw_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_ISER_5\",
                [{bs_no,5},
                 {bs_swg,\"CXS10164\",\"R2A13\"},
                 {cxr,[],[]},
                 {user_label,\"cer_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_6\",
                [{bs_no,6},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {\"bs_EXB_7\",
                [{bs_no,7},
                 {bs_swg,\"CXS10148\",\"R2E01\"},
                 {cxr,[],[]},
                 {user_label,\"exb_2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[03:17:40 jpTnames(217)] Name is  [sis1@sis1,sis2@sis2] Stack [{jpTnames,find_node_name,1},
                                      {jpTstates,find_rule,1},
                                      {jpTrpc,sisom,3},
                                      {jpTinit,stop_hwm,1},
                                      {jpTinit,end_per_testcase,2},
                                      {basic_SUITE,end_per_testcase,2},
                                      {test_server,my_apply,3}] 
[03:17:40 jpTrpc(194)] sisom =  sis1@sis1
 [03:17:41 jpTrpc(196)] sisom calling module: hwmDbg  func: bl arg: []
 [03:17:41 jpTrpc(218)] sisom rpc {ok,[{{0,0},
                [{bs_no,2},
                 {bs_id,\"bs_MXB_2\"},
                 {swg_lowest,\"CXS101039\",\"P2A\"},
                 {swg_actual,\"CXS101039\",\"R2E03\"},
                 {user_label,\"MXB slot 0\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,1},
                [{bs_no,1},
                 {bs_id,\"bs_SIS_1\"},
                 {swg_lowest,\"CXS10137\",\"R2A\"},
                 {swg_actual,\"CXS10137\",\"R2E11\"},
                 {user_label,\"sis1\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,5},
                [{bs_no,6},
                 {bs_id,\"bs_EXB_6\"},
                 {swg_lowest,\"CXS101040\",\"P2A\"},
                 {swg_actual,\"CXS101040\",\"R2E04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,13},
                [{bs_no,1},
                 {bs_id,\"bs_SIS_1\"},
                 {swg_lowest,\"CXS10137\",\"R2A\"},
                 {swg_actual,\"CXS10137\",\"R2E11\"},
                 {user_label,\"sis2\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,15},
                [{bs_no,4},
                 {bs_id,\"bs_MGW_4\"},
                 {swg_lowest,\"CXS101059\",\"R2B\"},
                 {swg_actual,\"CXS101059\",\"R3A04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,19},
                [{bs_no,4},
                 {bs_id,\"bs_MGW_4\"},
                 {swg_lowest,\"CXS101059\",\"R2B\"},
                 {swg_actual,\"CXS101059\",\"R3A04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,22},
                [{bs_no,5},
                 {bs_id,\"bs_ISER_5\"},
                 {swg_lowest,\"CXS10163\",\"R2A13\"},
                 {swg_actual,\"CXS10163\",\"R2A13\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,24},
                [{bs_no,7},
                 {bs_id,\"bs_EXB_7\"},
                 {swg_lowest,\"CXS101040\",\"P2A\"},
                 {swg_actual,\"CXS101040\",\"R2E04\"},
                 {user_label,[]},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]},
               {{0,25},
                [{bs_no,3},
                 {bs_id,\"bs_MXB_3\"},
                 {swg_lowest,\"CXS101039\",\"P2A\"},
                 {swg_actual,\"CXS101039\",\"R2E03\"},
                 {user_label,\"MXB slot 25\"},
                 {adm_state,unlocked},
                 {op_state,enabled},
                 {avail_state,available}]}]} 
[03:17:42 jpTio(222)] Waiting for unique name for expander...[03:17:42 jpTio(225)] Got unique name for expander![03:17:44 jpTio(222)] Waiting for unique name for expander...[03:17:44 jpTio(225)] Got unique name for expander!".
