#!/usr/local/bin/perl -w
#########################################################################
# Script name: ViewTR.pl 2.1    					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-06-01					#
# Comments: This script prints out a single TR with it's TR tree        #
# without a link to itself. It contains "secute" backticks. Do not      #
# (without knowing what you are doing) change the security checking.    #
#                                                                       #
# Call: ViewTR.pl?TREEBASE+DIRECTORY+REPORT                             #
#       TREEBASE: The first file in the TR thread.                      #
#       DIRECTORY: Issue or Archive                                     #
#       REPORT: The filename of the report that shall be viewed.        #
#########################################################################
# Set strict mode.							#

use strict;
use vc_tr;
use vars qw($menubarfile $issue_dir $arch_dir $email_domain $baseurl $tr_cgi_url $fixed_font $treeviewscript);

# Done									#
#########################################################################
# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#

my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Get the variables.    						#

do $varfile;

# Done									#
#########################################################################
# Main program.             						#

my ($treebase, $act_dir, $report) = @ARGV;
my ($dir);

$act_dir = ($act_dir eq "Archive") ? $arch_dir : $issue_dir;

# Security check.
if (!($treebase =~ m/^issue_[0-9]{1,14}\.db$/ && ( $report =~ m/^issue_[0-9]{1,14}\.db$/ || $report =~ m/^fu_issue_[0-9]{1,14}\.db$/ ))) {
        expError("Illegal call!!!\n\n");
}

$dir = $act_dir;
$dir =~ s/\/.*\///g;
printStdHeader();
printReport($dir, "$act_dir/$report");

print "<FONT COLOR=\"#FFFFFF\"><H1>TR thread</H1></FONT>";
print "\n\n\n<!-- Output from ViewTRTree.pl -->\n\n\n";
# $dir is secure while it is set to the last word in path of either     #
# $issue_dir or $arch_dir.                                              #
print `$treeviewscript $dir $report $treebase`;
print "\n\n\n<!-- End of output from ViewTRTree.pl -->\n\n\n";

printStdFooter();
exit 0;

# Done									#
#########################################################################
# Prints the report                 					#

sub printReport {
        my ($dir, $reportfile) = @_;
        my (@file, $name, $value, $pair, $reportfile_nopath);
        my (%FILECONT);
        my (%COOKIE) = getCookie();

        open (FILE, "<$reportfile") || expError("Cannot find reportfile: $reportfile\n\n");
        @file = <FILE>;
        close FILE;

        foreach $pair (@file) {
                ($name, $value) = split(/\#\#\#/, $pair);
                $FILECONT{$name} = $value;
        }

        print "<FONT COLOR=\"#FFFFFF\"><H1>$FILECONT{'header'}</H1></FONT>\n\n";
        print "<TABLE WIDTH=\"100%\" bgcolor=\"#ffffff\" BORDER=0>\n\n<TR>\n<TD COLSPAN=2>\n";

        print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n\n";
        print "<TR>\n<TD WIDTH=100><B>Author:</B></TD>\n<TD><FONT FACE=\"$fixed_font\"><A HREF=\"mailto:$FILECONT{'reporter'}$email_domain\">$FILECONT{'reporter'}</A></FONT></TD>\n</TR>\n\n";
        print "<TR>\n<TD><B>Block:</B></TD>\n<TD><FONT FACE=\"$fixed_font\">$FILECONT{'block'}</FONT></TD>\n</TR>\n\n";
        print "<TR>\n<TD><B>Release:</B></TD>\n<TD><FONT FACE=\"$fixed_font\">$FILECONT{'release'}</FONT></TD>\n</TR>\n\n";
        print "<TR>\n<TD><B>Priority:</B></TD>\n<TD><FONT FACE=\"$fixed_font\">$FILECONT{'prio'}</FONT></TD>\n</TR>\n\n";
        print "<TR>\n<TD><B>Status:</B></TD>\n<TD><FONT FACE=\"$fixed_font\">$FILECONT{'status'}</FONT></TD>\n</TR>\n\n";
        print "<TR>\n<TD><B>Date:</B></TD>\n<TD><FONT FACE=\"$fixed_font\">$FILECONT{'date'}</FONT></TD>\n</TR>\n\n";
        print "</TABLE>\n\n";

        print "</TD>\n</TR>\n\n";

        print "<TR>\n<TD COLSPAN=2>\n\n";
        print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n\n";
        print "<TR>\n<TD WIDTH=100 VALIGN=top><B>Description:</B></TD>\n";
        print "<TD><FONT FACE=\"$fixed_font\">$FILECONT{'description'}</TD>\n</TR>\n</TABLE>";
        print "</TD></TR>\n";

        $reportfile_nopath = $reportfile;
        $reportfile_nopath =~ s/\/.*\///g;
        print "<TR>\n<TD COLSPAN=2>\n\n";
        print "<TABLE WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=0 BORDER=0>\n\n";

        if ($dir eq "Issue") {
                print "<TR>\n<TD><CENTER><A HREF=\"$tr_cgi_url/ReportForm.pl?$reportfile_nopath\">Post a follow up!</A></CENTER></TD>\n</TR>\n";
        }
        print "</TABLE>\n\n</TABLE>\n\n";
        print "\n<BR>";
}

# Done									#
#########################################################################
# Get the creator of the treebase.    					#

sub getCreator {
        my ($file) = @_;
        my ($line);
        if (!($file =~ m/fu_issue_[0-9]{1,14}\.db$/)) {
                open (FILE, $file) || expError("Cannot open $file\n\n");
                while (defined($line = <FILE>)) {
                        if ($line =~ "reporter###") {
                                $line =~ s/reporter###//gi;
                                close FILE;
                                chomp($line);
                                return ($line);
                        }
                }
                close FILE;
        } else {
                open (FILE, $file) || expError("Cannot open $file\n\n");
                while (defined($line = <FILE>)) {
                        if ($line =~ "prev###") {
                                $line =~ s/prev###//gi;
                                close FILE;
                                return (getCreator($line));
                        }
                }
        }
        return ("");
}

# Done									#
#########################################################################