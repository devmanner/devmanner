#!/usr/bin/perl


use LWP::Simple;

$url = "http://www.altavista.com";
$outfile = "temp.html";

$content = get($url) || die "Cannot open $weatherurl\n";

if ($temp ne $content) {
    # Files differ
    print "File changed\n";
}

open (OUTFILE, ">$outfile");
print OUTFILE $content;
close OUTFILE;

