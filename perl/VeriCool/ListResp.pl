#!/usr/local/bin/perl -w
#########################################################################
# Script name: ListResp.pl 0.1 beta					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-07-09					#
# Comments: Script that lists the reponsible persons for the different  #
# blocks. The information is found in $vc_ini. The script can be called #
# with two different arguments:                                         #
#       ByUser: The responsibiletys is listed by user.                  #
#       ByBlock: The responsibiletys is listed bu the block.            #
#                                                                       #
# The $vc_ini file shall look something like this:                      #
#       ...                                                             #
#       [user]                                                          #
#       user=block;block...                                             #
#       ...                                                             #
#       [designname]                                                    #
#       ...                                                             #
#########################################################################
# Set strict mode.							#

use strict;
use vars qw($vc_ini $menubarfile);

# Done									#
#########################################################################
# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Declare vareables.							#

my ($arg) = pop(@ARGV);
my (@vc_ini, $user, @blocks, $block);
my ($row) = "";

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Main program.								#

@vc_ini = getFileCont($vc_ini);

# Delete everything but the significant rows.
while ($row ne "[user]") {
        $row = shift(@vc_ini);
        chomp($row);
}
while ($row ne "[designname]") {
        $row = pop(@vc_ini);
        chomp($row);
}

returnHTML($arg, @vc_ini);

exit 0;

# Done									#
#########################################################################
# Returns the HTML.                 					#

sub returnHTML {
        my ($arg, @vc_ini) = @_;
        my ($row, @file, $header, $linktitle, $linkarg);

        print "Content-type: text/html\n\n";
        print "<HTML><HEAD>\n\n";
        @file = getFileCont("$menubarfile");
        foreach $row (@file) {
                print "$row";
        }
        ($header, $linktitle, $linkarg) = ($arg eq "ByUser") ? ("Responsibilety table sorted by user.", "Sort by block", "ByBlock") : ("Responsibilety table sorted by block.", "Sort by user", "ByUser");
        print "\n</HEAD>\n\n<BODY BGCOLOR=\"#000000\" TEXT=\"#000000\" onLoad=\"init()\">\n<BR><BR>\n";
        print "<H1><FONT COLOR=\"#ffffff\">$header</FONT></H1>\n\n<CENTER>\n";

        $ENV{'REQUEST_URI'} =~ s/\?.*$//g;
        print "<A HREF=\"http://$ENV{'HTTP_HOST'}$ENV{'REQUEST_URI'}?$linkarg\">$linktitle</A>\n";

        print "<TABLE BORDER=0 WIDTH=\"80%\" BGCOLOR=\"#FFFFFF\">\n\n";

        @vc_ini = sort(@vc_ini);

        if ($arg eq "ByUser") {
                foreach $row (@vc_ini) {
                        chomp ($row);
                        ($user, $block) = split("=", $row);
                        @blocks = split(";", $block);
                        print "<TR><TD VALIGN=top>\n$user\n</TD><TD VALIGN=top>";
                        @blocks = sort(@blocks);
                        foreach $block (@blocks) {
                                print "$block<BR>";
                        }
                        print "</TD></TR>\n\n";
                }
        }
        else {
                my (@all_blocks);
                foreach $row (@vc_ini) {
                        chomp ($row);
                        ($user, $block) = split("=", $row);
                        @blocks = split(";", $block);
                        foreach $block (@blocks) {
                                push (@all_blocks, "$block=$user");
                        }
                }
                @all_blocks = sort(@all_blocks);

                foreach $block (@all_blocks) {
                        ($block, $user) = split("=", $block);
                        print "<TR><TD VALIGN=top>\n$block\n</TD><TD VALIGN=top>$user</TD></TR>\n\n";
                }
        }
        print "</TABLE>\n\n</CENTER>\n</BODY>\n</HTML>\n";
}

# Done									#
#########################################################################
# Returns filecont of $file.    					#

sub getFileCont {
        my ($file) = @_;
        my (@file);
        open (FILE, "$file") || expError("Cannot open $file in main::getFileCont()");
        @file = <FILE>;
        close FILE;
        return @file;
}

# Done									#
#########################################################################
# Error handling routine.						#

sub expError {
	my ($errmsg) = @_;
	print "Content-type: text/html\n\n";
	print $errmsg;
	exit 1;
}

# Done									#
#########################################################################
