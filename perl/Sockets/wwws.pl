#!/usr/bin/perl
use strict;
use IO::Socket;

my $host = 'localhost';
my $www_root = '/home/tomas/perl/Sockets/www_root';
my $four_o_four = '404.html';


my $port = (defined($ARGV[0])) ? $ARGV[0] : '7070';

my $main_sock = new IO::Socket::INET (LocalHost => $host, LocalPort => $port, Proto => 'tcp', Listen => 1, Reuse => 1) || die "Could not create socket: $!\n";

while (1) {
    print "Waiting for connection...\n";
    my $child_sock = $main_sock->accept();
    if ((my $child_pid = fork()) == 0) {
	handleReq($child_sock);
    }
    close($child_sock);
}
exit(0);

sub handleReq() {
    my $sock = shift(@_);
    my $str;
    my ($method, $fname) = (undef, undef);
    while(defined($str = <$sock>)) {
	print "Recieved: ".$str;
	if ($str =~ m/^(GET).*$/g) {
	    ($method, $fname, undef) = split(" ", $str);
	}
    }

    if (defined($fname)) {
	print $sock "".getFileCont($fname)."\n\n\n";
    } else {
	print getBadReqMess();
    }
    #print (defined($fname)) ? getFileCont($fname) : getBadReqMess();
    #print $sock (defined($fname)) ? getFileCont($fname) : getBadReqMess();

    close($sock);
    exit (0);
}

sub getFileCont() {
    my ($fname) = @_;
    print "fname: ".$www_root."".$fname."\n";
    open (FILE, "<$www_root$fname") || 
	die "Canot open!\n";
#	open (FILE, "$www_root$four_o_four") ||
#	    die "Bad request.\n";
    my @lines = <FILE>;
    close (FILE);
    print "File:\n".join("", @lines)."\nEnd\n";
    return (join("", @lines));
}

sub getBadReqMess() {
    return "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\"><HTML><HEAD><TITLE>400 Bad Request</TITLE></HEAD><BODY><H1>Bad Request</H1>Your browser sent a request that this server could not understand.<P><HR><ADDRESS>wwws 0.1 Server at ".$host." Port ".$port."</ADDRESS></BODY></HTML>";
}
