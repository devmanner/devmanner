#!/usr/local/bin/perl
#########################################################################
# Script name: ViewBlockInfo.pl ver 1.0					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# Comments: This script is executed when a release is clicked. It	#
# prints out information about the blocks in the release. The		#
# information is found in the $release_conf_file. Input to the script	#
# is the release dir name.						#
#########################################################################
# Define vareables							#

# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
$varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Get input								#

$input = @ARGV[0];
chomp($input);

# Done									#
#########################################################################
# Security. No .. in argument.   					#

if ($input =~ m/(\.\.)+/i ) {
        print "Content-type: text/html\n\n";
        print "Don't even try...";
        exit;
}

# Done									#
#########################################################################
# Get release time and date and modify format.				#

($release, $date, $time) = split(/\./, $input);
$date =~ s/_/-/g;
$time =~ s/_/:/g;
$time =~ s/\///g;

# Done									#
#########################################################################
# Get the file for the menubar.						#

open (MENUBARFILE, "$menubarfile") || die "Cant find $menubarfile";
@menubarfile = <MENUBARFILE>;
close MENUBARFILE;

# Done									#
#########################################################################
# Get contents of the $release_conf_file file.				#

open (CONFFILE, "<$basedir/$input/web/$release_conf_file") || die "Cannot open $basedir/$input/web/$release_conf_file I'm buggin out!?!!?";
	@conffile = <CONFFILE>;
close CONFFILE;

# Done									#
#########################################################################
# Return HTML.								#

print "Content-type: text/html\n\n";
print "<HTML>\n";
print "<HEAD>\n";
print "\n";

foreach $row (@menubarfile) {
	print "$row";
}

print "\n";
print "</HEAD>\n\n";
print "<BODY BGCOLOR=\"#000000\" TEXT=\"#000000\" onload=\"init()\">\n\n";
print "<BR><BR>\n";
print "<TABLE WIDTH=\"80%\" BORDER=0>\n";
print "<TR>\n";
print "<TD WIDTH=\"20%\">\n";
print "<FONT SIZE=\"4\" FACE=\"Footlight MT Light\" COLOR=\"#FFFFFF\">\n";
print "<B>Release:</B>\n";
print "</TD>\n";

print "<TD WIDTH=\"30%\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\" COLOR=\"#FFFFFF\">\n";
print "$release\n";
print "</TD>\n";

print "<TD WIDTH=\"20%\">\n";
print "<FONT SIZE=\"4\" FACE=\"Footlight MT Light\" COLOR=\"#FFFFFF\">\n";
print "<B>Released on:</B>\n";
print "</TD>\n";

print "<TD WIDTH=\"30%\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\" COLOR=\"#FFFFFF\">\n";
print "$date $time\n";
print "</TD>\n";
print "</TR>\n";
print "</TABLE>\n";

print "<TABLE WIDTH=\"80%\" BORDER=0>\n";

print "<TR>\n";
print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"10%\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
print "<B>Block</B>\n";
print "</TD>\n";

print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"60%\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
print "<B>Label</B>\n";
print "</TD>\n";

print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"15%\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
print "<B>Date</B>\n";
print "</TD>\n";

print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"15%\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
print "<B>Time</B>\n";
print "</TD>\n";
print "</TR>\n";

foreach $row (@conffile) {
	@row = split(/;/, $row);
	print "<TR>\n";

	print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"10%\">\n";
	print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
	print "<B>@row[0]</B>\n";
	print "</TD>\n";

	print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"60%\">\n";
	print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
	print "@row[1]\n";
	print "</TD>\n";

	print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"15%\">\n";
	print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
	print "@row[2]\n";
	print "</TD>\n";

	print "<TD BGCOLOR=\"#FFFFFF\" WIDTH=\"15%\">\n";
	print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
	print "@row[3]\n";
	print "</TD>\n";

	print "</TR>\n";
}

print "</TABLE>\n";
print "</BODY>\n";
print "</HTML>\n";

