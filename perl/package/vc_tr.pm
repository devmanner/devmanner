#!/usr/local/bin/perl -w
use strict;


sub expError {
	my ($errmsg) = @_;
	print "Content-type: text/html\n\n";
	print $errmsg;
	exit 1;
}

1 # Return something.