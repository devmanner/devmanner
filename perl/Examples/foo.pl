#!/usr/bin/perl

$str = "aba";
if ($str =~ m/(a|b)+/i) {
    print "match\n";
} else {
    print "no match\n";
}
