#!/usr/bin/perl

open(COUNTER, "+<counter.dat") || die "Content-type: text/html\n\nopen?";
$cnt = <COUNTER>;
chomp($cnt);
print "$cnt från fil\n";
$cnt++;
printf COUNTER "$cnt";
close (COUNTER);
print "Content-type: text/html\n\n$cnt";
