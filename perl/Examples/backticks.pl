#!/usr/local/bin/perl

$cmd = `/home/htdocs/cgi-bin/Sebra/whatday 200110; /bin/ls | mailx -s "prompt" qtxtman\@etxb.ericsson.se;\n-----------------------------119652344525003-- 01`;

print "$cmd\n";