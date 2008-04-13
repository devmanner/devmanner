#!/usr/local/bin/perl
#########################################################################
# Script name: SendSMS.pl 0.1						#
# Written by: T Mannerstedt tmannerstedt@hotmail.com			#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

@mob_nums = ("0739415162", "0708887223");
$weatherurl = "http://www.smhi.se/weather/landvader/prognos15_7.htm";
$postaddr = "http://java3.scandinaviaonline.se/sms/servlets/SmsSenderServlet";

# Done									#
#########################################################################
# Initial seup.								#

$charleft = 10;
$weather = "";

# Thease rows are for the auto post.					#
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

# This is for getting the HTML file.					#
use LWP::Simple;

# Done									#
#########################################################################
# Get weather file.							#

$content = get($weatherurl) || die "Cannot open $weatherurl\n";

# Done									#
#########################################################################
# Get the text.								#

@file = split(/\n/, $content);

foreach $row (@file) {
	if ($header eq "found" && $row =~ "<td><font face=\"Verdana\" size=\"2\">" && $weather eq "") {
		($trash, $trash, $weather, @trash) = split(/>/, $row);
		($weather, @trash) = split(/</, $weather);
	}
	if ($row =~ "Östra Svealand") {
		$header ="found";
		($trash, $trash, $trash, $rubr, @trash) = split(/>/, $row);
		($rubr, @trash) = split(/</, $rubr);
	}
	if ($row =~ "<td align=\"center\"><strong><font face=\"Verdana\" size=\"1\">") {
		($trash, $trash, $trash, $datentime, @trash) = split(/>/, $row);
		($datentime, @trash) = split(/</, $datentime);
	}
}

# Done									#
#########################################################################
# Join the report with header n' stuff.					#

$weather = join(' ', $datentime, $rubr, $weather);

# Done									#
#########################################################################
# Split report if it's too long.					#

do {
	push(@weather, (substr $weather, 0, 135));
	$weather = substr $weather, 135;
} until ($weather eq "");

# Done									#
#########################################################################
# Send the SMS.								#

foreach $mob_num (@mob_nums) {
	foreach $weather (@weather) {
		$ua = LWP::UserAgent->new();
		my $req = POST "$postaddr", [ name => 'sms', nummer => $mob_num, text => $weather, kvar => $charleft, accept => 'true', B1 => 'skicka'];
		$content = $ua->request($req)->as_string;
	}
}

# Done									#
#########################################################################
# Just return something to avoid ErrMsg.				#

print "Content-type: text/html\n\n";
print "Weather sent to $mob_num\n";

# Done									#
#########################################################################
