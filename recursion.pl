# This is a script tool writen in perl.
sub total_size {
	my ($top) = @_;
	my $total = -s $top;
	my $DIR;

	return $total if -f $top;
	unless (opendir $DIR, $top) {
		warn "Couldn’t open directory $top: $!; skipping.\n";
		return $total;
	}

	my $file;
	while ($file = readdir $DIR) {
		next if $file eq '.' || $file eq '..';
		$total += total_size("$top/$file");
	}

	# closedir $DIR;
	return $total;
}

sub dir_walk {
	my ($top, $filefunc, $dirfunc) = @_;
	my $DIR;
	if (-d $top) {
		my $file;
		unless (opendir $DIR, $top) {
			warn "Couldn’t open directory $code: $!; skipping.\n";
			return;
		}
		my @results;
		while ($file = readdir $DIR) {
			next if $file eq '.' || $file eq '..';
			push @results, dir_walk("$top/$file", $filefunc, $dirfunc);
		}
		return $dirfunc->($top, @results);
	} else {
		return $filefunc->($top);
	}
}

sub file_size { -s $_[0] }
sub dir_size {
	my $dir = shift;
	my $total = -s $dir;
	my $n;
	for $n (@_) { $total += $n }
	return $total;
}
$total_size = dir_walk('.', \&file_size, \&dir_size);
print "Total size is: ".$total_size." bytes";

