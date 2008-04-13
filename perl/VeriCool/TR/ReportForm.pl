#!/usr/local/bin/perl -w
#########################################################################
# Script name: ReportForm.pl 1.0.1 beta   				#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-06-11              			#
# Comments: This perlscript generates a html form for trouble report.	#
# The available blocks and releases are found in the $vc_ini file and	#
# $release_dir. If a block or / and a release is selecter in the	#
# VeriCool menutree, that perticular block or release is selected in	#
# the form. This is done by looking in the $ENV{'HTTP_REFERER'}		#
# vareable. The reporter field will be pre selected if the current user #
# is logged in.                                                         #
#########################################################################
# uses                                                                  #

use strict;
use vc_tr;

# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";
use vars qw($tr_cgi_url $sendmail @prio_avail $issue_dir $arch_dir $release_dir $menubarfile $vc_ini);

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Initial setup.							#

my (@blocks, @releases, @vc_ini, $act_dir, $prev_file, $sel_block, $sel_release);
$prev_file = shift(@ARGV);

# Done									#
#########################################################################
# Main program.                                                 	#

# Security check.
if (!($prev_file =~ m/^issue_[0-9]{1,14}\.db$/ || $prev_file =~ m/^fu_issue_[0-9]{1,14}\.db$/ || $prev_file eq "")) {
        expError("Illegal call!!!\n\n");
}

@vc_ini = getFileCont("$vc_ini");
@blocks = getBlocks(@vc_ini);
unshift(@blocks, "Select a block from list", "Unknown");
@releases = getReleases($release_dir);
unshift(@releases, "Select a release from list");
($sel_block, $sel_release) = getSelected("$issue_dir/$prev_file");
returnHTML($sel_block, $sel_release, $prev_file);

# Done									#
#########################################################################
# Get the Block and Release from where user came by looking in		#
# the HTTP_REFERER.							#

sub getSelected {
        my ($lastfile) = @_;
        my ($addr, $args) = split(/\?/, $ENV{HTTP_REFERER});
        my @addr = split(/\//, $addr);
        my $script_name = pop(@addr);
        my ($sel_release, $sel_block, $trash, @trash, $label, $file, $reldir, $block);
        my (@file, $pair);

        if ($script_name eq "ViewBlockInfo.pl")
        	{($sel_release, @trash) = split(/\./, $args);}
        elsif ($script_name eq "ViewCHFiles.pl") {
        	($reldir, $trash, $label) = split(/\//, $args);
        	($sel_release, @trash) = split(/\./, $reldir);
        	($trash, $block) = split(/-/, $label);
        	($sel_block, @trash) = split(/_/, $block);}
        elsif ($script_name eq "PrintFile.pl") {
        	($file, @trash) = split(/\+/, $args);
        	(@trash) = split(/\//, $file);
        	$file = pop(@trash);
        	$trash = pop(@trash);
        	$reldir = pop(@trash);
        	($sel_release, @trash) = split(/\./, $reldir);
        	($trash, $block) = split(/-/, $file);
        	($sel_block, $trash) = split(/_/, $block);
        }
        elsif ($lastfile) {
                open(FILE, "$lastfile") || expError("Cannot open lastfile");
                @file = <FILE>;
                close FILE;
                foreach $pair (@file) {
                        if ($pair =~ "block###") {
                                $sel_block = $pair;
                                $sel_block =~ s/block###//g;
                        }
                        elsif ($pair =~ "release###") {
                                $sel_release = $pair;
                                $sel_release =~ s/release###//g;
                        }
                }
                chomp($sel_block);
                chomp($sel_release);
        }
        else {
                $sel_block = "Select a block from list";
	        $sel_release = "Select a release from list";
        }
        return ($sel_block, $sel_release);
}

# Done									#
#########################################################################
# Return HTML.								#

sub returnHTML {
        my ($sel_block, $sel_release, $prev_file) = @_;
        my ($priority, $block, $release, $default_header, $button_text);
        my (%COOKIE) = getCookie();
        my (%PREVFILE);
        printStdHeader();

        if ($prev_file) {
                print "<H1 STYLE=\"color: #FFFFFF\">Post a follow up.</H1>\n\n";
                (%PREVFILE) = split2Hash("###", getFileCont("$issue_dir/$prev_file"));
                $default_header = "Re: $PREVFILE{'header'}";
                $button_text = "Post follow up!";
        } else {
                print "<H1 STYLE=\"color: #FFFFFF\">Report a trouble</H1>\n\n";
                $button_text = "Report TR!";
        }

        print "<CENTER><TABLE WIDTH =\"90%\" BGCOLOR=\"#FFFFFF\" BORDER=0><TR><TD>\n\n";

        print "<P align=adjust>\n";
        print "<BR>&nbsp\;&nbsp\;&nbsp\;&nbsp\;\n";
        print "Use this form to report a new trouble.\n";
        $varfile =~ s/^\/.*\///g;
        if ($sendmail == 0)
                {print "<BR>&nbsp\;&nbsp\;&nbsp\;&nbsp\;\nNote: No mail will be sent while \$sendmail is set to 0. Change this in: $varfile (Contact the webmaster if you don't know what this means.)\n";}
        elsif ($sendmail == 1)
        	{print "<BR>&nbsp\;&nbsp\;&nbsp\;&nbsp\;\nNote: e-mail will be sent to the responsible person. To disable this, set \$sendmail to 0 in $varfile (Contact the webmaster if you don't know what this means.)\n";}

        print "</P>\n";

        print "<TABLE WIDTH=\"100%\">\n";
        print "<TR><TD WIDTH=\"50%\">\n";
        print "<FORM ACTION=\"$tr_cgi_url/ReportTR.pl?$prev_file\" METHOD=\"POST\">\n";
        print "<INPUT TYPE=\"hidden\" NAME=\"status\" VALUE=\"Issue\">\n";

        print "Reported by (UNIX id):\n";
        print "</TD><TD WIDTH=\"50%\">\n";
        print "<INPUT TYPE=\"text\" NAME=\"reporter\" SIZE=\"8\" MAXLENGTH=\"8\" VALUE=$COOKIE{'uid'}>\n";
        print "</TD></TR>\n";

        print "<TR><TD>\n";
        print "Select Block:\n";
        print "</TD><TD>\n";
        print "<SELECT NAME=\"block\">\n";

        print "\n\nSELBLOCK $sel_block\n\n";

        foreach $block (@blocks) {
        	if ($block eq $sel_block)
        		{print "<OPTION SELECTED>$block</OPTION>\n";}
	        else
	        	{print "<OPTION>$block</OPTION>\n";}
}
        print "</SELECT>\n";
        print "</TD></TR>\n";

        print "<TR><TD>\n";
        print "Select Release:\n";
        print "</TD><TD>\n";
        print "<SELECT NAME=\"release\">\n";

        foreach $release (@releases) {
        	if ($release eq $sel_release)
        		{print "<OPTION SELECTED>$release</OPTION>\n";}
	        else
	        	{print "<OPTION>$release</OPTION>\n";}
        }
        print "</SELECT>\n";
        print "</TD></TR>\n";

        print "<TR><TD>\n";
        print "Priority:\n";
        print "</TD><TD>\n";
        print "<SELECT NAME=\"prio\">\n";
        foreach $priority (@prio_avail)
	        {print "<OPTION>$priority</OPTION>\n";}

        print "</SELECT>\n";
        print "</TD></TR>\n";

        print "<TR><TD>\n";
        print "Header:\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=\"text\" NAME=\"header\" SIZE=\"20\" MAXLENGTH=\"40\" VALUE=\"$default_header\">\n";
        print "</TD></TR>\n";

        print "<TR><TD VALIGN=\"top\">\n";
        print "Describe problem:\n";
        print "</TD><TD>\n";
        print "<TEXTAREA COLS=40 ROWS=10 NAME=\"description\"></TEXTAREA>\n";
        print "</TD></TR>\n";

        print "<TR><TD>\n";
        print "&nbsp\;\n";
        print "</TD><TD>\n";
        print "<INPUT TYPE=\"reset\" VALUE=\"Clear Form\">\n";
        print "<INPUT TYPE=\"submit\" VALUE=\"$button_text\">\n";
        print "</TD></TR>\n";

        print "</FORM>\n\n";
        print "</TABLE>\n\n";
        print "<CENTER>All the fields must be filled out!<BR>Do not try to use HTML tags. If you would like to refer to another page just enter its URL (beginning with http://) and it'll be displayed as a link.</CENTER>\n";

        print "</TD></TR></TABLE\n";

        printStdFooter();
}

# Done									#
#########################################################################