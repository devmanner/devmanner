#!/usr/bin/perl -w

#if ($#ARGV < 0) {
#    print "Usage: scheduleGet.pl class <group> <fromweek> <toweek>\n";
#    exit(0);
#}

open (FILE, "<class_id_map.txt")
    || die "Cannot open class_id_map.txt\n";
@file = <FILE>;
close FILE;

foreach $row (@file) {
    chomp($row);
    ($key, $value) = split(/\t/, $row);
    $MAP{$key} = $value;
}

if (!defined($MAP{$ARGV[0]})) {
    die "Class: $ARGV[0] -> $MAP{$ARGV[0]} undef\n";
}

$exs = "lynx -dump http://schema/4DACTION/WebShowText/Class?id=".$MAP{$ARGV[0]}."&group=".$ARGV[1]."&fromWeek=".$ARGV[2]."&toWeek=".$ARGV[3]."&fromTime=480&toTime=1140&noOfDays=5";

$cont = `$exs`;
@cont = split(/\n/, $cont);

do {} while (($class = shift(@cont)) eq "");

print "Schema:\n$class\n";

foreach $row ( @cont) {
    chomp($row);
    if ($row eq "") {
	print "\n";
	$nw = 1;
    }
    elsif ($row =~ m/TimeEdit/ ) {
	exit(0);
    }
    elsif ($nw == 1) {
	$row =~ s/,//g;
	print join("\t", split(" ", $row))."\n";
	$nw = 0;
    }
    else {
	(undef, @row) = split(" ", $row);
	print "$row[0]\t$row[1]\t$row[2]\t$row[3]\n";
    }
}
