#!/usr/bin/perl -w

$lnk = "Jag er en liten pojke som heter tomas mannerstedt och jag är snall.";
$old = $lnk;
$lnk =~ s/.{20}\s/$&\n/ig;
print "$old\n$lnk\n";
