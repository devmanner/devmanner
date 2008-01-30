%%% #0.    BASIC INFORMATION
%%% ----------------------------------------------------------
%%% scan.erl 
%%% Author:	 Tomas Mannerstedt, qtomama
%%% Description: Erlang module for scanning the swift lab.
%%%             
%%% ----------------------------------------------------------

-module(scan).

%%% ----------------------------------------------------------------------
%%% Copyright (C) 2006 by Ericsson AB
%%% S - 125 26  STOCKHOLM
%%% SWEDEN, tel int + 46 8 719 0000
%%% 
%%% The program may be used and/or copied only with the written
%%% permission from Ericsson Telecom AB, or in accordance with
%%% the terms and conditions stipulated in the agreement/contract
%%% under which the program has been supplied.
%%%   
%%% All rights reserved
%%% 
%%% -----------------------------------------------------------------------
%%% #1.		REVISION LOG
%%% -----------------------------------------------------------------------
%%% Rev		Date		Name		What
%%% -----------------------------------------------------------------------
%%%             2006-09-06      qtomama         First edit
%%% -----------------------------------------------------------------------
%%% 
%%% #2.    EXPORT LISTS
%%% ----------------------------------------------------------
%%% #2.1   EXPORTED INTERFACE FUNCTIONS
%%% ----------------------------------------------------------

-export([scan/0, scan_seq/0, scan_remote/1, scan_remote/2, scan_site/0, ping_host/1, kill_all_nodes/0]).

-compile(export_all).

-define(FIRST_SLOT, 0).
-define(LAST_SLOT, 25).
-define(FIRST_SUBRACK, 0).
-define(LAST_SUBRACK, 10).
-define(SIS_COOKIE, bs_SIS_1).
-define(SCANNER_COOKIE, scanner).
-define(PING, "/usr/sbin/ping").
-define(OUTPUT_DIR, "/net/wsl2010/export/raid02/LabScanner/").
%%-define(OUTPUT_DIR, "/home/qtomama/temp/LabScanner/").

%%-define(SITES, [wsl2052]).

-define(TIMEOUT, (1000*60*10)). %% 10 minutes that is.
-define(SPAWN_RETIES, 10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ping a host.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kill_all_nodes() ->
    kill_all_nodes(get_hosts()).
kill_all_nodes(Nodes) ->
    lists:foreach(fun(Site) -> scanner_rpc(Site, erlang, halt, []) end, Nodes).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ping a host.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ping_host(Host) ->
    case string:strip(os:cmd(?PING ++ " " ++ atom_to_list(Host) ++ " 1 > /dev/null && echo alive"), right, $\n) of
        "alive" ->
            pong;
        _ ->
            pang
    end.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get the names of all the sites.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

remove_unpingable(List) ->
    Y = lists:foldl(fun(X, L) ->
			    [{X, rpc:async_call(node(), ?MODULE, ping_host, [X])}] ++ L
		    end, [], List),
    lists:foldl(fun({Host, Key}, L) ->
			case rpc:yield(Key) of
			    pong ->
				[Host] ++ L;
			    pang ->
				L
			end
		end, [], Y).

get_hosts_from_niscat() ->
    {ok, Rows} = regexp:split(os:cmd("niscat netgroup.org_dir | egrep \"(stpcblade|hwiblade)\" | grep wsl"), "\n+"),
    lists:sort(lists:foldl(fun(X, L) -> [list_to_atom(X)] ++ L end, [],
 			   lists:foldr(fun(Row, L) ->
 					       case Row of
 						   [] ->
 						       [];
 						   Row ->
 						       {ok, [_, Host, _]} = regexp:split(Row, " "),
 						       [Host] ++ L
 					       end
 				       end, [], Rows)
 			  )
 	      ).

-ifdef(SITES).
get_hosts() ->
    ?SITES.
-else.
get_hosts() ->
    io:format("Getting hosts...~n"),
    Hosts = remove_unpingable(get_hosts_from_niscat()),
    lists:foreach(fun(X) -> io:format("~p ", [X]) end, Hosts),
    io:format("~ndone!~n"),
    Hosts.
-endif.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get node names.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_node_name(Site) ->
    list_to_atom("scanner@" ++ atom_to_list(Site)).

find_sisoam() ->
    find_sisoam([sis1@sis1,sis2@sis2]).
find_sisoam([]) ->
    none;
find_sisoam([Candidate|T]) ->
    erlang:set_cookie(Candidate, ?SIS_COOKIE),
    case lists:keysearch(oam, 1, rpc:call(Candidate, application, which_applications, [])) of
        {value, _} ->
            Candidate;
        _ ->
	    find_sisoam(T)
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RPC Wrappers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oam_rpc(M, F, A) ->
    SisOAM = find_sisoam(),
    erlang:set_cookie(SisOAM, ?SIS_COOKIE),
    rpc:call(SisOAM, M, F, A, ?TIMEOUT).

scanner_rpc(Site, M, F, A) ->
    Node = get_node_name(Site),
    erlang:set_cookie(Node, ?SCANNER_COOKIE),
    rpc:call(Node, M, F, A, ?TIMEOUT).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spawn a node on a remote host.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spawn_node(Site) ->
    spawn_node(Site, ?SPAWN_RETIES).
spawn_node(Site, 0) ->
    {nok, "Cannot spawn erlang node on: " ++ atom_to_list(Site)};
spawn_node(Site, Retries) ->
    Node = get_node_name(Site),
    erlang:set_cookie(Node, ?SCANNER_COOKIE),
    case net_adm:ping(Node) of
 	pang ->
 	    os:cmd("rsh " ++ atom_to_list(Site) ++ " " ++ ?BASE_DIR ++ "/bin/spawn_node.sh"),
	    spawn_node(Site, Retries-1);
	pong ->
	    ok
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scanner functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scan_pos(Subrack, Slot) ->
    case oam_rpc(rsm_test, get_boarddata, [Subrack, Slot]) of
	["---", "---", "---", "---", "---", "---"] ->
	    [];
	[ROJ, REV, Type, Serial, Date, Vendor] ->
	    [{product_number, ROJ}, {revision, REV}, {type, Type}, {serial, Serial}, {date, Date}, {vendor, Vendor}]
    end.

scan_subrack(Subrack) ->
    Fun = fun(Slot, L) ->
		  L ++ case scan_pos(Subrack, Slot) of
			   [] ->
			       [];
			   R ->
			       [[{subrack, Subrack}, {slot, Slot}, {board, R}]]
		       end
	  end,
    lists:foldl(Fun, [], lists:seq(?FIRST_SLOT, ?LAST_SLOT)).

scan_site() ->
    lists:foldl(fun(Subrack, L) -> L ++ scan_subrack(Subrack) end, [], lists:seq(?FIRST_SUBRACK, ?LAST_SUBRACK)).

scan_remote(Site) ->
    scan_remote(none, Site).
scan_remote(Parent, Site) ->
    Reply = case spawn_node(Site) of
		ok ->
		    scanner_rpc(Site, shell_default, l, [?MODULE]),
		    Result = case scanner_rpc(Site, ?MODULE, scan_site, []) of
				 {badrpc, _} -> [];
				 R -> R
			     end,
		    print_result(Site, Result),
		    Result;
		{nok, Error} ->
		    io:format("ERROR: ~s~n", [Error]),
		    []
	    end,
    case Parent of
	none ->
	    {Site, Reply};
	_ ->
	    Parent ! {Site, Reply}
    end.

%% Non concurrent scan. O(n)
scan_seq() ->
    Sites = get_hosts(),
    Fun = fun(Site, L) ->
		  R = ?MODULE:scan_remote(Site),
		  io:format("~p ", [Site]),
		  [R] ++ L
	  end,
    io:format("Starting scan... ~nGot result from:~n"),
    R = lists:keysort(1, lists:foldr(Fun, [], Sites)),
    io:format("done!~n"),
    print_full_table(R),
    R.

%% Concurrent scan. O(1)
scan() ->
    Sites = get_hosts(),
    backup_files(Sites),
    io:format("Starting scan... "),    
    Fun = fun(Site) ->
		  spawn(?MODULE, scan_remote, [self(), Site])
	  end,
    lists:foreach(Fun, Sites),
    io:format("done!~nGot result from:~n"),
    R = lists:keysort(1, get_replies(length(Sites))),
    io:format("~ndone!~n"),
    print_full_table(R),
    kill_all_nodes(Sites),
    R.

get_replies(0) ->
    [];
get_replies(N) ->
    receive
	{Site, Result} ->
	    io:format("~p ", [Site]),
	    [{Site, Result}] ++ get_replies(N-1)
    after 10*1000 ->
	    get_replies(N-1)
    end.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Backup Files functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

backup_files(Sites) ->
    %% Fun for backing up wsl-files.
    Fun = fun(Site) -> backup_file(?OUTPUT_DIR ++ atom_to_list(Site) ++ "/stpinfo") end,
    lists:foreach(Fun, Sites),
    backup_file(?OUTPUT_DIR ++ "hw.txt").

backup_file(File) ->
    case filelib:last_modified(File) of
	0 -> ok; %% File does not exist.
	{Date,Time} ->
	    DateStr = lists:flatten(io_lib:format("~p-~.2.0w-~.2.0w_~.2.0w:~.2.0w:~.2.0w", lists:flatten(tuple_to_list(Date) ++ tuple_to_list(Time)))),
	    os:cmd("cp " ++ File ++ " " ++ File ++ "_" ++ DateStr)
    end.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Print result functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lookup(What, List) ->
    case lists:keysearch(What, 1, List) of
	{value, {What, Value}} ->
	    Value;
	_ -> []
    end.

print_site_inv(IoDevice, Site, Row) ->
    Fun = fun(Pos) ->
		  Subrack = lookup(subrack, Pos),
		  Slot = lookup(slot, Pos),
		  Board = lookup(board, Pos),
		  Product = lookup(product_number, Board),
		  Revision = lookup(revision, Board),
		  Type = lookup(type, Board),
		  Serial = lookup(serial, Board),
		  Date = lookup(date, Board),
		  Vendor = lookup(vendor, Board),
		  io:format(IoDevice, "%% | ~p\t| ~p\t\t| ~p\t| ~-20s| ~-10s| ~-10s| ~-15s| ~-10s| ~-15s|~n", [Site, Subrack, Slot, Product, Revision, Type, Serial, Date, Vendor])
	  end,
    lists:foreach(Fun, Row).

print_result(Site, Result) ->
    OutDir = ?OUTPUT_DIR ++ atom_to_list(Site),
    OutFile = OutDir ++ "/stpinfo",
    case filelib:is_dir(OutDir) of
	true -> ok;
	false -> file:make_dir(OutDir)
    end,
    print_full_table([{Site, Result}], OutFile).

print_full_table(Result) ->
    print_full_table(Result, ?OUTPUT_DIR ++ "/hw.txt").

print_full_table(Result, Fname) ->
    case file:open(Fname, [write]) of
	{ok, IoDevice} ->
	    io:format(IoDevice, "%% ~.130c~n", [$-]),
	    io:format(IoDevice, "%% Scanning made ~s", [os:cmd("date")]),
	    io:format(IoDevice, "%% ~.130c~n", [$-]),
	    io:format(IoDevice, "%% | ~s\t| ~s\t| ~s\t| ~-20s| ~-10s| ~-10s| ~-15s| ~-10s| ~-15s|~n", ["Site", "Subrack", "Slot", "Product", "Revision", "Type", "Serial", "Date", "Vendor"]),
	    io:format(IoDevice, "%% ~.130c~n", [$-]),
	    
	    lists:foreach(fun({Site, Boards}) -> print_site_inv(IoDevice, Site, Boards) end, Result),
	    
	    io:format(IoDevice, "%% ~.130c~n", [$-]),
	    io:format(IoDevice, "%% This part contains the same information expressed in erlang terms:~n~p.", [Result]),
	    file:close(IoDevice);
	_ ->
	    io:format("Ooops... seems like I can't write the output to: ~s~n", [Fname])
    end.
