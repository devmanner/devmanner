#!/usr/local/bin/perl -w

use strict;

my ($op) = '||';
my ($var1, $var2) = (1, 0);

print "VAR1: $var1\nVAR2 $var2\n\n";

eval(if ($var1 $op $var2))
{
        print "$var1 $op $var2 => OK\n"
}
