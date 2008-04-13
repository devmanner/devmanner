#!/usr/local/bin/perl
#########################################################################
# Script name: SendSMS.pl 0.1						#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

$mob_num = @ARGV[0];
$message = @ARGV[1];
$postaddr = "http://java3.scandinaviaonline.se/sms/servlets/SmsSenderServlet";

print "$mob_num\n$message\n";

# Done									#
#########################################################################
# Initial seup.								#

$charleft = 10;

# Thease rows are for the auto post.					#
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

# Done									#
#########################################################################
# Send the SMS.								#

$ua = LWP::UserAgent->new();
my $req = POST "$postaddr", [ name => 'sms', nummer => $mob_num, text => $message, kvar => $charleft, accept => 'true', B1 => 'skicka'];
$content = $ua->request($req)->as_string;

print "SMS sent to: $mob_num\nThis was returned:\n$content\n";

# Done									#
#########################################################################
