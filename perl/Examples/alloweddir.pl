#!/usr/local/bin/perl -w

use File::Basename;

$file = "/home/qtxtman/Perl/../kalle.pl";
$alloweddir = "/home/qtxtman/";

$dir = dirname($file);

if ($dir !~ m/^$alloweddir.*/i || $dir =~ m/(\.\.)+/ ) {
        print "DIR: $dir\nALLOWED: $alloweddir\nIllegal directory\n";exit;
}
print "OK\n";
