#!/usr/local/bin/perl -w

use strict;

my $string = "next###/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Issue/fu_issue_21.db###/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Issue/fu_issue_23.db";

print "$string\n\n";

#$string =~ s/(###){1}?(.*)$//g;

my @trash = split(/###/, $string);
pop (@trash);
$string = join("###" , @trash);

print "$string\n\n";
