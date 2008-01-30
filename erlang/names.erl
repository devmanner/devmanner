-module(names).

-compile(export_all).

map() ->
	


%%map() ->
    %% Format:
    %% {UserDefinedName, [Hostnames, ...], [ErlNodes, ...], Cookie, [Subracks, ...], BSname
%%    [
%%     [
%%      {name, sis},
%%      {hostname, [sis1, sis2]},
%%      {erlNode, [sid@sis1, sid@sis2]},
%%      {cookie, bs_SIS_1}, 
%%      {slotSubrack, [{0,1},{0,13}]},
%%      {bsId, bs_SIS_1}
%%     ],
%%     [
%%      {name, mxb},
%%      {hostname, [mxb1, mxb2]},
%%      {erlNode, []}, 
%%      {cookie, null},
%%      {slotSubrack, [{0,1},{0,13}]},
%%      {bsId, bs_MXB_1}
%%      ]
%%    ].

%% Find what row Value is on if it is of type Key.
find_row([], _, _) ->
    {not_found, "Cannot find keyword in table"};
find_row([H|T], Key, Value) ->
    case lists:keysearch(Key, 1, H) of
	false -> find_row(T, Key, Value);
	{value, {Key, Elem}} ->
	    case search_elem(Elem, Value) of
		found -> H;
		not_found -> find_row(T, Key, Value)
	    end
    end.

%% Search for an element in the table.    
%% Element is a list
search_elem([], _) ->
    not_found;
search_elem([Key|_], Key) ->
    found;
search_elem(Key, Key) ->
    found;
search_elem([_|T], Key) ->
    search_elem(T, Key);
%% Element is a tuple
search_elem(Elem, Key) when tuple(Elem) ->
    search_elem(erlang:tuple_to_list(Elem), Key);
%% Elem is something else.
search_elem(_, _) ->
    not_found.

%% Get index of What in List. Returns not__found if not found or Lists is not a list.
index_of(List, What) ->
    index_of(List, What, 1).
index_of([], _, _) ->
    not_found;
index_of([What|_], What, X) ->
    X;
index_of([_|T], What, X) ->
    index_of(T, What, X+1);
index_of(_, _, _) ->
    not_found.

%% Translate What in form From to form To.
translate(From, To, What) ->
    case find_row(map(), From, What) of
	{not_found, Reason} -> {nok, Reason};
	Row ->
	    {value, {To, ResultElem}} = lists:keysearch(To, 1, Row),
	    {value, {From, SearchElem}} = lists:keysearch(From, 1, Row),
	    %% Test if What is a member of a list.
	    case erlang:is_list(SearchElem) and not erlang:is_list(What) and is_list(ResultElem) of
		true -> lists:nth(index_of(SearchElem, What), ResultElem);
		false -> ResultElem
	    end
    end.

	     
