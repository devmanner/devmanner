#!/usr/local/bin/perl
#########################################################################
# Script name: Login.pl 0.1.1 beta					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released: 01-06-01					#
# Comments: Pharses form and puts uid as a cookie. Redirects to the     #
# previous page.                                                        #
#########################################################################
# Set strict mode.							#

use strict;
use vc_tr;
use vars qw($tr_cgi_url);

# Done									#
#########################################################################
# Define vareables							#
# The file where the vareables for the VeriCool and TR scripts are	#
# stored.								#

my $varfile = "/home/htdocs/cgi-bin/Mustang/VeriCool/VeriCoolVareables.pl";

# Done									#
#########################################################################
# Declare vareables.							#

my (%LOGIN, %COOKIE);

# Done									#
#########################################################################
# Get the vareables.							#

do $varfile;

# Done									#
#########################################################################
# Main program.								#

if ($ENV{'REQUEST_METHOD'} eq "POST") {
        %LOGIN = pharseForm();
        if (!($LOGIN{'uid'} =~ m/[a-z]{6,8}/)) {
                expError("Illegal call: UID does not seem to exist.\n");}
        print "Set-Cookie: uid=$LOGIN{'uid'}; domain=avweb.etxb.ericsson.se;\n";

        %COOKIE = getCookie();
#        if (!($COOKIE{'uid'})) {
#                expError("It seems like your browser doesn't accept cookies. Please turn it on.<BR>$ENV{'HTTP_COOKIE'}\n");
#        }

        if (!$ENV{'HTTP_REFERER'}) {
                print "Location: $tr_cgi_url/ViewTRTree.pl?ShowOnUser\n\n";
        }
        print "Location: $ENV{'HTTP_REFERER'}\n\n";
} else {
        expError("Error in call to script: wrong method.\n\n")
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
        return (%FORM);
}

# Done									#
#########################################################################
