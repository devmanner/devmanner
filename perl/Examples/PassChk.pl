#!/usr/local/bin/perl
#########################################################################
# Define vareables.							#

$passwordfile = "/home/qtxtman/perl/.passfile";

# Done									#
#########################################################################
# Get input.								#

read (STDIN, $buffer, $ENV{CONTENT_LENGTH});
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
	$pair =~ s/%([0-9A-F]{2})/chr(hex($1))/egi;
}

($trash, $uid) = split(/=/, @pairs[0]);
($trash, $passwd) = split(/=/, @pairs[1]);


print "Content-type: text/html\n\n";
print "$uid\n";
print "$passwd\n";


exit 0;



open (PASSWORDFILE, $passwordfile);
@passwordfile = <PASSWORDFILE>;
close PASSWORDFILE;

