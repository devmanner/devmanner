#!/usr/bin/perl -w
#################################################################################
# Script name: imgBrowser.pl (C) 2001                                           #
# Version: 1.1                                                                  #
# Author: Tomas Mannerstedt                                                     #
# Contact: d00_tma@kringlan.telge.kth.se                                        #
# Comments: This script is a simple image browser. It returns a HTML page with  #
# an image and a list of all the avaiable directorys with pics under $picdir.   #
# It needs the $dbfile created with:                                            #
#                                                                               #
# [tomas@localhost imgbrowser]$ /bin/ls -R pics/ > pics.db                      #
# [tomas@localhost imgbrowser]$                                                 #
#                                                                               #
# This is used because the script must be able to run even though the script    #
# and the pics are placed on different servers.                                 #
# Script can also be called without argument. It will then only print the       #
# avaiable categorys.                                                           #
#################################################################################
# Our friend                                                                    #
use strict;
# Declarations                                                                  #
my $dbfile = '/home/tomas/perl/imgbrowser/pics.db';
my $baseurl = 'http://kalle.nu';
my $picdir = 'pics';
my $scripturl = 'http://kalle.nu/cgi-bin/imgBrowser.pl';
my $header = 'Bilder fran nollningen 2001 KTH';

# Main program                                                                  #

# Disply only the directorys.                                                   #
if (!($ARGV[0])) {
        printHeader($header);
        printDirsHTML(getFirstInDir(getFiles($dbfile)));
        printFooter();
} else {
        # Get the files                                                         #
        my (%DB) = getFiles($dbfile);
        # Get current                                                           #
        my ($currdir, $currpic) = split(/\//, $ARGV[0]);
        # Get previous                                                          #
        my ($prevpic) = getPrev($currpic, @{ $DB{"$picdir/$currdir"}});
        # Get next                                                              #
        my ($nextpic) = getNext($currpic, @{ $DB{"$picdir/$currdir"}});
        # Get the first file in each dir                                        #
        my (@first_in_each) = getFirstInDir(%DB);
        # Return some HTML                                                      #
        returnPicHTML($baseurl, $scripturl, $picdir, $currdir, $currpic, $prevpic, $nextpic, @first_in_each);
}

exit 0;
# DOne                                                                          #
#################################################################################
# Subroutines                                                                   #

# Print dirs in HTML format.                                                    #
sub printDirsHTML {
        my (@firsts) = @_;
        my ($dirlabel, $first);
        print "<BR><BR>Alla kategorier:<BR><BR>\n";
        foreach $first (@firsts) {
                ($dirlabel, undef) = split(/\//, $first);
                $dirlabel =~ s/_/ /g;
                print "<A HREF=\"$scripturl?$first\">$dirlabel</A><BR>\n";
        }
}

# Rerurn a pic and the dirs in HTML format                                      #                                                                  #
sub returnPicHTML {
        my ($baseurl, $scripturl, $picdir, $currdir, $currpic, $prevpic, $nextpic, @firsts) = @_;
        printHeader($header);
        print "\n<IMG SRC=\"$baseurl/$picdir/$currdir/$currpic\">\n<BR>\n\n";

        if ($prevpic) {
                print "<A HREF=\"$scripturl?$currdir/$prevpic\">Faregaende</A>\n";
        } else {
                print "Foregaende\n";
        }
        print "&nbsp\;&nbsp\;&nbsp\;&nbsp\;&nbsp\;\n";
        if ($nextpic) {
                print "<A HREF=\"$scripturl?$currdir/$nextpic\">Nasta</A>\n\n";
        } else {
                print "Nasta\n\n";
        }
        printDirsHTML(@firsts);
        printFooter();
}

# DOne                                                                          #
#################################################################################
# Get the first file in each directory.                                         #

sub getFirstInDir {
        my (%DB) = @_;
        my (@first_in_each, $dir);

        foreach $dir (sort keys(%DB)) {
                if ($DB{$dir}[0] =~ m/.+\.jpg$/ ) {
                        push(@first_in_each, "$dir/$DB{$dir}[0]");
                }
        }
        foreach $dir (@first_in_each) {
                $dir =~ s/^$picdir\///ig;
        }
        return @first_in_each;
}

# DOne                                                                          #
#################################################################################
# Get the prev pic                                                              #

sub getPrev {
        my ($currpic, @pics) = @_;
        my ($pic, $prevpic);
        my $found = 0;

        foreach $pic (@pics) {
                if ($pic eq $currpic) {
                        $found = 1;
                } elsif (!($found)) {
                        $prevpic = $pic;
                }
        }
        return ($prevpic) ? $prevpic : "";
}

# DOne                                                                          #
#################################################################################
# Get the next pic

sub getNext {
        my ($currpic, @pics) = @_;
        my ($pic, $nextpic);
        my $found = 0;

        foreach $pic (@pics) {
                if ($found) {
                        $nextpic = $pic;$found = 0;
                } elsif ($pic eq $currpic) {
                        $found = 1;
                }
        }
        return ($nextpic) ? $nextpic : "";
}

# DOne                                                                          #
#################################################################################
# Return the pics.

sub getFiles {
        my ($dbfile) = @_;
        my (@dbfile) = getFileCont($dbfile); # or a `ls -R`
        my (%DBASE);
        my ($currname);

        foreach my $item (@dbfile) {
                if ($item =~ m/:/) {
                        $currname = $item;
                        $currname =~ s/://g;
                } else {
                        push(@{ $DBASE{$currname} }, $item);
                }
        }
        return %DBASE;
}

# DOne                                                                          #
#################################################################################
# Return file contens of $file

sub getFileCont {
        my ($file) = @_;
        open (FILE, "<$file") || error ("Cannot open $file");
        my (@file) = <FILE>;
        close FILE;
        return stripFile(@file);
}

# DOne                                                                          #
#################################################################################
# Get rid off empty rows and \n

sub stripFile {
        my (@file);
        foreach my $row (@_) {
                chomp($row);
                if ($row) {
                        push(@file, $row);
                }
        }
        return @file;
}

# DOne                                                                          #
#################################################################################
# Print HTML header

sub printHeader {
        my ($header) = @_;
        print "Content-type: text/html\n\n";
        print "<HTML><HEAD>\n<TITLE>$header</TITLE>\n</HEAD>\n\n<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\">\n<CENTER><BR><BR>\n";
}

# DOne                                                                          #
#################################################################################
# Print HTML footer

sub printFooter {
        print "<BR><BR>(C)2001 KTH Sodertalje <A HREF=\"mailto: d00_tma\@kringlan.telge.kth.se\">Tomas Mannerstedt</A>\n";
        print "</CENTER>\n\n</BODY>\n</HTML>\n";
}

# DOne                                                                          #
#################################################################################
# Nice errors.

sub error {
        printHeader("Error");
        print "@_";
        printFooter();
        exit -1;
}

# DOne                                                                          #
#################################################################################
