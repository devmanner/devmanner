-module(distfs).

-compile(export_all).

start(Dir) ->
    register(?MODULE, spawn(fun() -> dist_loop([], Dir), io:format("Dead!~n") end)).
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
		{files, FileList} ->
		    io:format("Got some files: ~p~n", [FileList]),
		    %% Write the files to dir here.
		    dist_loop(PidList, FileList)
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
	    Pid ! {files, FileList},
	    dist_loop(PidList, FileList);
	X ->
	    io:format("Undefined message: ~p~n", [X]),
	    dist_loop(PidList, FileList)
    end.

store_file(FileName, FileContens) ->
    {ok, FD} = file:open(FileName, [write]),
    ok = file:write(FD, FileContens),
    ok = file:close(FD).

send_file(File, Pid) ->
    {ok, FileCont} = file:read(File),
    Pid ! FileCont.
