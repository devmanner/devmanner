#!/usr/local/bin/perl

$host = $ARGV[0];
$host =~ tr/+/ /;
$host =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

$host =~ s/~!/ ~!/g;

print "Content-type: text/html\n\n";
print "rsh $host -l ";


