#!/usr/local/bin/perl -w

$basedir = "/home/qtxtman";


$dirs = `ls -F $basedir | grep \/`;

$dirs =~ s/home\///g;


