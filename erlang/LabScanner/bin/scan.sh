#!/bin/tcsh
# Autohor: Tomas Mannerstedt (qtomama)
# Description: Scan the swift lab.

setenv BASE_DIR `dirname $0`"/../"
/swift/Erlang/otp/bin/erl -sname foo -noshell -pa $BASE_DIR/ebin -s scan scan -s erlang halt
