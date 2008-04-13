#!/usr/bin/perl

chomp($ARGV[0]);
$string = $ARGV[0];

$string =~ s/([b,c,d,f,g,h,j,k,l,m,n,p,q,r,s,t,v,x,y,z])/$1o$1/g;

print "$string\n";
