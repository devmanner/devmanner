#!/usr/local/bin/perl -w

use strict;

rekursiv(10);

exit 0;


sub rekursiv {
        my $tal = shift(@_);
        print "$tal\n";
        if ($tal != 1)  {
                rekursiv($tal - 1);
        }
}