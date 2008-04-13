#!/usr/local/bin/perl

$issue_dir = "/home/htdocs/cgi-bin/Mustang/VeriCool/TR/Issue";
$act_dir = $issue_dir;

$buffer = "Status=Issue&Block=ST&Release=&Prio=&ReportedBy=&SearchString=&Boolean=Or";

@pairs = split(/&/, $buffer);

foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	$value =~ s/\+/ /g;
	if ($value ne "") {				# THIS IF IS ADDED!!!!
		if ($FORM{$name} eq "") {
			$FORM{$name} = $value;
			if ($name ne "Boolean")		# THIS IF IS ADDED!!!!
				{push(@terms, $name)}	# THE PUSH IS ADDED
		}
		else
			{$FORM{$name} = join('$', $FORM{$name}, $value);}
	}
}

$dbfiles = `/usr/bin/ls -Fp $act_dir`;
@dbfiles = split(/\n/, $dbfiles);

#########################################################################

FILELOOP: foreach $file (@dbfiles) {
	open (DBFILE, "<$act_dir/$file") || die "Cannot open $act_dir/$file";	# REMOVE $act_dir, PATH IS INCLUDED IN REAL SCRIPT!!!
	@file = <DBFILE>;
	close DBFILE;

	$row = pop(@file);
	($FILE{'Status'}, $FILE{'Block'}, $FILE{'Release'}, $FILE{'ReportedBy'}, $FILE{'Prio'}, $trash, $trash, $trash, $trash, $trash, $FILE{'Header'}, $FILE{'Problem'}) = split(/###/, $row);

	if ($boolean eq "And") {
		foreach $term (@terms) {
print "TERM: $term\n";
			if ($FORM{$term} =~ $FILE{$term})
				{$INCLUDE{$file} = 'yes';}
			else
				{$INCLUDE{$file} = 'no';}
		}
	}
	elsif ($boolean eq "Or") {
		foreach $term (@terms) {
			if ($FORM{$term} =~ $FILE{$term})
				{$INCLUDE{$file} = 'yes';next FILELOOP;}
			else
				{$INCLUDE{$file} = 'no';}
		}
	}
}

foreach $file (%INCLUDE) {
	if ($INCLUDE{$file} eq 'yes')
		{push(@newfiles, $file);}
}

print "*" x 30;
print "\nBefore:\n";

foreach $file (@dbfiles){
	print "$file\n";
}

@dbfiles = @newfiles;

print "After: \n";

foreach $file (@dbfiles){
	print "$file\n";
}




