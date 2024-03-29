#!/usr/local/bin/perl

@array = (59,3,9,4,6,5,1,7,1,6,1,7,5,4,7,1,7,1,6,1,4,2,5,2,5,1,1,1,5,1,9,7,1,6,1,8,1,3,1,1,1,3,1,1,1,4,1,3,1,5,5,4,7,1,6,1,8,1,3,1,2,1,1,1,2,1,3,7,9,1,3,7,1,7,1,6,1,4,1,3,1,3,1,3,1,5,1,9,1,3,7,1,8,6,5,1,7,1,3,1,5,1,4,5,4,59);

if ($array[0]) { # Convert array.
        foreach $i (@array) {
                print pack("C*", 60+$i);
        }
        print "\n";
} else { # Print table.
        for $i (0..255) {
                print "$i = ", pack("C*", $i);
                ($i % 2) ? print "\n" : print "\t\t";
        }
}