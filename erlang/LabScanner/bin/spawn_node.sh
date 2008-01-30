#!/bin/tcsh
# Autohor: Tomas Mannerstedt (qtomama)
# Description: Start an erlang node.

setenv BASE_DIR `dirname $0`"/../"

/swift/Erlang/otp/bin/erl -hidden -sname scanner -setcookie scanner -pa $BASE_DIR/ebin -kernel net_ticktime 8 -detached
