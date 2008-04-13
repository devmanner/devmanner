#!/usr/local/bin/perl


my $basedir = "/home/pr-traco/releases/releaseDir";


chdir($basedir);
$dirs = `/usr/bin/ls -Fp | grep '/'`;
@rel_dirs = split(/\n/, $dirs);



foreach $dir (@rel_dirs) {
	$dir =~ s/\///g;
	($release, $date, $time) = split(/\./, $dir);
	$revdirname = join('.', $date, $time, $release);
	push(@revdirnames, $revdirname);
}

@rel_dirs = ();
@sort_rel_dirs_rev = reverse(sort @revdirnames);

foreach $dir (@sort_rel_dirs_rev) {
	($date, $time, $release) = split(/\./, $dir);
	$rel_dir_name = join('.', $release, $date, $time);
	push(@rel_dirs, $rel_dir_name);
}



foreach $dir (@rel_dirs) {
	print "$dir\n";
}

