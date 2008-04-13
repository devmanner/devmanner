#!/usr/local/bin/perl -w
#########################################################################
# Script name: signUp.pl v0.1 beta					#
# Written by: Tomas Mannerstedt tomasm@linux.nu         		#
# First version released: 01-06-01					#
# Comments: This script is used to take care of information from a form #
# and save it in a normal text file. Number of fields and fieldnames    #
# are fully optional. The only compulsory field is the "fields" field.  #
# It is supposed to contain the names af all the fields that shall      #
# contain something. It is recommended that you use a hidden field for  #
# this. If a field is named email it will be checked so that it         #
# contains a valid email adress.                                        #
#########################################################################
# Set strict mode.							#

use strict;

# Done									#
#########################################################################
# Define vareables							#
# The database file where the information is stored.                    #
my $dbfile = "/home/qtxtman/Perl/anmalan/list.db";
# The url to the form.html fiel.                                        #
my $allowed_referer = "";

# Done									#
#########################################################################
# Declare vareables.							#

my (%FORM);
my ($key, @dbfile, $row);

# Done									#
#########################################################################
# Main program.								#

if ($ENV{'HTTP_REFERER'} ne $allowed_referer)
        {expError("Du har anmalan kommer inte fran ratt formular.");}

pharseForm();
@dbfile = getFileCont("$dbfile");

foreach $row (@dbfile) {
        if ($row =~ /$FORM{'email'}/) {expError("Verkar som om du anmalt dig forr! Du kan endast anmala en persom per e-mail adress.\n\n")}
}

$row = "";
foreach $key (sort keys(%FORM)) {
        $row = "$row#$key = $FORM{$key}";
}

push (@dbfile, "$row\n");

open (FILE, ">$dbfile") || expError("Cannot open $dbfile in main::getFileCont()");
foreach $row (@dbfile) {
        print FILE "$row";
}
close FILE;

returnHTML();
exit 0;

# Done									#
#########################################################################
# Return HTML                                                           #

sub returnHTML {
        print "Content-type: text/html\n\n";
        print "Tackar!!!\n<BR>Du ar anmald med foljande uppgifter:<BR><BR>\n\n";
        foreach $key (sort keys(%FORM)) {
                print "$key = $FORM{$key}<BR>\n";
        }
}

# Done									#
#########################################################################
# Get input and fix all the strange signs in the header and problem	#
# fields. Do not allow SSI. If user tries to print HTML-tags, they are  #
# exchanged to &lt; and &gt;.                   			#

sub pharseForm {
	my ($buffer, @pairs, $pair, $name, $value, @fields, $field);
	read (STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
$buffer = "name=Tomas+Mannerstedt&email=a\@x.nu&dryck=vin&mat=fisk&allergi=&fields=name+email+dryck+mat";
	@pairs = split(/&/, $buffer);
	foreach $pair (@pairs) {
                $pair =~ s/\#/ /g;
		($name, $value) = split(/=/, $pair);
                if (!($name =~ /[a-z]*/)) {expError("Felaktigt formularfalt!")}
		$value =~ s/\+/ /g;
		$FORM{$name} = $value;
		$FORM{$name} =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$FORM{$name} =~ s/<!--(.|\n)*-->//g;
	}

        # Chech if emailadress is valid. {1,}@.+\..{2,}
        if ($FORM{'email'}) {
                if (!($FORM{'email'} =~ m/.+\@.+\..{2,}/)) {
                        expError ("Konstig emailadress du har. Du far nog forsoka igen...\n\n");}
        }

        @fields = split(/\ /, $FORM{'fields'});
        foreach $field (@fields) {
                if (!($FORM{$field}) || !($FORM{'fields'})) {expError("Du fyllde inte i formularet ordentligt. Faltet $field glomdes.\n\n");}
        }
        delete $FORM{'fields'};
}

# Done									#
#########################################################################
# Returns filecont of $file.    					#

sub getFileCont {
        my ($file) = @_;
        my (@file);
        open (FILE, "$file") || expError("Cannot open $file in main::getFileCont()");
        @file = <FILE>;
        close FILE;
        return @file;
}

# Done									#
#########################################################################
# Error handling routine.           					#

sub expError {
	my ($errmsg) = @_;
	print "Content-type: text/html\n\n";
	print $errmsg;
	exit 1;
}

# Done									#
#########################################################################
