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
	my ($top, $code) = @_;
	my $DIR;
	$code->($top);
	if (-d $top) {
		my $file;
		unless (opendir $DIR, $top) {
			warn "Couldn’t open directory $top: $!; skipping.\n";
			return;
		}
	
		while ($file = readdir $DIR) {
			next if $file eq '.' || $file eq '..';
			dir_walk("$top/$file", $code);
		}
	}
}

# print(total_size("C:/Dev/Proj/recursion"));
dir_walk("C:/Dev/Proj/recursion", sub {print $_[0], "\n";})


# hanoi(N, start, end, extra)
# Solve Tower of Hanoi problem for a tower of N disks,
# of which the largest is disk #N. Move the entire tower from
# peg 'start' to peg 'end', using peg 'extra' as a work space

sub hanoi{
	my ($n, $start, $end, $extra) = @_;
	if($n==1){
		print "Move disk #1 from $start to $end. \n";
	} else {
		hanoi($n-1, $start, $extra, $end);
		print "Move disk #$n from $start to $end. \n";		
		hanoi($n-1, $extra, $end, $start);
	}
}

hanoi(3, 'A', 'C', 'B');