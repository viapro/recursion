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

hanoi(7, 'A', 'C', 'B');

# carry on