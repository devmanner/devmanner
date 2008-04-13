#!/usr/local/bin/perl -w

use strict;


my $file =  "denna skall fas";
my $prev_next = "denna skall fas";# fram och lite mera text!!!";

if ($prev_next =~ $file) {
        print "$file\nfinns i strangen\n$prev_next\n\n";
}