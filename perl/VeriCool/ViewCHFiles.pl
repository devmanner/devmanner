#!/usr/local/bin/perl
#########################################################################
# Script name: ViewCHFiles.pl ver 1.01					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# Comments: This script prints out the contents of the file containing	#
# the paths to the changed files for the release. It also puts up a	#
# link to the comment for that particular change. The comment is taken	#
# from the comments file.						#
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

$rel_n_block = @ARGV[0];
chomp($rel_n_block);

# Done									#
#########################################################################
# Security. No .. in argument.   					#

if ($rel_n_block =~ m/(\.\.)+/i ) {
        print "Content-type: text/html\n\n";
        print "Don't even try...";
        exit;
}

# Done									#
#########################################################################
# Get the file contents.						#

open (CHFILE, "$basedir/$rel_n_block$ch_file") || die "Can't find $basedir/$rel_n_block$ch_file I'm buggin' out!";
@chfile = <CHFILE>;
close CHFILE;

# Done									#
#########################################################################
# Get the file for the menubar.						#

open (MENUBARFILE, "$menubarfile") || die "Cant find $menubarfile";
@menubarfile = <MENUBARFILE>;
close MENUBARFILE;

# Done									#
#########################################################################
# Print out the file.							#

print "Content-type: text/html\n\n";

print "<HTML>\n";

print "<HEAD>\n";
print "<TITLE>The VeriCool Website</TITLE>\n";
print "\n";

foreach $row (@menubarfile) {
	print "$row";
}

print "\n";
print "</HEAD>\n";

print "<BODY BGCOLOR=\"#000000\" TEXT=\"#FFFFFF\" LINK=\"#33FF00\" VLINK=\"#CCFF00\" ALINK=\"#FF0000\" onload=\"init()\">\n";
print "<FONT SIZE=\"3\" FACE=\"Footlight MT Light\">\n";
print "<BR><BR>\n";
foreach $row (@chfile) {
	chomp ($row);
	print "<A HREF=\"$cgi_url/PrintFile.pl?$basedir/$rel_n_block$comments_file+$row+EndOfComment\">$row</A>\n\n";
}

print "</BODY>\n";
print "</HTML>\n";

# Done									#
#########################################################################
