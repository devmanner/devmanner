%%% % CCaseFile: netconf.erl %
%%%-------------------------------------------------------------------
%%% © Ericsson AB 2006 All rights reserved.  The
%%% information in this document is the property of Ericsson.  Except
%%% as specifically authorized in writing by Ericsson, the receiver of
%%% this document shall keep the information contained herein
%%% confidential and shall protect the same in whole or in part from
%%% disclosure and dissemination to third parties.  Disclosure and
%%% disseminations to the receivers employees shall only be made on a
%%% strict need to know basis.
%%%
%%% File        : netconf.erl
%%% Author      : Per Bergström <per.bergstrom@ericsson.com>
%%% Description : This module contains functions for the netconf interface.
%%%
%%% History     :
%%% 18 Oct 2006   - temporary (?) workaround for key authentication problem
%%%                 use a temporary '.ssh'-directory without any keys
%%% 10 Oct 2006   - using otp ssh client, no need for external
%%%               - support for taking input messages from file(s) 
%%% 28 Sep 2006   - first checkin, need external ssh client (netconf.py)
%%%               
%%%-------------------------------------------------------------------
-module(netconf).

-export([
    help/0,
    send_msg/1, send_msg/5, send_msg/6
    ]).

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% macro's
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-define(hello,      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                    "<hello xmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">"
                    "<capabilities>"
                    "<capability>urn:ietf:params:netconf:base:1.0</capability>"
                    "</capabilities>"
                    "</hello>").
-define(goodbye,    "<rpc message-id=\"42\" xmlns=\"urn:ietf:params:xml:ns:netconf:base:1.0\">"
                    "<close-session/>"
                    "</rpc>").
-define(endmark,    "]]>]]>").

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% exports
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% help/0

help() ->
    io:format(  "This module contains functions for the netconf interface.~n~n"
                "   send_msg(help) ->~n"
                "       This call will display help info~n"
                "   send_msg(Host, Portno, User, Passwd, Msg, Timeout) ->~n"
                "       {ok, Rsp} or {error, Reason}~n~n"
                "       This function will transmit one or more netconf messages~n"
                "       to the specified host.~n"
                "       It returns the xml answer from the host~n"
                , []).


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% send_msg/1

send_msg(help) ->
    io:format(  "send_msg(Host, Portno, User, Passwd, Msg)  or~n"
                "send_msg(Host, Portno, User, Passwd, Msg, Timeout) ->~n"
                "   {ok, Rsp} or {timeout, Rsp}~n~n"
                "       This function will transmit one or more netconf messages~n"
                "       to the specified host. All messages in 'Msg' are sent in ~n"
                "       the same netconf session.~n"
                "       There is no error check besides timeout. This means that possible~n"
                "       error information in 'Rsp' needs to be extracted by the caller.~n"
                "       It returns the response from the host as a string. In case there~n"
                "       are several rpc messages in 'Msg', each response is placed at~n"
                "       the corresponding position in the returned list of strings.~n~n"
                "       send_msg/5 will use the default timeout == 5000.~n~n"
                "       Types:~n"
                "           Host = string()~n"
                "               the name or IP address of the host.~n"
                "           Portno = integer()~n"
                "               the portnumber to use.~n"
                "           User = string()~n"
                "               the name of the user login name.~n"
                "           Passwd = string()~n"
                "               the password to use.~n"
                "           Msg = string() or [string()] or~n"
                "                 {file, string()} or {file, [string()]} or~n"
                "                 [string(), {file, string()}] or [string(), {file, [string()]}]~n"
                "               the data to send, each string must be a complete~n"
                "               rpc message in xml format.~n"
                "               {file, string()} or {file, [string()]} means that the data~n"
                "               is read from the filename specified by string() or filenames~n"
                "               specified in [string()].~n"
                "           Timeout = integer()~n"
                "               the maximum time (in milliseconds) to wait for an answer.~n"
                "           Rsp = {ok, string() or [string()]}   or~n"
                "                 {timeout, string() or [string()]}~n"
                "               the response from the host, in case of {timeout, Rsp}~n"
                "               'Rsp' will contain the response (if any) received before~n"
                "               timeout occurred.~n"
                , []).

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% send_msg/5

send_msg(Host, Portno, User, Passwd, Msg) ->
    ncsession(Host, Portno, User, Passwd, Msg, 5000).


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% send_msg/6

send_msg(Host, Portno, User, Passwd, Msg, Timeout) ->
    ncsession(Host, Portno, User, Passwd, Msg, Timeout).


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% private
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ncsession/6

ncsession(Host, Portno, User, Passwd, Msg, Timeout) ->
    Tmpdir = "/tmp/" ++ hd(io_lib:format("~p", [make_ref()])),
    ok = file:make_dir(Tmpdir),
    Opts = [
        {user, User},
        {password, Passwd},
        {connect_timeout, 10000},
        {silently_accept_hosts, true},
        {user_dir, Tmpdir}
        ],
    crypto:start(),
    {ok, Ssh} = ssh_cm:connect(Host, Portno, Opts),
    [file:delete(F) || F <- filelib:wildcard(Tmpdir ++ "/*")],
    ok = file:del_dir(Tmpdir),
    {value, {_, Ctmo}} = lists:keysearch(connect_timeout, 1, Opts),
    {ok, Chn} = ssh_cm:session_open(Ssh, Ctmo),
    success = ssh_cm:subsystem(Ssh, Chn, "netconf", Ctmo),
    send_request(Ssh, Chn, [?hello], 2000, 1),
    {Result, Reply} = send_request(Ssh, Chn, mkmsg(Msg), Timeout, 2),
    send_request(Ssh, Chn, [?goodbye], 2000, 2+length(Reply)),
    ssh_cm:close(Ssh, Chn),
    ssh_cm:stop(Ssh),
    crypto:stop(),
    {Result, Reply}.


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% send_request/5

send_request(Ssh, Chn, Msg, Timeout, Msgid) ->
    send_request(Ssh, Chn, Msg, Timeout, Msgid, []).


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% send_request/6

send_request(Ssh, Chn, [First | Rest], Timeout, Msgid, Opts) ->
    send_request(Ssh, Chn, First, Rest, Timeout, Msgid, Opts, []).


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% send_request/7

send_request(Ssh, Chn, Msg, [], Timeout, Msgid, _Opts, Rsp) ->
    {ok, SMsg, _} = regexp:sub(Msg ++ ?endmark, "message-id=\"[0-9]+",
                                "message-id=\"" ++ integer_to_list(Msgid)),
    ssh_cm:send(Ssh, Chn, SMsg),
    {Result, Ret} = get_reply(Ssh, Chn, ?endmark, Timeout),
    {Result, Rsp ++ Ret};
send_request(Ssh, Chn, Msg, Rest, Timeout, Msgid, Opts, Rsp) ->
    {ok, SMsg, _} = regexp:sub(Msg ++ ?endmark, "message-id=\"[0-9]+",
                                "message-id=\"" ++ integer_to_list(Msgid)),
    ssh_cm:send(Ssh, Chn, SMsg),
    case get_reply(Ssh, Chn, ?endmark, Timeout) of
        {ok, Ret} ->
            [M|R] = Rest,
            send_request(Ssh, Chn, M, R, Timeout, Msgid+1, Opts, Rsp ++ Ret);
        {timeout, Ret} ->
            {timeout, Rsp ++ Ret}
    end.


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% get_reply/4

get_reply(Ssh, Chn, Delim, Timeout) ->
    get_reply(Ssh, Chn, Delim, Timeout, 1, [], []).
    

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% get_reply/7

get_reply(_Ssh, _Chn, _Delim, _Timeout, 0, _, Rsp) ->
    {ok, Rsp};
get_reply(Ssh, Chn, Delim, Timeout, Numof, Rbuf, Rsp) ->
    receive
        {ssh_cm, Ssh, {data, Chn, _, Data}} ->
            ssh_cm:adjust_window(Ssh, Chn, size(Data)),
            Sdata = Rbuf ++ binary_to_list(Data),
            case string:str(Sdata, Delim) of
                0 ->
                    get_reply(Ssh, Chn, Delim, Timeout, Numof, Sdata, Rsp);
                End ->
                    get_reply(Ssh, Chn, Delim, Timeout, Numof-1,
                                string:substr(Sdata, End+string:len(Delim)),
                                Rsp ++ [string:substr(Sdata, 1, End-1)])
            end;
        Other ->
            io:format("get_reply(), got: ~p~n", [Other]),
            get_reply(Ssh, Chn, Delim, Timeout, Numof, Rbuf, Rsp)
        after Timeout ->
            {timeout, Rsp}
    end.

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% mkmsg/1

mkmsg(Msg) ->
    mkmsg(Msg, []).

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% mkmsg/2

mkmsg({file, [Filename | Rest]}, Msg) when not is_list(Filename) ->
    {ok, Bin} = file:read_file([Filename] ++ Rest),
    Msg ++ [binary_to_list(Bin)];
mkmsg({file, [Filename | []]}, Msg) ->
    {ok, Bin} = file:read_file(Filename),
    Msg ++ [binary_to_list(Bin)];
mkmsg({file, [Filename | Rest]}, Msg) ->
    {ok, Bin} = file:read_file(Filename),
    mkmsg({file, Rest}, Msg ++ [binary_to_list(Bin)]);
mkmsg([{file, Filename} | []], Msg) ->
    mkmsg({file, Filename}, Msg);
mkmsg([{file, Filename} | Rest], Msg) ->
    mkmsg(Rest, mkmsg({file, Filename}, Msg));
mkmsg([Xmlmsg | Rest], Msg) when not is_list(Xmlmsg) ->
    Msg ++ [[Xmlmsg] ++ Rest];
mkmsg([Xmlmsg | []], Msg) ->
    Msg ++ [Xmlmsg];
mkmsg([Xmlmsg | Rest], Msg) ->
    mkmsg(Rest, Msg ++ [Xmlmsg]).


