#!/usr/local/bin/perl -w

use strict;

my $string = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Issue/fu_issue_21.db";

$string =~ s/\/.*\///g;
print "$string\n";