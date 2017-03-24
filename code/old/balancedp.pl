#!/opt/local/bin/perl
if(scalar @ARGV <1)
{
	print "bang!";
	print "\nCommand Usage:";
	print "\n\tperl <Script_File_Name> <Input_File_Name>";
	exit;
}
$inputfile=@ARGV[0];
open FILE, $inputfile or die $!;
my @linesoffile= <FILE>;
chomp($linesoffile[0]);
for($count1=1;$count1<=$linesoffile[0];$count1++)
{
    chomp($linesoffile[$count1]);
    print $linesoffile[$count1];
    if(($linesoffile[$count1])=~/\:/)
    {
        print "YES\n";
    }
}
close FILE;