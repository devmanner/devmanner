#!/usr/local/bin/perl

$i = @ARGV[0];
$var = @ARGV[1];
$var =~ tr/_/ /;

print "Content-type: text/html\n\n";
print "<HTML><BODY>\n\n";
print @ARGV;
print "[$i] - [$var]\n";
print "</BODY></HTML>\n\n";


