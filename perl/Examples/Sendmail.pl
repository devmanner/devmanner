#!/usr/local/bin/perl

$FORM{'Block'} = "TB";
$vc_ini = "TRACO.ini";

$startlook = 0;

open (VCINI, "$vc_ini");
@vc_ini = <VCINI>;
close VCINI;

foreach $row (@vc_ini) {
	chomp($row);

	if ($row eq "[designname]")
		{$startlook = 0;}

	if ($startlook == 1) {
		($resp_user, $resp_blocks) = split(/=/, $row);
		@resp_blocks = split(/\;/, $resp_blocks);
		foreach $block (@resp_blocks) {
			if ($block eq $FORM{'Block'})
				{$sendmailto = $resp_user;$user_block = $block;}
		}
	}

	if ($row eq "[user]")
		{$startlook = 1;}
}

if ($sendmailto eq "" || $user_block eq "")
	{print "Error: Cannot find block or user\n";}

open (MAIL, "| /usr/lib/sendmail -t -oi") || die "Sendmail???";
print MAIL "To: $sendmailto\n";
print MAIL "Subject: An error has been reported on block: $user_block\n\n";
print MAIL "An error has been reported on block: $user_block\nVisit The VeriCool Website for details. URL is: http://avweb.etxb.ericsson.se/~pr-traco/VeriCool/";
close MAIL;


