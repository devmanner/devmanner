#!/usr/local/bin/perl -w
#########################################################################
# Script name: ReportTR.pl 2.1.2          				#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-05-30					#
# Comments: This script takes the information from the forms used for	#
# reporting troubles and adds it to the databases. The databases are	#
# created under $issue_dir. As they change status to finish they are	#
# moved to $arch_dir. If not all fields are filled out the script will	#
# die.                                                                  #
# If the $sendmail flag = 1:                                            #
#       *       If the report is the first in a thread mail will be     #
#               sent to the responsible person. If the error is         #
#               reported on unknown block mail will be sen to           #
#               $mail_to_unknown (all or a specific user)               #
#       *       If the report is a follow up email will be sent to the  #
#               reporter of the previous report. If the report has      #
#               changed block an email will be sent to the responsible  #
#               person of the new block.                                #
#       *       Email will always be sent to $always_email.             #
#                                                                       #
#########################################################################
# Set strict mode.							#

use strict;
use vc_tr;
use vars qw($issue_dir $arch_dir $data $tr_cgi_url $vc_ini $sendmail $email_domain $mail_to_unknown $always_email);

# Done									#
#########################################################################
# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#
my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Declare vareables.							#

my ($datestring, $key, $followup, $id);
$followup = 0;
my %FORM =();
my (%COOKIE) = getCookie();

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Main program.								#

$datestring = getDateAndTime();
pharseForm();

# Check if chang cookie.
if ($FORM{'reporter'} ne $COOKIE{'uid'}) {
        print "Set-Cookie: uid=$FORM{'reporter'}; domain=avweb.etxb.ericsson.se;\n";
}
# Check if the $ARGV is legal.
if (!($ARGV[0] =~ m/^issue_[0-9]{1,14}\.db$/ || $ARGV[0] =~ m/^fu_issue_[0-9]{1,14}\.db$/ || $ARGV[0] eq "")) {
        expError("$ARGV[0] Illegal call!!!\n\n");
}
if ($ARGV[0] ne "") {
	$followup = $ARGV[0];
}

$id = getID();

printTRFile($id, $followup, $datestring, $issue_dir);

if ($sendmail) {
        sendMail2Resp($followup);
}

print "Location: $tr_cgi_url/ViewTRTree.pl\n\n";

exit 0;

# Done End of main.							#
#########################################################################
# Returns a new id number.						#

sub getID {
        my ($id);
        open (DATA, "<$data") || expError("Cannot open $data.");
	$id = <DATA>;
        close DATA;
        $id = ($id == 99999999999999) ? 1 : $id + 1;
        open (DATA, ">$data") || expError("Cannot open $data.");
        print DATA $id;
        close DATA;
        return $id;
}

# Done									#
#########################################################################
# Print info from $FORM and date and time to file. Returns name of the  #
# new file.                                                             #

sub printTRFile {
        # Print to the new file.
        my ($id, $followup, $date, $output_dir) = @_;
        my @file = ();
        my ($firstrow, $row);
        my $fname = ($followup) ? "$output_dir/fu_issue_$id.db" : "$output_dir/issue_$id.db";

        `touch $fname`;
        open (TRFILE, ">$fname") || expError("OU:$output_dir<BR>DATA: $data<BR>Cannot open $fname !\n\n");
	print TRFILE "next\n";
        if ($followup) {
        	print TRFILE "prev###$output_dir/$followup\n";
        }
        print TRFILE "date###$date\n";
        foreach $key(sort keys(%FORM)) {
        	print TRFILE "$key###$FORM{$key}\n";
        }
        close TRFILE;

        # Set up link if follow up.
        if ($followup) {
        	open (FILE, "<$output_dir/$followup") || expError ("Cannot open $output_dir/$followup\n\n");
		@file = <FILE>;
		close FILE;
        	$firstrow = shift(@file);
                chomp($firstrow);
                $firstrow = "$firstrow###$fname\n";
                unshift(@file, $firstrow);
		open (FILE, ">$output_dir/$followup") || expError ("Cannot open $output_dir/$followup\n\n");
                foreach $row (@file) {
                	print FILE "$row";
        	}
         	close FILE;
	}
        return $fname;
}


# Done									#
#########################################################################
# Get date n' time. Returns date and time.				#

sub getDateAndTime {
	my $retvalue = "";
	$retvalue = join(/ /, `/usr/bin/date '+\%T'`, `/usr/bin/date '+\%a'`, `/usr/bin/date '+\%e'`, `/usr/bin/date '+\%b'`, `/usr/bin/date '+\%Y'`);
	$retvalue =~ s/\n/\./g;
	return $retvalue;
}

# Done									#
#########################################################################
# Get input and fix all the strange signs in the header and problem	#
# fields. Do not allow SSI. Only allow 0-9 in @ARGV. If user tries to	#
# print HTML-tags, they are exchanged to &lt; and &gt;.			#

sub pharseForm {
	my ($buffer, @pairs, $pair, $name, $value);
	read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
#$buffer = "status=Issue&block=DPI&release=TRACO_R1A02&reporter=qtxnike&prio=Low&header=Fel&description=Describe problem here.";

	@pairs = split(/&/, $buffer);
	foreach $pair (@pairs) {
		($name, $value) = split(/=/, $pair);
		$value =~ s/\+/ /g;
		$FORM{$name} = $value;
		$FORM{$name} =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$FORM{$name} =~ s/<!--(.|\n)*-->//g;
	}

	# Replace < and > with its HTML tags.					#
        foreach $name (sort keys(%FORM)) {
                $FORM{$name} =~ s/</&lt\;/g;
	        $FORM{$name} =~ s/>/&gt\;/g;

        }

        # Replace newlines with <BR> and whitespace.				#
	$FORM{'description'} =~ s/\n/<BR>/g;
	$FORM{'description'} =~ s/\ /&nbsp\;/g;

        # Replace " with &quot;
	$FORM{'description'} =~ s/\"/&quot\;/g;
	$FORM{'header'} =~ s/\"/&quot\;/g;

	# Extract URL's								#
	$FORM{'description'} =~ s/(http\:\/\/[^ ]*)/\<A HREF=\"$1\" TARGET=\"\_top\"\>$1\<\/A\>/;

	if ($FORM{'block'} eq "Select a block from list" || $FORM{'release'} eq "Select a release from list" || $FORM{'reporter'} eq "" || $FORM{'header'} eq "" || $FORM{'description'} eq "")
		{expError("You must fill out all fields.\nBLOCK:$FORM{'block'}\nRELEASE:$FORM{'release'}\nREPORTER:$FORM{'reporter'}\nHEADER:$FORM{'header'}\nDESC:$FORM{'description'}");}
}

# Done									#
#########################################################################
# Return responsible person.           					#

sub getResp {
        my ($block) = @_;
        my ($row, @vc_ini, $resp_user, $resp_block, @resp_blocks, $responsible);
        my $startlook = 0;

        open (VCINI, "$vc_ini");
        @vc_ini = <VCINI>;
        close VCINI;

        foreach $row (@vc_ini) {
	        chomp($row);
		if ($row eq "[designname]")
       			{$startlook = 0;}

		if ($startlook == 1) {
			($resp_user, $resp_block) = split(/=/, $row);
        		@resp_blocks = split(";", $resp_block);
	        	foreach $resp_block (@resp_blocks) {
		        	if ($resp_block eq $block)
			        	{$responsible = $resp_user;}
                        }
                }
        	if ($row eq "[user]")
	        	{$startlook = 1;}
	}
        return $responsible;
}

# Done									#
#########################################################################
# Send mail                     					#

sub sendMail2Resp {
        my ($fu_file) = @_;
        my ($sendmailto, $user, @cc);
        push(@cc, $always_email);
        if (!($fu_file)) {
                my ($row, $resp_user, $resp_block, $resp_blocks, @resp_blocks, $startlook, @vc_ini, $user_block);

	        open (VCINI, "$vc_ini");
	        @vc_ini = <VCINI>;
	        close VCINI;

	        if ($FORM{'block'} eq "Unknown" && $mail_to_unknown eq "all") {
		        foreach $row (@vc_ini) {
			        chomp($row);
			        if ($row eq "[designname]")
        				{$startlook = 0;}
	        		if ($startlook == 1) {
		        		($resp_user, $resp_blocks) = split(/=/, $row);
			        	push(@cc, $resp_user);		# PUSH USER INTO CC (Carboned Copy)
        			}
	        		if ($row eq "[user]")
		        		{$startlook = 1;}
        		}
        	        $sendmailto = shift(@cc);
        	}

        	elsif ($FORM{'block'} eq "Unknown" && $mail_to_unknown =~ /\@/)
	        	{$sendmailto = $mail_to_unknown;}

	        else {
                        $sendmailto = getResp($FORM{'block'});
	        }

        	open (MAIL, "| /usr/lib/sendmail -t -oi") || expError("Sendmail???");
	        print MAIL "From: VeriCool TR System\n";
        	print MAIL "To: $sendmailto$email_domain\n";
	        if ($FORM{'block'} eq "Unknown") {
		        foreach $user (@cc)
			        {print MAIL "Cc: $user$email_domain\n";}
        	}

	        print MAIL "Subject: An error has been reported on block: $FORM{'block'}\n\n";
        	print MAIL "An error has been reported on block: $FORM{'block'} release: $FORM{'release'}\nThe TR header is: $FORM{'header'}\nVisit The VeriCool Website for details. URL is: http://avweb.etxb.ericsson.se/~pr-traco/VeriCool/\n\nDon't try to reply this mail. The mail is sent by the VeriCool system.\nForward if you don't agree that this is your responsibilety.";
        	close MAIL;
        }
        else {
                my (%PREVFILE);
                %PREVFILE = split2Hash("###", getFileCont("$issue_dir/$fu_file"));
                if ($PREVFILE{'block'} ne $FORM{'block'}) {
                        push(@cc, getResp($FORM{'block'}));
                }
                else {
                        $sendmailto = $PREVFILE{'reporter'};
                }

                open (MAIL, "| /usr/lib/sendmail -t -oi") || expError("Sendmail???");
	        print MAIL "From: VeriCool TR System\n";
        	print MAIL "To: $sendmailto$email_domain\n";
	        foreach $user (@cc)
		        {print MAIL "Cc: $user$email_domain\n";}
                print MAIL "Subject: A follow up has been reported on a tr in the VeriCool TR system.\n\n";
        	print MAIL "A follow up has been been posted on block: $FORM{'block'} release: $FORM{'release'}by $FORM{'reporter'}\nThe TR header is: $FORM{'header'}\nVisit The VeriCool Website for details. URL is: http://avweb.etxb.ericsson.se/~pr-traco/VeriCool/\n\nDon't try to reply this mail. The mail is sent by the VeriCool system.\nForward if you don't agree that this is your responsibilety.";
        	close MAIL;
        }
}

# Done									#
#########################################################################
