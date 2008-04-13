#!/usr/local/bin/perl

use lib '/import/user4/mattem/lib/perl';
$progname   = "mtsms";
$version    = "0.22";
$date       = "2000-08-30";

# mtsms v0.22
# (c)  Mattias Mattsson <mattem@algonet.se>
# (and Torsten Freyhall <freyhall@algonet.se>)
# Distributed under the terms of the GPL
#
# mtsms sends messages non-interactivetly through MTN's web service.
#
# mtsms depends on HTML-Parser, URI, libwww-perl and CGI-Enurl which are 
# all available from CPAN.
#
# Usage:   mtsms -l login -p passwd -n number [-s signature] [-h server]
#                [-v] [-m message]
#
# Example: mtsms -l mattem@algonet.se -p xxxx -n +46705555555 -s mattias -m hello
#
# -h is for specifying an alternative server (eg www.eu.mtnsms.com)
# -v makes the script more verbose
# -s if not specified, the signature stored on your mtn account is used
#
# If no message is given on the command line it is taken from stdin. 
# Newlines are replaced by spaces and only the first (148 - (signature
# length)) chars are sent (this is because mtn place their own sig (12
# chars) at the end)
#
# BUGS
#
# Password is taken from commandline (can be seen with ps)
# Can probably not cope when the daily message quota is exceeded
# Sometimes non-existant error handling
# Ugly code
#
# HISTORY
#
# 0.20 (2000-07-24)
#   Initial release
#
# 0.21
#   Never released
#
# 0.22 (2000-07-30)
#   * _some_ error checking (reports wrong login or password)
#   * support for proxy servers
#   * various other small changes

# Set this if you have a proxy server, e.g. my.proxy.com:8001
$proxy = "";

# Defaults, command line overides
$server    = "www.mtnsms.com";
$login     = "";
$passwd    = "";
$number    = "";
$message   = "";
$dynasig   = "";

$smslength  = 160;
$sessionasp = "/session.asp";
$xsmsasp    = "/sms/xsms.asp";
$logoutasp  = "/logout.asp";
$mtnsiglen  = 12;

%error      = (203 => "Invalid login!", 204 => "Invalid password!");

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

if ($opt_s) { $dynasig = $opt_s; $sig = 1 } else { $sig = 0 }
if ($opt_h) { $server = $opt_h }
if ($opt_v) { $verbose = 1 }

if ($verbose) { print "$progname version $version ($date)\n" }

if (!($login && $passwd && $number)) {
  die "$progname: Usage: mtsms -l login -p passwd -n number [-s signature] [-h server] [-v] [-m message]\n";
}
if (!($login =~ m/@/)) { die "$progname: $error{203}\n" }

if ($opt_m) {
  $message = $opt_m;
} else {
  while (<STDIN>) {
    chomp;
    $message .= $_." ";
  }
  # remove trailing space chars
  $message =~ s/\s+$//;
}

$message = substr $message, 0, $smslength-($mtnsiglen+length($dynasig));

$ua = new LWP::UserAgent;
$ua->agent("$progname/$version");
if ($proxy) { ua->proxy("http://".$proxy."/") }
$cookie_jar = new HTTP::Cookies;

if ($verbose) { print "Connecting to $server... " }
$req = new HTTP::Request POST => "http://".$server.$sessionasp;
$req->content_type('application/x-www-form-urlencoded');
$req->content("username=$login&password=$passwd");
$res = $ua->request($req);

#error checking
if ($res->is_error) { die "\n$progname: Error connecting to $server: ".$res->status_line."\n" }
$server = $res->header('Location');
if ($errno = ($server =~ /err=(\d+)/)[0]) { die "\n$progname: $error{$errno} ($errno)\n"; }

$cookie_jar->extract_cookies($res);
if ($verbose) {print "$login logged in\n" }

#die $res->as_string;

# we get redirected to another server (www1, www2 etc..)
$server =~ s#^http://##;
$server =~ s#/.*$##;

#die $res->header('Location');

# follow the redirect
if ($res->is_redirect) {
  if ($verbose) { print "Following redirection... " }
  $req = new HTTP::Request GET => $res->header('Location');
  $cookie_jar->add_cookie_header($req);
  $res = $ua->request($req);
  if ($res->is_error) { die "\nError reading $xsms.asp: ".$res->status_line."\n" }
  $cookie_jar->extract_cookies($res);
  if ($verbose) { print "done\n" };
}

if ($verbose) { print "Sending message to $number (\"$message\" [$dynasig])... " }
$req = new HTTP::Request POST => "http://".$server.$xsmsasp;
$req->content_type('application/x-www-form-urlencoded');
$message = CGI::Enurl::enurl($message);
$req->content("smsToNumbers=$number&smsMessage=$message&smsSig=$sig&smsSigDyna=$dynasig");
$cookie_jar->add_cookie_header($req);
$res = $ua->request($req);
if ($res->is_error) { die "\n$progname: Error sending message to $number: ".$res->status_line."\n" }
$cookie_jar->extract_cookies($res);
if ($verbose) { print "done\n" }

if ($verbose) { print "Logging off... " }
$req = new HTTP::Request GET => "http://".$server.$logoutasp;
$cookie_jar->add_cookie_header($req);
$res = $ua->request($req);
if ($res->is_error) { die "\n$progname: Error logging off $login: ".$res->status_line."\n" }
$cookie_jar->extract_cookies($res);
if ($verbose) { print "$login logged off\n" }
