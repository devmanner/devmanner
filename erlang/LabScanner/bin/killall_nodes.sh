#!/bin/tcsh
# Autohor: Tomas Mannerstedt (qtomama)
# Description: Kill all erlang nodes.

setenv BASE_DIR `dirname $0`"/../"
/swift/Erlang/otp/bin/erl -sname foo -noshell -pa $BASE_DIR/ebin -s scan kill_all_nodes -s erlang halt
