#!/usr/local/bin/perl -w

use strict;
use vars qw($var $kalle);
my $dofile = "Dofile.pl";

do $dofile;
print "Detta �r fr�n Dofile.pl: $var\nKalle: $kalle\n";
