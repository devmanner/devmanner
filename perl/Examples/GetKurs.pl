#!/usr/local/bin/perl -w

print "Content-type: text/html\n\n";

#########################################################################
# Script name: GetKurs.pl 0.1						#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

$search_url = "http://boers.di.se/sok/sok.phtml";
$output_file = "/import/user8/ri_da/public_html/cgi-bin/test2.pl";

# Done									#
#########################################################################
# Init setup.								#
# Thease rows are for the auto post.					#
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

foreach $arg (@ARGV)
	{push(@stocks, $arg);}

# Done									#
#########################################################################
# Post the stocks at di and get the course.				#

open (STOCKFILE, ">$output_file") || die "Cannot open $output_file !!!";
print STOCKFILE "\#\#\#Namn\#\#\#+/-\#\#\#%\#\#\#Köp\#\#\#Sälj\#\#\#Senast\#\#\#Högst\#\#\#Lägst\#\#\#Antal\n";
close STOCKFILE;


print "Detta kom ut<BR>\n";
print "*" x 20;
print "<BR>\n";

foreach $stock (@stocks) {
	$ua = LWP::UserAgent->new();
	my $req = POST "$search_url", [ what => "$stock", submit => 'Sök'];
	$content = $ua->request($req)->as_string;

	@content = split(/\n/, $content);
	foreach $row (@content) {
		if ($row =~ /$stock/i)
			{$stockrow = $row;}
	}

	$stockrow =~ s/<.*?>/ /g;
	@stockrow = split(/\s{2,}/, $stockrow);
	$stockrow = join('###', @stockrow);

	open (STOCKFILE, ">>$output_file") || die "Cannot open $output_file !!!";
	print STOCKFILE "$stockrow\n";
	close STOCKFILE;
}

print "<tt>\n";
print `cat $output_file`;
