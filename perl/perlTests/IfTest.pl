#!/usr/bin/perl

$namn = "tomas";
$in{'anvandare'} = "m TOMAS";

if ($in{'anvandare'} =~ m/^$namn$/ig ) {
    print "Rätt användare\n";
}
