#!/usr/local/bin/perl -w
#########################################################################
# Module name: vc_tr.pm (VeriCool Trouble Report)                       #
# Version: 1.0                                                          #
# First Released: 01-07-27                                              #
# Description: This perl module contains all the shared functions used  #
# in the VeriCool TR sysrem.                                            #
#                                                                       #
# WARNING: No security check is done in any of the functions in this    #
# script. The responsibilety to check the variables relyes on the       #
# author of the calling script.                                         #
#                                                                       #
#########################################################################
# Function Defenitions:                                                 #
#########################################################################
# Global vareables                                                      #

# $header printed showd if the error routine shall print out the html   #
# header before the error message. Is set by printStdHeader().          #
my ($header_printed) = 0;

# $html_err shows if the error message shall be printed with html tags. #
# Must be set up by programmer. Default is to print error messages as   #
# html.                                                                 #
# Note: $html_err cannot be declared as my while "use vars qw" is used  #
# to import variable to other scripts.
$html_err = 1;

# Done                                                                  #
#########################################################################
# Print standard HTML header..						#

sub printStdHeader {
        my (@file, $row);
        print "Content-type: text/html\n\n";
        print "<HTML><HEAD>\n\n";
        @file = getFileCont("$menubarfile");
        foreach $row (@file) {
                print "$row";
        }
        print "\n</HEAD>\n\n<BODY BGCOLOR=\"#000000\" TEXT=\"#000000\" onLoad=\"init()\">\n<BR><BR>\n";
        $header_printed = 1;
}

# Done									#
#########################################################################
# Prints out the HTML footer.    					#

sub printStdFooter {
        print "</BODY></HTML>\n\n";
}

# Done									#
#########################################################################
# Get the Releases							#

sub getReleases{
        my ($release_dir)= @_;
        my $relfiles = `/usr/bin/ls -Fp $release_dir`;
        my (@relfiles) = split(/\n/, $relfiles);
        my ($file, @releases, $release);
        foreach $file (@relfiles) {
	        ($release, undef) = split(/\./, $file);
	        push(@releases, $release)
        }
        return (@releases);
}

# Done									#
#########################################################################
# Get the blocks from the @vc_ini array.				#

sub getBlocks {
        my (@vc_ini) = @_;
        my ($row, $printnow, $block, @blocks);
        foreach $row (@vc_ini) {
	        chomp($row);
        	if ($row eq "[user]")
        		{$printnow = 0;}

	        if ($printnow == 1) {
		        ($block, undef) = split(/=/, $row);
		        if ($block !~ m/#/)
			        {push(@blocks, $block);}
        	}
	        if ($row eq "[dir]")
		        {$printnow = 1;}
        }
        return (@blocks);
}

# Done									#
#########################################################################
# Returns an array of files matching the @filter filter. @filter may    #
# contain paths.                                                        #
# WARNING: The paths in @filters MUST be checked so it doesn't contain  #
# any ; or system commands. Otherwise this will be a SERIOUS security   #
# hole.                                                                 #

sub getFiles {
        my (@filters) = @_;
        my (@files, $files, $filter);
        chdir ("/");
        foreach $filter (@filters) {
                $files = `/bin/ls -1r $filter`;
                push (@files, split(/\n/, $files));
        }
        return @files;
}

# Done									#
#########################################################################
# Returns filecont of $file.    					#
# WARNING: The $file must be checked so that somebody isn't trying to   #
# hack the function.                                                    #

sub getFileCont {
        my ($file) = @_;
        my (@file);
        open (FILE, "$file") || expError("Cannot open $file");
        @file = <FILE>;
        close FILE;
        return @file;
}

# Done									#
#########################################################################
# Returns hash with data from @array.  					#

sub split2Hash {
        my ($delmitter, @array) = @_;
        my %HASH;
        my ($pair, $name, $value, @value);
        foreach $pair (@array) {
                chomp ($pair);
                ($name, @value) = split($delmitter, $pair);
                $value = join($delmitter, @value);
                if ($value) {
                        $HASH{$name} = $value;
                }
        }
        return (%HASH);
}

# Done									#
#########################################################################
# Print a hash to a file with the name $file useing $delmitter as       #
# delmitter.	                                        		#
# WARNING: The $file must be checkes so that no important file is       #
# overwritten.                                                          #

sub putHash2File {
        my ($file, $delmitter, %HASH) = @_;
        my ($key);
        open (FILE, ">$file") || expError("Cannot open $file");
        foreach $key (sort keys(%HASH)) {
                print FILE "$key$delmitter$HASH{$key}\n";
        }
        close FILE;
}

# Done									#
#########################################################################
# Returns hash with cookie.                                             #

sub getCookie {
        my (@pairs) = split(/\ /, $ENV{'HTTP_COOKIE'});
        my ($pair, $name, $value);
        my %COOKIE;
        foreach $pair (@pairs) {
                ($name, $value) = split(/=/, $pair);
                $COOKIE{$name} = $value;
        }
        return %COOKIE;
}

# Done									#
#########################################################################
# Error handling routine.						#

sub expError {
	my ($errmsg) = @_;
        if ($html_err) {
                if (!($header_printed)) {
                        printStdHeader();
                }
                print "<H1 STYLE=\"color:white\">Error</H1>\n";
                print "<P STYLE=\"color:white\">$errmsg</P>\n";
                print printStdFooter();
        } else {
                print $errmsg;
        }
	exit 1;
}

# Done									#
#########################################################################
# Return a true value.                                                  #

return 1;

# Done									#
#########################################################################
