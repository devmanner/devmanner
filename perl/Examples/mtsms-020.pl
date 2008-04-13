#!/usr/bin/perl

# mtsms v0.20
# (c)  Mattias Mattsson <mattem@algonet.se>
# (and Torsten Freyhall <freyhall@algonet.se>)
# Distributed under the terms of the GPL
#
# mtsms sends messages non-interactivetly through MTN's web service.
#
# mtsms depends on HTML-Parser, URI, libwww-perl and CGI-Enurl which are all available
# from CPAN.
#
# Usage:   mtsms -l login -p passwd -n number [-s signature] [-h server] [-v] [-m message]
#
# Example: mtsms -l mattem@algonet.se -p xxxx -n +46705555555 -s mattias -m hello
#
# -h is for specifying an alternative server (eg www.eu.mtnsms.com)
# -v makes the script more verbose
# -s if not specified, the signature stored on your mtn account is used
#
# If no message is given on the command line it is taken from stdin. Newlines are
# replaced by spaces and only the first (148 - (signature length)) chars are sent
# (this is because mtn place their own sig (12 chars) at the end)
#
# BUGS
#
# Password is taken from commandline (can be seen with ps)
# Can probably not cope when the daily message quota is exceeded
# Sometimes non-existant error handling
# Ugly code


# Defaults, command line overides
$server    = "www.mtnsms.com";
$login     = "";
$passwd    = "";
$number    = "";
$message   = "";
$dynasig   = "";

$sessionasp = "/session.asp";
$xsmsasp    = "/sms/xsms.asp";
$logoutasp  = "/logout.asp";
$mtnsiglen  = 12;

$version = "0.20";
use Getopt::Std;
use LWP::UserAgent;
use HTTP::Cookies;
use CGI::Enurl;
$| = 1;

getopts('l:p:n:s:h:m:v');
$login   = $opt_l;
$passwd  = $opt_p;
$number  = $opt_n;
$dynasig = $opt_s;

if (!($login && $passwd && $number)) {
  die "Usage: mtsms -l login -p passwd -n number [-s signature] [-h server] [-v] [-m message]\n";
}

if ($opt_s) { $dynasig = $opt_s; $sig = 1 } else { $sig = 0 }
if ($opt_h) { $server = $opt_h }
if ($opt_v) { $verbose = 1 }

if ($opt_m) {
  $message = $opt_m;
} else {
  while (<STDIN>) {
    chomp;
    $_ = $_." ";
    $message = $message.$_;
  }
  $message =~ s/ $//;
  $stdin = 1;
}

$message = substr $message, 0, 160-($mtnsiglen+length($dynasig));

$ua = new LWP::UserAgent;
$ua->agent("mtsms/$version");
$cookie_jar = new HTTP::Cookies;

if ($verbose) { print "Connecting to $server... " }
$req = new HTTP::Request POST => "http://".$server.$sessionasp;
$req->content_type('application/x-www-form-urlencoded');
$req->content("username=$login&password=$passwd");
$res = $ua->request($req);
if ($res->is_error) { die "\nError connecting to $server: ".$res->status_line."\n" }
$cookie_jar->extract_cookies($res);
if ($verbose) {print "$login logged in\n" }

#die $res->as_string;

# have to do this because the server get changed (www1, www2 etc..)
$server =  $res->header('Location');
$server =~ s/^http:\/\///;
$server =~ s/\/.*$//;

# don't care about the redirect received, always request xsms.asp
if ($verbose) { print "Requesting $xsmsasp... " }
$req = new HTTP::Request GET => $res->header('Location');
$cookie_jar->add_cookie_header($req);
$res = $ua->request($req);
if ($res->is_error) { die "\nError reading $xsms.asp: ".$res->status_line."\n" }
$cookie_jar->extract_cookies($res);
if ($verbose) { print "done\n" };

if ($verbose) { print "Sending message to $number (\"$message\" [$dynasig])... " }
$message = enurl($message);
$req = new HTTP::Request POST => "http://".$server.$xsmsasp;
$req->content_type('application/x-www-form-urlencoded');
$req->content("smsToNumbers=$number&smsMessage=$message&smsSig=$sig&smsSigDyna=$dynasig");
$cookie_jar->add_cookie_header($req);
$res = $ua->request($req);
if ($res->is_error) { die "\nError sending message to $number: ".$res->status_line."\n" }
$cookie_jar->extract_cookies($res);
if ($verbose) { print "done\n" }

if ($verbose) { print "Logging off... " }
$req = new HTTP::Request GET => "http://".$server.$logoutasp;
$cookie_jar->add_cookie_header($req);
$res = $ua->request($req);
if ($res->is_error) { die "\nError logging off $login: ".$res->status_line."\n" }
$cookie_jar->extract_cookies($res);
if ($verbose) { print "$login logged off\n" }
