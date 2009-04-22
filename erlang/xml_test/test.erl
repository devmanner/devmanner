-module(test).
-compile(export_all).

-include("/usr/lib/erlang/lib/xmerl-1.0.5/include/xmerl.hrl").


-import(xmerl_xs, 
	[ xslapply/2, value_of/1, select/2, built_in_rules/2 ]).

doctype()->
    "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\
 \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd \">".

process_xml(Doc)->
	template(Doc).

template(E = #xmlElement{name='doc'})->
    [ "<\?xml version=\"1.0\" encoding=\"iso-8859-1\"\?>",
      doctype(),
      "<html xmlns=\"http://www.w3.org/1999/xhtml\" >"
      "<head>"
      "<title>", value_of(select("title",E)), "</title>"
      "</head>"
      "<body>",
      xslapply( fun template/1, E),
      "</body>"
      "</html>" ];


template(E = #xmlElement{ parents=[{'doc',_}|_], name='title'}) ->
    ["<h1>", 
     xslapply( fun template/1, E), 
     "</h1>"];

template(E = #xmlElement{ parents=[{'chapter',_}|_], name='title'}) ->
    ["<h2>", 
     xslapply( fun template/1, E),
     "</h2>"];

template(E = #xmlElement{ parents=[{'section',_}|_], name='title'}) ->
    ["<h3>", 
     xslapply( fun template/1, E),
     "</h3>"];

template(E = #xmlElement{ name='para'}) ->
    ["<p>", xslapply( fun template/1, E), "</p>"];

template(E = #xmlElement{ name='note'}) ->
    ["<p class=\"note\">"
     "<b>NOTE: </b>",
     xslapply( fun template/1, E),
     "</p>"];

template(E = #xmlElement{ name='emph'}) ->
    ["<em>", xslapply( fun template/1, E), "</em>"];

template(E)->
    built_in_rules( fun template/1, E).
