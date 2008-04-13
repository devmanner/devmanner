#!/usr/local/bin/perl

print "Content-type: text/html\n\n";
print "<tt>\n";
foreach $key (sort keys(%ENV)) {
        print "$key = $ENV{$key}<p>";
}
print "REMOTE_USER = $ENV{'REMOTE_USER'}<p>\n";