#!/usr/bin/perl -w

#$foo = 'V<!--lbuvrp1kf1ik6-->ia<!--dsfn-->g<!--2dixve39yb2-->ra ';
$foo = 'V<!--lbuvrp1kf1ik6-->ia<!--dsfn-->g<!--2dixve39yb2-->ra ';

#$foo =~ s/<!--\w*-->//g;
#print "$foo\n";

if ($foo =~ m/v(<!--\w*-->)*i(<!--\w*-->)*a(<!--\w*-->)*g(<!--\w*-->)*r(<!--\w*-->)*a/i ) {
    print "Match!\n";
} else {
    print "No match!\n";
}
