#!/opt/local/bin/perl
if(scalar @ARGV <1)
{
    print "bang!";
    print "\nCommand Usage:";
    print "\n\tperl <Script_File_Name> <Input_File_Name>\n";
    exit;
}
open FILE, $ARGV[0] or die $!;
my @list;
my $j=0;
while(<FILE>){
    if($tc==0){
        chomp($_);
        $tc=scalar($_);
    }
    else{
        chomp($_);
        $list[$j]=scalar($_);
        $j++;
    }
}
my @array;
for($j=0;$j<@list;$j++){
    @array= split("",$list[$j]);
    my $small=$array[0],$big=$array[0],$index=0;
    for($k=0;$k<@array;$k++){
        if($array[$k]>0 && $array[$k]<$small){
            $small=$array[$k];
            $index=$k;
        }
    }
    $small=$index;
    $index=0;
    for($k=0;$k<@array;$k++){
        if($array[$k]>$big){
            $big=$array[$k];
            $index=$k;
        }
    }
    print "Case #",($j+1),": ";
    $big=$index;
    my $temp=$array[$small];
    $array[$small]=$array[0];
    $array[0]=$temp;
    if(scalar(join("",@array))==0){
        print "0 ";
    }
    else{
        print join("",@array)," ";
    }
    $temp=$array[$small];
    $array[$small]=$array[0];
    $array[0]=$temp;
    $temp=$array[$big];
    $array[$big]=$array[0];
    $array[0]=$temp;
    if(scalar(join("",@array))==0){
        print "0\n";
    }
    else{
        print join("",@array),"\n";
    }
}