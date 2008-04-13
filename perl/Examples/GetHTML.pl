#!/usr/local/bin/perl

#$url = "http://www.smhi.se/weather/landvader/prognos15_7.htm";

$url = "http://avweb.etxb.ericsson.se/~qtxtman/prognos15_7.htm";
$weather = "";

use LWP::Simple;



$content = get($url);

@file = split(/\n/, $content);

foreach $row (@file) {
	if ($header eq "found" && $row =~ "<td><font face=\"Verdana\" size=\"2\">" && $weather eq "") {
		($trash, $trash, $weather, @trash) = split(/>/, $row);
		($weather, @trash) = split(/</, $weather);
	}
	if ($row =~ "Östra Svealand")
		{$header ="found";}
}








print $weather;
