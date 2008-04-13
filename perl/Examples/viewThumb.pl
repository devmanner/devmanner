#!/usr/local/bin/perl -w
#########################################################################
# Script name: viewThumb.pl                                             #
# Author: Tomas Mannerstedt qtxtman@etxb.ericsson.se                    #
# Known limitations: The arg to getFiles() may not be any kind of       #
# argument given by remote user.                                        #
# The thumbnail to the file X.jpg must be X.gif.                        #
#########################################################################
# Main                                                                  #

use strict;

my $dbdir = "/home/qtxtman/public_html/testimg";
my $baseurl = "http://avweb.etxb.ericsson.se/~qtxtman/testimg";
my $header = "Bilder!";
my (@files) = getFiles("$dbdir/*.gif");
returnHTML($header, $baseurl, @files);
exit 0;

# Done									#
#########################################################################
# Returns HTML                                                          #

sub returnHTML {
        my ($header, $baseurl, @pics) = @_;
        my ($gif, $cnt, $jpeg);
        print "Content-type: text/html\n\n";
        print "<HTML><HEAD>\n\n";
        print "</HEAD>\n\n<BODY BGCOLOR=\"#ffffff\" TEXT=\"#000000\">\n\n";
        print "<H1><FONT COLOR=\"#FFFFFF\">$header</H1>\n\n";
        print "<TABLE WIDTH=\"100%\" BORDER=1><TR>\n";

        $cnt = 0;
        foreach $gif (@pics) {
                $gif =~ s/\/.*\///g;
                $jpeg = $gif;
                $jpeg =~ s/\.gif/\.jpg/gi;
                if ($cnt == 4) {
                        print "</TR><TR><TD WIDTH=\"25%\" align=center><A HREF=\"$baseurl/$jpeg\"><IMG SRC=\"$baseurl/$gif\" BORDER=0></A><BR><A HREF=\"$baseurl/$jpeg\">$jpeg</A></TD>\n";
                        $cnt = 0;
                } else {
                        print "<TD WIDTH=\"25%\" align=center><A HREF=\"$baseurl/$jpeg\"<IMG SRC=\"$baseurl/$gif\" BORDER=0></A><BR><A HREF=\"$baseurl/$jpeg\">$jpeg</A></TD>\n";
                }
                $cnt ++;
        }

        print "</TR></TABLE>\n";
        print "</BODY></HTML>\n";
}

# Done									#
#########################################################################
# Returns an array of files matching the @filter filter. @filter may    #
# contain paths.                                                        #

sub getFiles {
        my (@filters) = @_;
        my (@files, $files, $filter);
        chdir ("/");
        foreach $filter (@filters) {
                $files = `/bin/ls -1r $filter`;
                push (@files, split(/\n/, $files));
        }
        return @files;
}

# Done									#
#########################################################################


