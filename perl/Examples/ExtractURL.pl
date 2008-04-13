#!/usr/local/bin/perl
#########################################################################
# Script name: ExtractURL.pl 0.1					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

$string = "Detta är en Sträng och i denna kommer nu en url. http://www.tocow.net Denna skall göras om till länk.";

# Done									#
#########################################################################

#$string =~ s/\s[a-zåäöA-ZÅÄÖ]/X/g; # Hittar alla tecken som följer ett mellanslag.

#$string =~ s/\s([a-zåäöA-ZÅÄÖ])/[A-ZÅÄÖ]/ig;

$string =~ s/(http\:\/\/[^ ]*)/\<A HREF=\"$1\"\>$1\<\/A\>/;


print "$string\n";



