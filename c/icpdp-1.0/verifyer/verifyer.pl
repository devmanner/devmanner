#!/usr/bin/perl -w
####################################################################################
# Name: verifyer.pl                                                                #
# Description: Create a html page containing a table showing a messages fron a     #
# icpdp configuration file.                                                        #
# Author: Tomas Mannerstedt                                                        #
# Contact: tomasm@linux.nu                                                         #
####################################################################################
# Uses                                                                             #

use strict;

####################################################################################
# Functions                                                                        #

sub min(@) {
    return ($_[0] < $_[1]) ? $_[0] : $_[1];
}

sub manage_file($) {
    my ($fname) = shift();
    
    open (FILE, "<$fname") ||
	die("Cannot open $fname\n");
    
    printf("<html><body>\n\n");
    
    my ($row, $line_no) = (undef, 0);
    my $priniting_fields = 0;
    my ($last_start, $last_stop) = (0, 0);
    my $first_table = 1;
    my @row;
    my $printed_bytes = 1;
    while ($row = <FILE>) {
	++$line_no;
	chomp($row);
	$row =~ s/\#.*//g;
	# Something's left.
	if ($row ne "") {
	    #print STDERR "ROW: <$row>\n";
	    # A header row.
	    if ($row =~ m/^(QUESTION|ANSWER)/) {
		my ($qa, undef, $ac, $function) = split(/:+/, $row);
		$qa =~ s/\s//g;
		$ac =~ s/\s//g;
		$function =~ s/\s//g;
		if (!$first_table) {
		    printf("</table>");
		}
		$first_table = 0;
		printf("\n<h2>$qa :: AC: $ac ($function)</h2>\n\n");
		printf("<table border=1>\n\n<tr>\n<td>&nbsp;</td>\n");
		for (my $i = 7; $i >= 0; --$i) { printf("<th width=12%%>$i</th>\n"); }
		printf("</tr>\n\n");
		$printed_bytes = 1;
	    }
	    # A field row.
	    elsif ($row =~ m/^[0-9]+:[0-9]+-[0-9]+:[0-9]+/ ||
		   $row =~ m/^[0-9]+:[0-9]+/ ||
		   $row =~ m/^[0-9]+-[0-9]+/ ||
		   $row =~ m/^[0-9]+/ ) {

		my ($range, $name, $type, $value, @desc) = split(/\s+/, $row);
		my $desc = join(" ", @desc);

		# Check that the different parts of the row are valid.
		if (!defined($name)) { print STDERR "Field name is undefined on line: $line_no\n"; }
		if (!defined($type)) { print STDERR "Type is undefined on line: $line_no\n"; }
		if ($type ne "RAW_DATA" && $type ne "BIT" && $type ne "IP_ADDR" && $type ne "ASCII" && $type ne "EMPTY" &&
		    $type ne "INSTANCE_DATA" && $type ne "TUNNELED_SIZE" && $type ne "TUNNELED_DATA") {
		    printf STDERR "type: \"$type\" on line $line_no is unknown.\n";
		}
		if (!defined($value)) { print STDERR "value is undefined on line: $line_no\n"; }
		if (!defined($desc) && $type ne "EMPTY") { print STDERR "Unempty field lacks description on line: $line_no\n"; }

		# my $desc = join(" ", @desc);
		my ($startbit, $stopbit) = get_range($range);
		my $colspan;
		my $bgcolor = ($type eq "EMPTY") ? "\"#dddddd\"" : "\"#FFFFFF\"";


		# Skip multiple declaration of the same field.
		if ($stopbit != $last_stop) {

		    # If the row is of type TUNNELED_DATA, print it and break.
		    if ($type eq "TUNNELED_DATA") {
			printf("<tr>\n<td align=center><b>$printed_bytes</b></td>\n<td colspan=8 align=center bgcolor=$bgcolor>$name<br>...</td>\n</tr>\n");
		    }
		    # If it's in te beginning of a row and it's a bit.
		    if ($startbit == $stopbit && !($startbit % 8) ) {
			push(@row, "<td colspan=1 align=center bgcolor=$bgcolor>$name</td>\n");
			++$startbit;
		    }
		    
		    # If the last field ended in the middle if a row.
		    if (($last_stop+1) % 8 && $last_stop != 0) {
			$colspan = min(8-(($last_stop+1) % 8), $stopbit - $startbit + 1);
			push(@row, "<td colspan=$colspan align=center bgcolor=$bgcolor>$name</td>\n");
			$startbit += $colspan;
		    }
		    
		    # Is the row "finished" so we can print the pushed segments.
		    if (!($startbit % 8) && $startbit && $#row > 0) {
			my $n = $#row;
			printf("<tr>\n<td align=center><b>$printed_bytes</b></td>\n");
			++$printed_bytes;
			for (my $i = 0; $i <= $n; ++$i) {
			    printf("%s", pop(@row));
			}
			printf("</tr>\n\n");
		    }
		    
		    # Shall we continue?
		    if ($startbit+7 <= $stopbit) {
			my $rowspan = (($stopbit - $startbit) >> 3) + 1;
			printf("<tr>\n<td align=center><b>$printed_bytes</b></td>\n<td colspan=8 rowspan=%d valign=center align=center bgcolor=$bgcolor>$name</td>\n</tr>\n\n", $rowspan);
			++$printed_bytes;
			for (my $i = 1; $i < $rowspan; ++$i) {
			    printf("<tr>\n<td align=center><b>$printed_bytes</b></td>\n</tr>\n\n");
			    ++$printed_bytes;
			}
			$startbit += 8*$rowspan;
		    }
		    # Is there something left to print?
		    if ($startbit < $stopbit) {
			$colspan = $stopbit - $startbit + 1;
			push(@row, "<td colspan=$colspan align=center bgcolor=$bgcolor>$name</td>\n");
			$startbit += $colspan;
		    }
		    if ($startbit -1 != $stopbit && ($startbit != -1 && $stopbit != -1)) {
			print STDERR "THIS SHALL NEVER HAPPEN! startbit: $startbit, stopbit: $stopbit\n";;
		    }
		    
		    $last_stop = $stopbit;
		}
	    }
	    # An unknown row.
	    else {
		print STDERR "Unknown line on: $line_no: \"$row\"\n";
	    }
	}
    }

    printf("</table>\n</body></html>\n");
    close(FILE);
}

sub get_range($) {
    my ($range) = shift();
    # x:x-y:y
    if ($range =~ m/[0-9]+:[0-9]+-[0-9]+:[0-9]+$/ ) {
	my ($startbyte, $startbit, $stopbyte, $stopbit) = split (/:+|-+/, $range);
	#printf("<$startbyte> <$startbit> <$stopbyte> <$stopbit>\n");
	return (8*($startbyte-1)+$startbit, 8*($stopbyte-1)+$stopbit);
    }
    # x:y
    elsif ($range =~ m/^[0-9]+:[0-9]+$/) {
	my ($byte, $bit) = split(/:/, $range);
	return (8*($byte-1)+$bit, 8*($byte-1)+$bit);
    }
    # x-y
    elsif ($range =~ m/^[0-9]+-[0-9]+$/ ) {
	return (split(/-/, $range));
    }
    # x
    elsif ($range =~ m/^[0-9]+$/ ) {
	return ($range, $range);
    }
    # Invlid range.
    else {
	return (-1, -1);
    }
}

#                                                                                    #
######################################################################################
# main                                                                               #

if (!defined($ARGV[0])) {
    printf("usage: verifyer.pl conffile.conf\n");
    exit;
}

manage_file($ARGV[0]);

# Done                                                                               #
######################################################################################
