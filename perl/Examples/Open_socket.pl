#!/usr/local/bin/perl -wT
#########################################################################
# Script name: OpenSocket.pl						#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

my $mob_nr = "+46739415162";

# Done									#
#########################################################################

use Socket;
sub OpenSocket;
sub GetPage;

unless ($ARGV[0] =~ m{http://(.*?)(/.*)})
	{die "Call program as $0 ".
	"http://server/document.\n"}

print GetPage $1, $2;

exit 0;

sub GetPage
{
	my ($server, $page) = @_;
	my ($text, $row) = "";

	if (OpenSocket($server, 80)) {
		select SOCKET; $| = 1; select STDOUT;
		print SOCKET "Get $page 1.1\n\n";
		$text.=$row while $row = <SOCKET>;
		close SOCKET;
		$text;
	}
	else {""}
}

sub OpenSocket
{
	my ($server_namn, $port) = @_;

	$port = getservbyname($port, 'tcp') if $port !~ /^[0-9]/;
	socket SOCKET, AF_INET, SOCK_STREAM, 0
		or die "socket: $!";
	connect (SOCKET, sockaddr_in($port, inet_aton($server_namn)));
}
