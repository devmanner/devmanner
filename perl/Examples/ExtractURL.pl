#!/usr/local/bin/perl
#########################################################################
# Script name: ExtractURL.pl 0.1					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

$string = "Detta �r en Str�ng och i denna kommer nu en url. http://www.tocow.net Denna skall g�ras om till l�nk.";

# Done									#
#########################################################################

#$string =~ s/\s[a-z���A-Z���]/X/g; # Hittar alla tecken som f�ljer ett mellanslag.

#$string =~ s/\s([a-z���A-Z���])/[A-Z���]/ig;

$string =~ s/(http\:\/\/[^ ]*)/\<A HREF=\"$1\"\>$1\<\/A\>/;


print "$string\n";



