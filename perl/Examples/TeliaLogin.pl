#!/usr/bin/perl
#########################################################################
# Script name: telialogin.pl						#
# Written by: Tomas Mannerstedt tomasm@linux.nu			        #
# First version released: 01-11-20					#
# Comments:								#
#########################################################################
# Define vareables							#

$options = "telialogon.conf";
$loginpage = "http://login1.telia.com/sd/init/login";

# Done									#
#########################################################################
# Initial seup.								#

# Thease rows are for the auto post.					#
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use Strict;

# Main									#
#<table><tr><td>Mata in ditt användarnamn och lösenord nedan. Tryck sedan på "Logga in".<br />
#<form name="pwdenter" action="login" method="POST">
#<b>Användarnamn:</b><br />
#<input type="Text" size="18" name="username">
#<br /><b>Lösenord:</b><br />
#<input type="PASSWORD" size="10" name="password">
#<input type="SUBMIT" name="submitForm" value="Logga in">
#</form></td></tr></table>

my $ua = LWP::UserAgent->new();
my $req = POST "$loginpage", [ name => 'pwdenter', username => $$FILE{'uid'}, PASSWORD => $$FILE{'password'}, submitForm => 'Logga in'];
$content = $ua->request($req)->as_string;


# Done									#
#########################################################################
# Return message.                       				#

print "\n\n$content\n";

# Done									#
#########################################################################
