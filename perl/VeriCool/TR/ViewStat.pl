#!/usr/local/bin/perl
#########################################################################
# Script name: ViewStat.pl 1.1.3					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 00-07-18					#
# Comments: This script checks the status of each issue by looking in	#
# the last row of it's database. The total result of the statuses is	#
# displayed in a chart.							#
#########################################################################
# Strict mode.          						#

use strict;
use vc_tr;

# Done									#
#########################################################################
# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";
use vars qw($menubarfile $issue_dir $arch_dir $stat_title $chartfile $charturl %STAT_COLOR %CHART_STAT_LABEL @stat_avail $chart_title);

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Declarations and init setup.						#

my (@issue_files) = getFiles("$issue_dir/issue_*.db");
my (@arch_files) = getFiles("$arch_dir/issue_*.db");
my $num_arch = $#arch_files + 1;
my $file;
my $num_issue = 0;
my $num_followup = 0;
my %FILECONT;

# Done									#
#########################################################################
# Main                                                                  #

my $key;
foreach $file (@issue_files) {
        (%FILECONT) = split2Hash("###", getFileCont("$file"));
        ($num_issue, $num_followup) = ($FILECONT{'next'}) ? ($num_issue, $num_followup + 1) : ($num_issue + 1, $num_followup);
}

returnHTML($num_issue, $num_followup, $num_arch);

exit 0;

# Done									#
#########################################################################
# Return HTML								#

sub returnHTML {
        my %STAT;
        ($STAT{'Issue'}, $STAT{'Follow up'}, $STAT{'Finish'}) = @_;
        my ($status, $row);
        my ($sum_tr) = 0;
        my $c_num = 1;

        printStdHeader();

        print "<CENTER>\n\n<H1 STYLE=\"color: white\">$stat_title</H1><BR>\n";

        $chartfile = "PieChart.class";
        $charturl  = "http://avweb.etxb.ericsson.se/~qtxtman/Piechart/";

        print "<applet code=\"$chartfile\" codebase=\"$charturl\" bgcolor=\"#FFFFFF\" width=400 height=300>\n";
        print "<param name=\"title\" value=\"$chart_title\">\n";
        print "<param name=\"showlabel\" value=\"yes\">\n";
        print "<param name=\"showpercent\" value=\"yes\">\n";
        print "<param name=\"bgcolor\" value=\"white\">\n";
        print "<param name=\"columns\" value=\"3\">\n";
        foreach $status (@stat_avail) {
	        print "\t<param name=Pcolor$c_num value=\"$STAT_COLOR{$status}\">\n";                                      # The color
	        print "\t<param name=Plabel$c_num value=\"&nbsp\;&nbsp\;$CHART_STAT_LABEL{$status} ($STAT{$status})\">\n"; # The label
	        print "\t<param name=Pvalue$c_num value=\"$STAT{$status}\">\n\n";                                          # The value
	        $c_num ++;
                $sum_tr += $STAT{$status};
        }
        print "</APPLET>\n";
        print "<BR><BR><FONT STYLE=\"color: white;\">Total number of reported TR's is: $sum_tr</FONT>";

# For the staple applet...
#        print "<applet code=\"$chartfile\" codebase=\"$charturl\" bgcolor=\"#FFFFFF\" width=300 height=200>\n";
#        print "<param name=title value=\"$stat_title\">\n";
#        print "<param name=columns value=\"3\">\n";
#        print "<param name=orientation value=\"vertical\">\n\n";
#        foreach $status (@stat_avail) {
#	        print "\t<param name=c$c_num\_style value=\"solid\">\n";
#	        print "\t<param name=c$c_num\_color value=\"$STAT_COLOR{$status}\">\n";
#	        print "\t<param name=c$c_num\_label value=\"$status\">\n";
#	        print "\t<param name=c$c_num value=\"$STAT{$status}\">\n\n";
#	        $c_num ++;
#        }
#        print "</APPLET>\n";
        printStdFooter();
}

# Done									#
#########################################################################
