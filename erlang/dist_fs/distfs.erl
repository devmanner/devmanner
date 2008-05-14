-module(distfs).

-compile(export_all).

%% Messages:
%% {get_pids, FromPid}     -> {pids, PidList}
%% {get_files, FromPid}    -> {all_files, [{"path/file.x", <<FileCont>>}...]}
%% {add_pid, PidToAdd}     -> No reply
%% {updates, 


start(Dir) ->
    register(?MODULE, spawn(fun() ->
				    dist_loop([], read_dir(Dir)),
				    io:format("Dead!~n")
			    end)).
start(OtherNode, Dir) ->
    register(?MODULE, spawn(fun() -> start_client(OtherNode, Dir), io:format("Dead!~n") end)).
start_client(OtherNode, Dir) ->
    OtherPid = rpc:call(OtherNode, erlang, whereis, [?MODULE]),
    OtherPid ! {get_pids, self()},
    receive
	{pids, PidList} ->
	    io:format("Got some pids: ~p~n", [PidList]),
	    lists:foreach(fun(P) -> P ! {add_pid, self()} end, PidList),
	    OtherPid ! {get_files, self()},
	    receive
		{all_files, FileList} ->
		    io:format("Got some files: ~p~n", [FileList]),
		    FileListWBase = lists:map(fun({F, X}) ->
						      {Dir ++ "/" ++ F, X}
					      end, FileList),
		    lists:foreach(fun({F, C}) -> store_file(F, C) end, FileListWBase),
		    dist_loop(PidList, read_dir(Dir))
	    end
    end.

dist_loop(PidList, FileList) ->
    io:format("PidList: ~p~n", [PidList]),
    receive
	kill ->
	    io:format("Terminating...~n");
	{get_pids, Pid} ->
	    io:format("Getting pids pid: ~p~n", [Pid]),
	    Pid ! {pids, PidList ++ [self()]},
	    dist_loop(PidList, FileList);
	{add_pid, Pid} ->
	    io:format("Adding pid: ~p~n", [Pid]),
	    dist_loop([Pid] ++ PidList, FileList);
	{get_files, Pid} ->
	    io:format("Getting files pid: ~p~n", [Pid]),
	    AllFiles = lists:map(fun({F,_}) -> {ok, C} = file:read_file(F), {F, C} end, FileList),
	    Pid ! {all_files, AllFiles},
	    dist_loop(PidList, FileList);
%% 	{updates, UpdatedFileList, DeletedFileList} ->
%% 	    io:format("Got some file updates: ~p~n", [FileList]),
%% 	    lists:foreach(fun({F, C}) -> store_file(F, C) end, UpdatedFileList),
%% 	    lists:foreach(fun file:delete/1, DeletedFileList),
%% 	    dist_loop(PidList, FileList);
	X ->
	    io:format("Undefined message: ~p~n", [X]),
	    dist_loop(PidList, FileList)
    end.

store_file(FileName, FileContens) ->
    io:format("Writing: ~p to : ~s~n", [FileContens, FileName]),
    R = file:make_dir(filename:dirname(FileName)),
    io:format("Res: ~p~n", [R]),
    {ok, FD} = file:open(FileName, [write]),
    ok = file:write(FD, FileContens),
    ok = file:close(FD),
    io:format("Successfully stored: ~s~n", [FileName]).

send_file(File, Pid) ->
    {ok, FileCont} = file:read(File),
    Pid ! FileCont.

read_dir(Dir) ->
    {ok, Contens} = file:list_dir(Dir),
    Fun = fun(F) ->
		  Fname = filename:join(Dir, F),
		  case file:read_file_info(Fname) of
		      {ok,{_,_,directory,_,_,_,_,_,_,_,_,_,_,_}} ->
			  read_dir(Fname);
		      {ok,{_,_,regular,_,_,Flastmod,_,_,_,_,_,_,_,_}} ->
			  {Fname, Flastmod}
		  end
	  end,
    lists:flatten(lists:map(Fun, Contens)).
