#!/usr/local/bin/perl/bin
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
for($count1=1;$count1<$linesoffile[0];$count1++)
{
    chomp($linesoffiles[$count1]);
}

my @array;
@array=(['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);


for($count1=0;$count1<2;$count1++)
{
    for($count2=0;$count2<27;$count2++)
    {
        print $array[$count1][$count2];
    }
    print "\n";
}
$ch=f;
if(ord($array[0][5])==ord($ch))
{
    print "working\n";
}