#!/usr/local/bin/perl
#########################################################################
# Script name: RmNode.pl v. 0.2.3 beta  				#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-06-12					#
# Comments: Remove a node in the TR three. Three different modes are    #
# supported:                                                            #
#       *       If the node is a root node and the -r option is enabled #
#               the whole tree will be recursivly removed.              #
#       *       If the node is not a root node and the -r option is     #
#               given the node and all its follow ups will be removed.  #
#       *       If the node is not a root node only that node will be   #
#               deleted. Its follow ups will be connected to the        #
#               previous in the thread.                                 #
# All next and prev pointers will be fixed when files are deleted.      #
#########################################################################
# Set strict mode.							#
use strict;
use vars qw($issue_dir $arch_dir $html_err);
# Use the VeriCool TR module                                            #
use vc_tr;
# Set no html mode in error handling.                                   #
$html_err = 0;
# Get variables.
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";
do $varfile;

# Done                                                                  #
#########################################################################
# Main                                                                  #

if (!($ARGV[0] && $ARGV[1]) || $ARGV[0] eq "-h" || $ARGV[0] eq "--help") {
         expError("This command removes one or many nodes in the TR thread. The next and the prev pointers of the surrounding nodes in the TR database will be fixed when removeing a node.\n\nUsage: RmThread.pl [-h] [-r] dir node\n*  -r Recursivly remove.\n*  -h Display this message.\n*  dir is either Archive or Issue.\n*  node may be either:\n    -  The root of a thread. (only if -r option)\n    -  A node\nIf the -r option (optonal) is given the node will be recursivly removed.\nEx: RmThread Issue issue_12.db\n");
}

if ($ARGV[0] eq "-r") {
        shift (@ARGV);
        my ($act_dir) = shift(@ARGV);
        $act_dir = ($act_dir eq "Archive" || $act_dir eq "archive") ? $arch_dir : $issue_dir;

        my ($basefile) = shift(@ARGV);
        if (!($basefile =~ m/^issue_[0-9]{1,14}\.db$/ || $basefile =~ m/^fu_issue_[0-9]{1,14}\.db$/)) {
                expError("\'$basefile\' does not match an issue file.\n");
        }
        print "Removeing:\n";
        rmNodeRec("$act_dir/$basefile");
}
else {
        my ($act_dir) = shift(@ARGV);
        my ($basefile) = shift(@ARGV);
        $act_dir = ($act_dir eq "Archive" || $act_dir eq "archive") ? $arch_dir : $issue_dir;
        if (!($basefile =~ m/^fu_issue_[0-9]{1,14}\.db$/)) {
                expError("\'$basefile\' does not match a follow up file.\nDid you forget the -r flag?\n");
        }

        rmNode("$act_dir/$basefile");
}
exit 0;

# Done                                                                  #
#########################################################################
# Recursivly remove the files associated to $file                       #

sub rmNodeRec {
        my ($file) = @_;
        my ($next, @next);
        my (%FILECONT);
        %FILECONT = split2Hash("###", getFileCont("$file"));

        if (-e $FILECONT{'prev'}) {
                my (%PREVFILE) = split2Hash("###", getFileCont($FILECONT{'prev'}));
                my (@pnext) = split(/\#\#\#/, $PREVFILE{'next'});
                my ($cnt) = 0;
                foreach $next (@pnext) {
                        if ($next eq $file) {
                                splice(@pnext, $cnt, 1);
                        }
                        $cnt ++;
                }
                $PREVFILE{'next'} = join ("###", @pnext);
                putHash2File($FILECONT{'prev'}, "###", %PREVFILE);
        }
        print "$file\n";
        `/usr/bin/rm $file`;
        @next = split(/\#\#\#/, $FILECONT{'next'});
        foreach $next (@next) {
                rmNodeRec($next);
        }
}

# Done									#
#########################################################################
# Remove a node and fix the surrounding next and prev pointers.         #

sub rmNode {
        my ($file) = @_;
        my (%FILECONT) = split2Hash("###", getFileCont("$file"));
        my (%PREVFILE) = split2Hash("###", getFileCont($FILECONT{'prev'}));
        my (@next, $next);
        my ($cnt) = 0;
        @next = split("###", $FILECONT{'next'});

        # Fix the next files prev pointers.
        foreach $next (@next) {
                my (%NEXTFILE) = split2Hash("###", getFileCont("$next"));
                $NEXTFILE{'prev'} = $FILECONT{'prev'};
                putHash2File($next, "###", %NEXTFILE);
        }

        # Fix the prev file's next pointers.
        @next = split("###", $PREVFILE{'next'});
        foreach $next (@next) {
                if ($next eq $file) {
                        splice(@next, $cnt, 1);
                }
                $cnt ++;
        }
        $PREVFILE{'next'} = join ("###", @next);
        $PREVFILE{'next'} = join("###", $PREVFILE{'next'}, $FILECONT{'next'});
        putHash2File($FILECONT{'prev'}, "###", %PREVFILE);
        # Removeing.
        print "Removeing:\n$file\n";
        `/usr/bin/rm $file`;
}

# Done									#
#########################################################################
