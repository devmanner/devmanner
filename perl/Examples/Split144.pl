#!/usr/local/bin/perl -w

$weather = "2000-08-01 kl 07:05 Östra Svealand Vind omkring väst. Under dagen växlande molnighet, i inlandet möjligen någon regnskur.";

#if (length $weather > 144) {
#	@weather[0] = substr $weather, 0, 135;
#	@weather[0] = join(' ', @weather[0], "FORTS->");
#	@weather[1] = substr $weather, 135;
#}
#else {@weather[0] = $weather;}

#print length $weather;
#print "\n";

do {
	push(@weather, (substr $weather, 0, 135));
	$weather = substr $weather, 135;

print "$weather\n";

} until ($weather eq "");


foreach $sms (@weather) {
	print length $sms;
	print "\n";
	print "SMS: $sms\n\n";
}
