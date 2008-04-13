#!/usr/local/bin/perl -w
#########################################################################
# Script name: GenIssueForm.pl 0.1					#
# Written by: Tomas Mannerstedt qtxtman@etxb.ericsson.se		#
# First version released:						#
# Comments:								#
#########################################################################
# Define vareables							#

$stockrow = "<tr><td><font face=\"Arial,Helvetica\" size=2><a href=\"../new/ftg.phtml?51\">Ericsson B</a>     </td><td align=right><font color=\"blue\"><font face=\"Arial,Helvetica\" size=2>  +1,5</td><td align=right><font color=\"blue\"><font face=\"Arial,Helvetica\" size=2>0.8</td><td align=right><font face=\"Arial,Helvetica\" size=2>   182</td><td align=right><font face=\"Arial,Helvetica\" size=2>   182</td><td align=right><font face=\"Arial,Helvetica\" size=2>   182</td><td align=right><font face=\"Arial,Helvetica\" size=2>   184</td><td align=right><font face=\"Arial,Helvetica\" size=2>   180</td><td align=right><font face=\"Arial,Helvetica\" size=2>16107369</td></font>";

# Done									#
#########################################################################

print "$stockrow\n\n";

#$stockrow =~ s/<.*?>/\#/g;
$stockrow =~ s/<.*?>/ /g;

print "$stockrow\n\n";


@stockrow = split(/\s{2,}/, $stockrow);


foreach $item (@stockrow)
	{print "$item\n";}
