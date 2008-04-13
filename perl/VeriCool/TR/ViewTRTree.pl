#!/usr/local/bin/perl
#########################################################################
# Script name: ViewTRTree.pl 2.2.2					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-06-01					#
# Comments: This script prints out the TR thread. It is able to run in  #
# a few modes. It can be called by request method POST (f.e. from       #
# TRSearch.pl) or GET. The @ARGV may contain:                           #
#       ->    Nothing: Whole "issue" directory is listed.               #
#       ->    ShowOnUser: All TR's with the current user are displayed. #
#       ->    [dbdir (Archive || Issue)] + [dont_href.db] +             #
#             [dbfiles.db]... : All                                     #
#             dbfiles.db in dbdir will be displayed in the thread. The  #
#             dont_href.db will be displayed as plain text instead of a #
#             href. If no further argument than dir is given, all TR's  #
#             in that dir will be displayed.                            #
#########################################################################
# Set strict mode.							#

use strict;
use vars qw($menubarfile $issue_dir $arch_dir $baseurl $picdir $tr_cgi_url @prio_avail %PRIO_COLOR $fixed_font $treeviewscript_url);
use vc_tr;

# Done									#
#########################################################################
# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#

my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Declare vareables.							#

my ($act_dir, $arg, @viewfiles, $print_footer, $print_bott_lnk, $dont_href);
my (%TERMS);

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Main program.								#
# Globals                                                               #

$act_dir = shift(@ARGV);

if ($ENV{'REQUEST_METHOD'} eq "POST") {
        my (@act_dirs, $dir);
        (%TERMS) = pharseForm();
        $TERMS{'dir'} = ($TERMS{'dir'} eq "Issue") ? $issue_dir : $arch_dir;
        @viewfiles = getFiles("$TERMS{'dir'}/issue_*.db");
        @viewfiles = searchFiles(@viewfiles);

        printHeader("Search results");
        printTree("PostNew", "href all", "FinishOff", @viewfiles);
        printFooter();
}
elsif ($act_dir =~ "ShowOnUser") { # Uses the search function.
        my (%COOKIE) = getCookie();
        if ($COOKIE{'uid'}) {
                $TERMS{'reporter'} = $COOKIE{'uid'};
                $TERMS{'boolean'} = "And";
                $TERMS{'dir'} = "Issue";

                @viewfiles = getFiles("$issue_dir/issue_*.db");
                @viewfiles = searchFiles(@viewfiles);
        }
        printHeader("My Active TR's");
        printTree("PostNew", "href all", "FinishOn", @viewfiles);
        printFooter();
}
else {
        $print_bott_lnk = "ViewAll+$act_dir";
        $act_dir = ($act_dir eq "Archive") ? $arch_dir : $issue_dir;
        $dont_href = shift(@ARGV);
        if ($dont_href && $dont_href !~ m/^issue_[0-9]{1,14}\.db$/i && $dont_href !~ m/^fu_issue_[0-9]{1,14}\.db$/i) {
                expError("Illegal call! arg.[$dont_href]");
        }
        $dont_href = (!($dont_href)) ? "href all" : $dont_href;

        # Put the files to view in viewfile.
        foreach $arg (@ARGV) {
                if (!($arg =~ m/^issue_[0-9]{1,14}\.db$/i || $arg eq "")) {
                        expError("Illegal call!!!\n\n");
                }
                push (@viewfiles, "$act_dir/$arg");
        }

        if ($viewfiles[0] eq "") { # All TR's are displayed.
                if ($act_dir eq $arch_dir) {
                        printHeader("TR Archive");
                } else {
                        printHeader("Active TR's");
                }
                @viewfiles = getFiles("$act_dir/issue_*.db");
                $print_footer = "TRUE";
                $print_bott_lnk = ($act_dir =~ m/Issue$/) ? "PostNew" : "None";
        }

        # $viewfiles[] contains all the files in the base of the tr threads to be viewed.
        printTree($print_bott_lnk, $dont_href, "FinishOff", @viewfiles);
}

if ($print_footer) { # All TR's are displayed.
        printFooter();
}

exit 0;

# Done									#
#########################################################################
# Recurivly search thrugh the @viewfiles and return the files that      #
# shall be showed in the tree.                                          #

sub searchFiles {
        my (@searchfiles) = @_;
        my (@matchfiles, $file);
#        print "Content-type: text/html\n\n";
#        foreach my $key (sort keys(%TERMS)) {
#                print "$key = $TERMS{$key}<BR>\n";
#        }
        foreach $file (@searchfiles) {
                #print "SEARCHING: $file<BR>";
                push(@matchfiles, recSearch($file, $file));
        }
        return (@matchfiles);
}

sub recSearch {
        my ($treebase, $file) = @_;
        my ($key, @next, $next, @terms, $term, $retval);
        my $match = 1;
        my (%FILECONT) = split2Hash("###", getFileCont($file));

        if ($TERMS{'boolean'} eq "Or") {
                foreach $key (sort keys(%TERMS)) {
                        @terms = split(/\+/, $TERMS{$key});
                        foreach $term (@terms) {
                                if (($term eq $FILECONT{$key}) || ($key eq "description" && $FILECONT{$key} =~ $term) || ($key eq "description" && $FILECONT{'header'} =~ $term)) {
                                        return ($treebase);
                                }
                        }
                }
                @next = split("###", $FILECONT{'next'});
                foreach $next (@next) {
                        $retval = recSearch($treebase, $next);
                        if ($retval) {
                                return $retval;}
                }
                return;
        }
        elsif ($TERMS{'boolean'} eq "And") {
                foreach $key (sort keys(%TERMS)) {
                        @terms = split(/\+/, $TERMS{$key});
                        foreach $term (@terms) {
                                if (($term ne $FILECONT{$key} && !($key eq "description" || $key eq "boolean" || $key eq "dir")) || ($key eq "description" && !($FILECONT{$key} =~ $term) && !($FILECONT{'header'} =~ $term))) {
                                        $match = 0;
                                }
                        }
                }
                if ($match) {
                        return $treebase;
                }

                @next = split("###", $FILECONT{'next'});
                foreach $next (@next) {
                        $retval = recSearch($treebase, $next);
                        if ($retval) {
                                return $retval;}
                }
                return;
        }
}

# Done									#
#########################################################################
# Get input and fix all the strange signs in the header and problem	#
# fields.                                                               #

sub pharseForm {
        my (%FORM);
	my ($buffer, @pairs, $pair, $name, $value);
	read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
	@pairs = split(/&/, $buffer);
	foreach $pair (@pairs) {
		($name, $value) = split(/=/, $pair);
		$value =~ s/\+/ /g;
		$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
                if ($value) { # Dont insert key if no value.
                        if ($FORM{$name}) {
                                $FORM{$name} = join("+", $FORM{$name}, $value);
                        } else {
		                $FORM{$name} = $value;
                        }
                }
	}
        # Check if form contains strange stuff.
        if (!($FORM{'dir'} =~ m/Issue|Archive|Issue\+Archive/i) && $FORM{'dir'} ne "") {
                expError("Illegal call, $buffer");
        }
        return (%FORM);
}

# Done									#
#########################################################################
# Prints out the tree with the @viewfiles as base.                      #

sub printTree {
        my ($bott_lnk, $dont_href, $finish_on, @viewfiles) = @_;
        my ($viewfile, $next, @next, @basefile, @arg, $arg, $treebase);
        my ($pair, $name, $value);
        my ($prio);
        my (%FILECONT);
        my $colors = "\"#cccccc\"";
        my ($time, $weekday, $day, $month, $year);

        print "<!-- Tree headers -->\n<TABLE BORDER=0 WIDTH=\"100%\" CELLSPACING=0 CELLPADDING=0>\n";
        print "\t<TR bgcolor=$colors>\n";
        print "\t<TD CELLSPACING=0 CELLPADDING=0 WIDTH=\"45%\" nowrap>&nbsp\;<B>Report header</B></TD>\n";
        print "\t<TD CELLSPACING=0 CELLPADDING=0 WIDTH=\"20%\" nowrap>&nbsp\;<B>Block</B></TD>\n";
        print "\t<TD CELLSPACING=0 CELLPADDING=0 WIDTH=\"15%\" nowrap>&nbsp\;<B>Release</B></TD>\n";
        print "\t<TD CELLSPACING=0 CELLPADDING=0 WIDTH=\"10%\" nowrap>&nbsp\;<B>Reporter</B></TD>\n";
        print "\t<TD CELLSPACING=0 CELLPADDING=0 WIDTH=\"5%\" nowrap>&nbsp\;<B>Date</B></TD>\n";
        # Check if I shall print out the finish radio buttons.
        if ($finish_on eq "FinishOn" && $viewfiles[0]) {
                print "\t<FORM ACTION=\"$tr_cgi_url/FinishTR.pl\" METHOD=\"POST\"><TD CELLSPACING=0 CELLPADDING=0 WIDTH=\"5%\" nowrap>&nbsp\;<B>Finish</B></TD>\n";
        }
        print "\t</TR>\n\n";

        if ($viewfiles[0] eq "") {
                my (%COOKIE) = getCookie();
                print "<FONT COLOR=\"#000000\"><BR><BR><CENTER><B>No files in this view.</B></CENTER></FONT>";
                if ($COOKIE{'uid'}) {
                        print "<FONT COLOR=\"#000000\"><BR><BR><CENTER><B>You are recognized as $COOKIE{'uid'}<BR>Fill out form below to change user.</B><BR><BR><TABLE BORDER=0><TR><TD WIDTH=\"50%\" ALIGN=right>User id:</TD><TD WIDTH=\"50%\" ALIGN=left><FORM METHOD=\"POST\" ACTION=\"http://avweb.etxb.ericsson.se/cgi-bin/Mustang/VeriCool/TR/Login.pl\"><INPUT TYPE=\"TEXT\" NAME=\"uid\" SIZE=8 MAXLENGTH=8></TD></TR><TR><TD COLSPAN=\"2\" ALIGN=center><INPUT TYPE=submit VALUE=\"Change User\"></FORM></TD></TR></TABLE></CENTER></FONT>";
                } elsif ($act_dir eq "ShowOnUser" && !($COOKIE{'uid'})) {
                        print "<FONT COLOR=\"#000000\"><BR><BR><CENTER><B>The TR system doesn't know who you are.<BR>Please enter your User ID</B><BR><BR><TABLE BORDER=0><TR><TD WIDTH=\"50%\" ALIGN=right>User id:</TD><TD WIDTH=\"50%\" ALIGN=left><FORM METHOD=\"POST\" ACTION=\"http://avweb.etxb.ericsson.se/cgi-bin/Mustang/VeriCool/TR/Login.pl\"><INPUT TYPE=\"TEXT\" NAME=\"uid\" SIZE=8 MAXLENGTH=8></TD></TR><TR><TD COLSPAN=\"2\" ALIGN=center><INPUT TYPE=submit VALUE=\"Post User ID\"></FORM></TD></TR></TABLE></CENTER></FONT>";
                }
        }

        foreach $viewfile (@viewfiles) {
                %FILECONT = split2Hash("###", getFileCont("$viewfile"));

                # Swap colors.
                $colors = ($colors eq "\"#cccccc\"") ? "\"#ffffff\"" : "\"#cccccc\"";

                # Get the treebase.
                $treebase = $viewfile;
                $treebase =~ s/\/.*\///g;

                # Take out the first row.
                (@next) = split("###", $FILECONT{'next'});

                if ($next[0] eq "") { # The first is all alone in the tree.
#                        print "<!--\n";
#                        foreach my $sump (sort keys (%FILECONT)) {
#                                print "$sump = [$FILECONT{$sump}]\n";
#                        }
#                        print "-->\n\n";

                        (undef, undef, $day, $month, undef) = split(/\./, $FILECONT{'date'});
                        @arg = split(/\//, $viewfile);
                        $arg = pop(@arg);
                        $arg = join("+", $treebase, pop(@arg), $arg);
                        print "<TR bgcolor=$colors><TD CELLSPACING=0 CELLPADDING=0 nowrap>";
                        print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0><TR VALIGN=\"MIDDLE\"><TD>";
                        print "<IMG SRC=\"$baseurl$picdir/trans.gif\" WIDTH=12 HEIGHT=21><IMG SRC=\"$baseurl$picdir/n.gif\">&nbsp\;&nbsp\;&nbsp\;";
                        print "</TD><TD>";

                        if ($viewfile =~ $dont_href) {
                                print "<FONT FACE=\"$fixed_font\"><B>$FILECONT{'header'}</B></FONT></TD>\n";
                        } else {
                                print "<FONT FACE=\"$fixed_font\"><A HREF=\"$tr_cgi_url/ViewTR.pl?$arg\" STYLE=\"color: $PRIO_COLOR{$FILECONT{'prio'}}\">$FILECONT{'header'}</A></FONT></TD>\n";
                        }

                        print "</TR></TABLE></TD>\n";

                        print "<TD bgcolor=$colors CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$FILECONT{'block'}</FONT></TD>\n";
                        print "<TD bgcolor=$colors CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$FILECONT{'release'}</FONT></TD>\n";

                        print "<TD CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$FILECONT{'reporter'}</FONT></TD>\n";
                        print "<TD CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$day&nbsp\;$month</FONT></TD>\n";
                        if ($finish_on eq "FinishOn") {
                                print "<TD ALIGN=center><INPUT TYPE=checkbox NAME=\"basefiles\" VALUE=$treebase>&nbsp\;</TD>\n";
                        }
                        print "</TR>\n\n";
                }
                else {
                        printNode($treebase, $viewfile, $dont_href, $colors, $finish_on, "trans.gif"); # Just to start with a trans.gif
                }
        }
        print "<TR><TD COLSPAN=6 bgcolor=\"#ffffff\" ALIGN=center>";
        # Print the finish button?
        ($finish_on eq "FinishOn") ? print "<INPUT TYPE=\"SUBMIT\" VALUE=\"Finish\"></FORM>\n" : print "&nbsp\;";
        print "</TD>\n</TR>";

        # Print out the bottom links.
        if ($bott_lnk eq "PostNew") {
                print "<TR><TD COLSPAN=6><TABLE WIDTH=\"100%\" CELLPADDING=0 BORDER=0><TR><TD COLSPAN= bgcolor=\"#ffffff\"><CENTER><A HREF=\"$tr_cgi_url/ReportForm.pl\">Compose new TR</A></CENTER></TD></TR></TABLE></TD></TR>\n";
        }
        elsif ($bott_lnk =~ "ViewAll") {
                $bott_lnk =~ s/^ViewAll\+//ig;
                print "<TR><TD COLSPAN=6><TABLE WIDTH=\"100%\" CELLPADDING=0 BORDER=0><TR><TD COLSPAN=5 bgcolor=\"#ffffff\"><CENTER><A HREF=\"$tr_cgi_url/ViewTRTree.pl?$bott_lnk\">View all TR's</A></CENTER></TD>\n</TR></TABLE></TD></TR>\n";
        }
        print "</TABLE>\n\n";

        # Print the colormap table.
        print "<CENTER><BR>\n";
        print "\t<TABLE BORDER=1 WIDTH=\"200\">\n";
        print "\t<TR><TD BGCOLOR=\"#CCCCCC\" ALIGN=CENTER><B>Color</B></TD><TD WIDTH=\"50%\" ALIGN=CENTER bgcolor=\"#CCCCCC\"><B>Prioroty</B></TD></TR>\n";
        foreach $prio (@prio_avail) {
                print "\t<TR><TD BGCOLOR=\"$PRIO_COLOR{$prio}\">&nbsp\;</TD><TD WIDTH=\"50%\" ALIGN=CENTER bgcolor=\"#ffffff\"><FONT COLOR=\"$PRIO_COLOR{$prio}\"><U>$prio</U></FONT></TD></TR>\n";
        }
        print "\t</TABLE>\n</CENTER>\n<BR>\n";
}

# Recursivly print a node in the TR thread.
sub printNode {
        my ($basefile, $viewfile, $dont_href, $color, $finish_on, @pics) = @_;
        my ($pic);
        my ($next, @next);
        my ($pair, $name, $value);
        my (%FILECONT);
        my (%PREVFILE);
        my (@file, $file);
        my ($day, $month);
        my (@arg, $arg);
        my ($prev_next);
        my (@img_to_next);
        my ($trash, @trash);

        # Take out the file contens.
        %FILECONT = split2Hash("###", getFileCont("$viewfile"));
        (@next) = split("###", $FILECONT{'next'});

        if ($FILECONT{'prev'}) {
                %PREVFILE = split2Hash("###", getFileCont("$FILECONT{'prev'}"));
                # Remove last file in the next list.
                @trash = split("###", $PREVFILE{'next'});
                pop(@trash);
                $prev_next = join("###", @trash);
        }

        ###############
        # Fix the @pics_to_next
        @img_to_next = @pics;

        # Manage @pics
        if (!($FILECONT{'prev'})) { # 17
                push (@pics, "m.gif");
        }
        elsif ($next[0] && $FILECONT{'prev'}) { # 19
                # Current is not the last in thread.
                if ($prev_next =~ m/$viewfile/i) {
                        push (@pics, "t.gif");
                }
                else {
                        push (@pics, "l.gif");
                }

                push (@pics, "m.gif");
                if ($prev_next =~ m/$viewfile/i) {
                        push (@img_to_next, "i.gif");
                }
                else {
                        push (@img_to_next, "trans.gif");
                }
        }
        elsif ($next[0] eq "" && $FILECONT{'prev'} ne "" && $prev_next =~ m/$viewfile/i) { # 21
                push (@pics, "t.gif", "c.gif");
        }
        elsif (!($next[0])) { # 23, 22
                push (@pics, "l.gif", "c.gif");
        }

        # Done
        ###############

        # Get date and time.
        (undef, undef, $day, $month, undef) = split(/\./, $FILECONT{'date'});

        # Get the args for the HREF.
        @arg = split(/\//, $viewfile);
        $arg = pop(@arg);
        $arg = join("+", $basefile, pop(@arg), $arg);

        # Start print table row.
        print "<TR bgcolor=$color><TD CELLSPACING=0 CELLPADDING=0 nowrap>";
        print "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 bgcolor=$color><TR><TD>";

        foreach $pic (@pics) {
                if ($pic eq "trans.gif") {
                        print "<IMG SRC=\"$baseurl$picdir/$pic\" WIDTH=12 HEIGHT=1>";
                }
                else {
                        print "<IMG SRC=\"$baseurl$picdir/$pic\">";
                }
        }

        # Dont HREF if viewfile =~ dont_href
        if ($viewfile =~ $dont_href) {
                print "</TD><TD bgcolor=$color><FONT FACE=\"$fixed_font\">&nbsp\;&nbsp\;&nbsp\;<B>$FILECONT{'header'}</B></FONT></TD></TR></TABLE></TD>\n";
        } else {
                print "</TD><TD bgcolor=$color><FONT FACE=\"$fixed_font\">&nbsp\;&nbsp\;&nbsp\;<A HREF=\"$tr_cgi_url/ViewTR.pl?$arg\" STYLE=\"color: $PRIO_COLOR{$FILECONT{'prio'}}\">$FILECONT{'header'}</A></FONT></TD></TR></TABLE></TD>\n";
        }

        print "<TD bgcolor=$color CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$FILECONT{'block'}</FONT></TD>\n";
        print "<TD bgcolor=$color CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$FILECONT{'release'}</FONT></TD>\n";

        print "<TD bgcolor=$color CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$FILECONT{'reporter'}</FONT></TD>\n";
        print "<TD bgcolor=$color CELLSPACING=0 CELLPADDING=0 nowrap><FONT FACE=\"$fixed_font\">$day&nbsp\;$month</FONT></TD>\n";
        if ($finish_on eq "FinishOn" && !($FILECONT{'prev'})) {
                print "<TD bgcolor=$color CELLSPACING=0 CELLPADDING=0 nowrap ALIGN=center><INPUT TYPE=checkbox NAME=\"basefiles\" VALUE=$basefile>&nbsp\;</TD>\n";
        } elsif ($finish_on eq "FinishOn" && $FILECONT{'prev'}) {
                print "<TD bgcolor=$color CELLSPACING=0 CELLPADDING=0 nowrap>&nbsp\;</TD>\n";
        }
        print "</TR>\n\n";

        foreach $next (@next) {
                printNode($basefile, $next, $dont_href, $color, $finish_on, @img_to_next);
        }
}

# Done									#
#########################################################################
# Prints out the HTML header    					#

sub printHeader {
        my ($header) = @_;
        my (@file, $row, $folder);
        my (@folders) = ("Active TR's", "TR Archive", "My Active TR's");

        printStdHeader();
        # The output is a result of a search.
        if ($header eq "Search results") {
                print "<H1 STYLE=\"color: white;\">$header</H1>";
                return;
        }

        print "\n\n<TABLE WIDTH=\"100%\" BORDER=0 BGCOLOR=\"#FFFFFF\" CELLSPACING=0 CELLPADDING=0>\n<TR>\n";

        foreach $folder (@folders) {
                if ($folder eq $header) {
                        print "\t<TD WIDTH=\"150\" BGCOLOR=\"#000000\" STYLE=\"background-image:url(\'$baseurl/$picdir/flik_selected.gif\');background-repeat:no-repeat\" VALIGN=\"top\" nowrap>\n";
                        print "\t<IMG SRC=\"$baseurl/$picdir/trans.gif\" WIDTH=\"12\"><B>$folder</B>\n";
                } else {
                        my ($arg);
                        if ($folder eq "Active TR's") {$arg = "Issue"}
                        elsif ($folder eq "TR Archive") {$arg = "Archive"}
                        else {$arg = "ShowOnUser"}

                        print "\t<TD WIDTH=\"150\" BGCOLOR=\"#000000\" STYLE=\"background-image:url(\'$baseurl/$picdir/flik_unselected.gif\');background-repeat:no-repeat\" VALIGN=\"top\" nowrap>\n";
                        print "\t<IMG SRC=\"$baseurl/$picdir/trans.gif\" WIDTH=\"12\"><A HREF=\"$treeviewscript_url?$arg\" STYLE=\"color: \#000000\";text-decoration: bold;>$folder</A>\n";
                }
                print "\t</TD>\n\n";
        }

        print "\t<TD WIDTH=\"100%\" BGCOLOR=\"#000000\">\n";
        print "\t&nbsp;\n";
        print "\t</TD>\n";

        print "</TR>\n";

        print "<TR>";
        print "<TD COLSPAN=4><BR>\n\n";


}

# Done									#
#########################################################################
# Prints out the HTML footer.    					#

sub printFooter {
        print "</TD></TR></TABLE>\n\n";
        printStdFooter();
}

# Done									#
#########################################################################
