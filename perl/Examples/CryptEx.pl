#!/usr/local/bin/perl

print "Ange user: ";
$user = <STDIN>;
chomp($user);
print "Ange password: ";
$passwd = <STDIN>;
chomp($passwd);
print "Ange salt: ";
$salt = <STDIN>;
chomp($salt);

$crypted = crypt $passwd, $salt;

print "\n$user:$crypted\n";
