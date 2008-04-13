#!/usr/local/bin/perl
#########################################################################
# Script name: TRSearch.pl 1.1.1  					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 00-07-12					#
# Updated for TR2: 01-06-13                                             #
# Comments: This script generates a html form for advanced search in	#
# the TR databases. It allows you to view TR's matching your criteria	#
# specifyed in the form. 						#
#########################################################################
# Set strict mode.							#

use strict;
use vc_tr;
use vars qw($menubarfile $release_dir $vc_ini $tr_cgi_url);

# Done									#
#########################################################################
# Define vareables							#

# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";


# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Main          							#

my (@releases) = getReleases($release_dir);
my (@vc_ini) = getFileCont($vc_ini);
my (@blocks) = getBlocks(@vc_ini);
my (@menubarfile) = getFileCont($menubarfile);
returnForm();
exit 0;

# Done									#
#########################################################################
# Return HTML.								#

sub returnForm {
        my ($row, $release, $block);
        my ($block1, $block2);
        printStdHeader();
        
        print "<FONT SIZE=\"3\" FACE\"Footlight MT Light\">\n";
        print "<H1 STYLE=\"color: #FFFFFF\">TR Search</H1>\n";

        print "<CENTER><TABLE WIDTH =\"90%\" BGCOLOR=\"#FFFFFF\" BORDER=0><TR><TD>\n\n";

        print "<BR><TABLE WIDTH=\"100%\">\n";
        print "<TR><TD>\n";
        print "<P align=\"adjust\">\n";
        print "&nbsp\;&nbsp\;&nbsp\;&nbsp\;\n";
        print "This page allows you to sort reported TR's in the way you whant to view 'em. Select sort options in the form below. The script only matches the last post in thread. If AND is used remember to only select one searchterm in each category. A TR can't, for example, have more than one status.\n";
        print "</P>\n";
        print "</TD></TR>\n";
        print "</TABLE>\n";

        print "<TABLE WIDTH=\"100%\" BORDER=0>\n";
        print "<FORM METHOD=\"POST\" ACTION=\"$tr_cgi_url/ViewTRTree.pl\">\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "Select directory to search in:\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=RADIO CHECKED NAME=\"dir\" VALUE=\"Issue\">Issue\n<BR>\n";
        print "<INPUT TYPE=RADIO NAME=\"dir\" VALUE=\"Archive\">Archive\n<BR>\n";
        print "</TD></TR>\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "Boolean operator:\n";
        print "</TD><TD>\n";
        print "<INPUT CHECKED TYPE=RADIO NAME=\"boolean\" VALUE=\"And\">AND\n";
        print "<BR>\n";
        print "<INPUT TYPE=RADIO NAME=\"boolean\" VALUE=\"Or\">OR\n";
        print "</TD></TR>\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "Enter search string:\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=TEXT NAME=\"description\" SIZE=40>\n<BR>\n";
        print "</TD></TR>\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "Enter who reported the problem. (UNIX id):\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=TEXT NAME=\"reporter\" SIZE=8 MAXLENGTH=8>\n<BR>\n";
        print "</TD></TR>\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "Select prio:\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=CHECKBOX NAME=\"prio\" VALUE=\"Low\">Low\n<BR>\n";
        print "<INPUT TYPE=CHECKBOX NAME=\"prio\" VALUE=\"Normal\">Normal\n<BR>\n";
        print "<INPUT TYPE=CHECKBOX NAME=\"prio\" VALUE=\"Critical\">Critical\n<BR>\n";
        print "</TD></TR>\n";

        print "<!--<TR><TD VALIGN=\"top\">\n";
        print "Select Status:\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=CHECKBOX NAME=\"status\" VALUE=\"Issue\">Issue\n<BR>\n";
        print "<INPUT TYPE=CHECKBOX NAME=\"status\" VALUE=\"Follow up\">Follow up\n<BR>\n";
        print "<INPUT TYPE=CHECKBOX NAME=\"status\" VALUE=\"Finish\">Finish\n<BR>\n";
        print "</TD></TR>-->\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "View TR's on the following Releases:\n";
        print "</TD><TD>\n";
        foreach $release (@releases)
                {print "<INPUT TYPE=CHECKBOX NAME=\"release\" VALUE=\"$release\">$release\n<BR>\n";}
        print "</TD></TR>\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "View TR's on the following Blocks:\n";
        print "</TD><TD>\n";
        print "<TABLE BORDER=0 WIDTH=\"100%\"><TR><TD>\n";
        do {
                print "<TR>\n";
                $block = shift(@blocks);
                if ($block) {
                        print "<TD WIDTH=\"50%\"><INPUT TYPE=CHECKBOX NAME=\"block\" VALUE=\"$block\">$block\n<BR>\n</TD>";
                } else {
                        print "<TD WIDTH=\"50%\">&nbsp\;</TD>";
                }
                $block = shift(@blocks);
                if ($block) {
                        print "<TD WIDTH=\"50%\"><INPUT TYPE=CHECKBOX NAME=\"block\" VALUE=\"$block\">$block\n<BR>\n</TD></TR>";
                } else {
                        print "<TD WIDTH=\"50%\">&nbsp\;</TD></TR>";
                }
        } while ($block ne "");
        print "</TABLE>\n";
        print "</TD></TR>\n";

        print "<TR><TD ALIGN=center>\n";
        print "<INPUT TYPE=reset VALUE=\"Reset!\">\n";
        print "</TD><TD ALIGN=center>\n";
        print "<INPUT TYPE=submit VALUE=\"Submit!\">\n";
        print "</TD></TR>\n";

        print "</FORM>\n";
        print "</TABLE>\n";

        print "</TD></TR></TABLE\n";
        printStdFooter();
}

# Done									#
#########################################################################
