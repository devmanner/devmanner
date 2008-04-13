#!/usr/local/bin/perl -w




use HTTP::Request::Common qw(POST);
use LWP::UserAgent;


$ua = LWP::UserAgent->new();
my $req = POST "http://lc5.law5.hotmail.passport.com/cgi-bin/dologin", [ login => 'tmannerstedt', domain => 'hotmail.com',passwd => 'juggler',enter => 'Sign in', sec => 'no', curmbox => 'ACTIVE', js => 'yes', _lang => '', beta => '', ishotmail => '1', id => '2', ct => '964695350'];

$content = $ua->request($req)->as_string;

print "Content-type: text/html\n\n";

print "Detta kom ut: $content\n";
