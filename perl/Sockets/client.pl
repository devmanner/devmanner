#!/usr/bin/perl -w
use IO::Socket;
my $sock = new IO::Socket::INET (
				 PeerAddr => 'localhost',
				 PeerPort => '7070',
				 Proto => 'tcp',
				 );
die "Could not create socket: $!\n" unless $sock;
print $sock "Hello there!\n";
close($sock);

