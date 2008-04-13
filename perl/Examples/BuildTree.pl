#!/usr/local/bin/perl


$basedir = $ENV{QUERY_STRING};

chdir($basedir);
$files = `/bin/du`;

@files = split(/\n/, $files);
