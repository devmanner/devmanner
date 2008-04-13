#!/usr/local/bin/perl
#########################################################################
# Script name: PrintFile.pl                                             #
# Version: 2.01 (Special VeriCool edition)				#
# Written by: Tomas Mannerstedt DN/X/XGA                                #
# Reach me at: qtxtman@etxb.ericsson.se                                 #
# Description: This script prints contents of the file in @ARGV[0] 	#
# starting from @ARGV[1] ending at @ARGV[2]. If @ARGV[2] = "" then the	#
# printing of file ends at EOF. If @ARGV[1] = "" the printing starts at	#
# the beginning of the file.						#
#########################################################################
# Define vareables.						 	#

# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
$varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Initial setup.							#
use File::Basename;

$secure = 0;
$secure2 = 0;

$logfile = @ARGV[0];
$start = @ARGV[1];
$stop = @ARGV[2];
if ($start eq "") {
	$start = "StartAtBOF";
}
if ($stop eq "") {
	$stop = "StopAtEOF";
}

# Done									#
#########################################################################
# Security test								#
# Check if $dbdir contains illegal characters. It may only contain a-z,	#
# A-Z, 0-9, . (dot) and :.						#

$tmpdbdir = $logfile;
$tmpdbdir =~ /([0-9a-zA-Z_\-\/.:]*)/;
$tmpdbdir = $1;

if ($tmpdbdir eq $logfile) {
	$secure2 = 1;
}
else {
	print "Content-type: text/html\n\n";
	print "Don't you try to hack this script...\n";
	exit 0;
}

# Done									#
#########################################################################
# Check that the script is looking in a subfilder of $alloweddir.	#

$logdir = dirname($logfile);
if ($logdir !~ m/^$alloweddir.*/i || $logdir =~ m/(\.\.)+/ ) {
    print "Content-type: text/html\n\n";
    print "Don't you try to hack this script. Consider changing the \$alloweddir if this is a false alarm.\n"; exit 0;
}

#@logdir = split(/\//, $logfile);
#pop(@logdir);
#shift(@logdir);
#$logdir = join('/', @logdir);
#$logdir = '/'.$logdir;

#chdir($logdir);

#do {
#	$pwd = `pwd`;
#	@pwd = split(/\n/, $pwd);
#	$pwd = @pwd[0];

#	if ($pwd eq $alloweddir) {
#		$secure = 1;
#	}

#	chdir('..');

#} until ($secure == 1 || $pwd eq "/");

#if ($secure != 1) {
#	print "Content-type: text/html\n\n";
#	print "Don't you try to hack this script...\n";
#	exit 0;
#}

# Done									#
#########################################################################
# Get the logfile.							#

$file = `/bin/cat $logfile`;
@file = split(/\n/, $file);
$printflag = 0;

# Done									#
#########################################################################
# Get the file for the menubar.						#

open (MENUBARFILE, "$menubarfile") || die "Cant find $menubarfile";
@menubarfile = <MENUBARFILE>;
close MENUBARFILE;

# Done									#
#########################################################################
# Start generating HTML 						#

print "Content-type: text/html\n\n";
print "<HTML>\n";
print "<HEAD>\n";
print "<TITLE>$logfile</TITLE>\n";
print "<META NAME=\"Author\" CONTENT=\"Tomas Mannerstedt\">\n";
print "<META NAME=\"GENERATOR\" CONTENT=\"Textedit\">\n";
print "\n";

foreach $row (@menubarfile) {
	print "$row";
}

print "\n";
print "</HEAD>\n";
print "<BODY TEXT=#FFFFFF BGCOLOR=#000000 LINK=#0000EE VLINK=#551A8B ALINK=#FF0000 onload=\"init()\">\n";
print "<BR><BR>\n\n";
print "<TT>\n";

# Done									#
#########################################################################
# Look for $start and start printing out the file from there to $stop.	#

foreach $row (@file) {
	if ($row eq $start || $start eq "StartAtBOF") {
		$printflag = 1;
	}

	if ($stop ne "StopAtEOF") {
		if ($row eq $stop) {
			$printflag = 0;
		}
	}

	if ($printflag == 1) {
		$row =~ s/</&lt;/g;
		$row =~ s/>/&gt;/g;
		print "$row<BR>\n";
	}
}
print "</TT>\n";
print "</BODY></HTML>\n";

# Done									#
#########################################################################
