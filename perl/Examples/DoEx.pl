#!/usr/local/bin/perl -w

use strict;
use vars qw($var $kalle);
my $dofile = "Dofile.pl";

do $dofile;
print "Detta är från Dofile.pl: $var\nKalle: $kalle\n";
