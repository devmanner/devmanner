#!/usr/local/bin/perl

use mod_env;

#foreach $key (sort keys (%ENV)) {
#        SetEnv $ENV{$key} "kalle";
#        print "$key = $ENV{$key}\n";
#}

SetEnv $ENV{'HTTP_REFERER'} "kalle";

print "Location: http://avweb.etxb.ericsson.se/cgi-bin/Mustang/VeriCool/Test/viewEnv.pl\n\n";
