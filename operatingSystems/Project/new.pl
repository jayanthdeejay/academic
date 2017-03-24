my $id=<>;
chomp($id);
while($id ne "exit") {
	print $id;
	if($id =~ /^!/ && $id =~ /^![0-9]{1}/ && $id =~ /[0-9]$/){
		print "inside if";
		$id=~/(\d)/;
		print $1,"---";
	}
	print "\n";
	$id=<>;
	chomp($id);
}
