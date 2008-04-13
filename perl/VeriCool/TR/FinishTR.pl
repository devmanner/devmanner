#!/usr/local/bin/perl -w
#########################################################################
# Script name: FinishTR.pl 0.2 beta					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-06-14					#
# Comments: This script moves all the files related to $ARGV[0] to      #
# $arch_dir. It also changes the paths in next and prev pointers. The   #
# script aborts if the current user is not the same as the creator of   #
# the TR.                                                               #
#########################################################################
# Set strict mode.							#

use strict;
use vc_tr;
use vars qw($issue_dir $arch_dir $tr_cgi_url);
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";
do $varfile;

# Done									#
#########################################################################
# Define vareables							#

#my ($treebase) = shift(@ARGV);
my (%COOKIE) = getCookie();
my (%FORM) = pharseForm();
my (%FILECONT);
my (@basefiles, $basefile);

# Done									#
#########################################################################
# Main                                                                  #
# X-tra security check.

@basefiles = split(/\+/, $FORM{'basefiles'});
foreach $basefile (@basefiles) {
        if (!(-e "$issue_dir/$basefile") || $basefile !~ m/^issue_[0-9]{1,14}\.db$/i ) {
                expError("An error occured when trying to finish: $basefile\n");
        }
        %FILECONT = split2Hash("###", getFileCont("$issue_dir/$basefile"));
        if ($FILECONT{'reporter'} ne $COOKIE{'uid'}) {
                expError("Only the creator of the thread (in this case $FILECONT{'reporter'}) can finish this TR.");
        }
}

# Finish it up.                                                         #

foreach $basefile (@basefiles) {
        finishFiles("$issue_dir/$basefile");
}

# Redirect.                                                             #

print "Location: $tr_cgi_url/ViewTRTree.pl?Archive\n\n";
exit 0;

# Done									#
#########################################################################
# Get input and fix all the strange signs in the header and problem	#
# fields. Do not allow SSI. Only allow 0-9 in @ARGV. If user tries to	#
# print HTML-tags, they are exchanged to &lt; and &gt;.			#

sub pharseForm {
	my ($buffer, @pairs, $pair, $name, $value, %FORM);
	read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
#$buffer = "basefiles=kalle";

	@pairs = split(/&/, $buffer);
	foreach $pair (@pairs) {
		($name, $value) = split(/=/, $pair);
		$value =~ s/\+/ /g;
                $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

                if ($name eq "basefiles" && !($value =~ m/^issue_[0-9]{1,14}\.db$/i)) {
                        expError("Basefile does not match the name of a basefile.\n\n");
                }

                if (!($FORM{$name})) {
		        $FORM{$name} = $value;
                } else {
                        $FORM{$name} = join("+", $FORM{$name}, $value),
                }
	}

        return (%FORM);
}

# Done									#
#########################################################################
# Define vareables							#

sub finishFiles {
        my ($file) = @_;
        my ($key, $next, @next, @file);
        my (%FILECONT) = split2Hash("###", getFileCont($file));

        # Get next before change of path in next.
        @next = split(/\#\#\#/, $FILECONT{'next'});

        $FILECONT{'next'} =~ s/$issue_dir/$arch_dir/g;
        $FILECONT{'prev'} =~ s/$issue_dir/$arch_dir/g;

        open (FILE, ">$file") || expError("Cannot open $file for writeback");
        foreach $key (sort keys(%FILECONT)) {
                print FILE "$key###$FILECONT{$key}\n";
        }
        close FILE;

        $file =~ s/^\/.*\///ig;
        `/usr/bin/mv -f $issue_dir/$file $arch_dir/$file`;
        foreach $next (@next) {
                finishFiles($next);
        }
}

# Done									#
#########################################################################