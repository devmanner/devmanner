#!/usr/local/bin/perl


$fname = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Archive/fu_issue_40.db###/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Archive/fu_issue_41.db";

$issue_dir = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Issue";
$arch_dir = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR2/Archive";

print "fname innan: $fname\n";
$fname =~ s/$arch_dir/$issue_dir/g;
print "fname efter: $fname\n";
