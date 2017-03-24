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
for($count1=1;$count1<$linesoffile[0];$count1++)
{
    chomp($linesoffiles[$count1]);
}

my @array;
@array=(['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
my $x=0,$y=0;
my $top=0;

for($count1=1;$count1<=$linesoffile[0];$count1++)
{
    @array=(['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    $string=lc($linesoffile[$count1]);
    for ($count2=0; $count2<length($string);$count2++)
    {
        $ch=substr($string, $count2, 1);
        if(ord($ch)>=97 and ord($ch)<=122)
        {
            $array[1][(ord($ch)-97)]+=1;
        }
    }
    my @array2;
    for($count2=0;$count2<27;$count2++)
    {
        $array2[$count2]=$array[1][$count2];
    }
    @array2 = sort { $b <=> $a } @array2;
    my $sum=0;
    for($count2=0,$count3=26;$count2<27,$count3>0;$count2++,$count3--)
    {
        $sum=$sum+($array2[$count2]*$count3);
    }
    print "Case #",$count1,": ",$sum;
    print "\n";
}

close FILE;