#!/opt/local/bin/perl
use strict;
use warnings;
use autodie;
use List::Util qw[min max];

my @array;

#File is opened here and the data is dumped into a 2D array, line by line (each attribute value is separated by tab)
open FILE, "<", "input.txt" or die $!;
while(<FILE>) {
    chomp($_);
    my @line=split(/\s/,$_);
    push(@array,\@line);
}
#!for(my $i=0;$i<2;$i++) {
#!    for(my $j=0;$j<($#{$array[1]}+1);$j++){
#!        print $array[$i][$j], " ";
#!    }
#!    print "\n";
#!}
my $sum=0;
print "Given points:\n";
for(my $i=0;$i<($#{$array[1]}+1);$i++) {
    my $min=0;
    print "(",$array[0][$i],",",$array[1][$i],") ";
    my $C1= (($array[0][$i]-(-0.8))**2)+(($array[1][$i]-(3.2))**2);
    my $C2= (($array[0][$i]-(2.1))**2)+(($array[1][$i]-(4.0))**2);
#!    print $C1," ",$C2,"\n";
    if($C1>$C2){
        $min=$C2;
    }
    else{
        $min=$C1;
    }
    $sum=$sum+$min;
}
print "\n\nSSE for K=2: ",$sum," with centres at (-0.8,3.2), (2.1,4.0)";
print "\n";
$sum=0;
for(my $i=0;$i<($#{$array[1]}+1);$i++) {
    my @C;
#!    print "(",$array[0][$i],",",$array[1][$i],") ";
    $C[0]= (($array[0][$i]-(1.9))**2)+(($array[1][$i]-(1.6))**2);
    $C[1]= (($array[0][$i]-(-2.3))**2)+(($array[1][$i]-(4.1))**2);
    $C[2]= (($array[0][$i]-(1.9))**2)+(($array[1][$i]-(4.4))**2);
    $sum=$sum+(min(@C));
}
print "SSE for K=3: ",$sum," with centres at (1.9,1.6), (-2.3,4.1), (1.9,4.4)";
print "\n";
$sum=0;
for(my $i=0;$i<($#{$array[1]}+1);$i++) {
    my @C;
    $C[0]= (($array[0][$i]-(-2.6))**2)+(($array[1][$i]-(4.3))**2);
    $C[1]= (($array[0][$i]-(1.7))**2)+(($array[1][$i]-(1.6))**2);
    $C[2]= (($array[0][$i]-(1.2))**2)+(($array[1][$i]-(3.5))**2);
    $C[3]= (($array[0][$i]-(2.6))**2)+(($array[1][$i]-(5.9))**2);
    $sum=$sum+(min(@C));
}
print "SSE for K=4: ",$sum," with centres at (-2.6,4.3), (1.7,1.6), (1.2,3.5), (2.6,5.9)";
print "\n";
$sum=0;
for(my $i=0;$i<($#{$array[1]}+1);$i++) {
    my @C;
    $C[0]= (($array[0][$i]-(-2.5))**2)+(($array[1][$i]-(4.5))**2);
    $C[1]= (($array[0][$i]-(-3.5))**2)+(($array[1][$i]-(1.3))**2);
    $C[2]= (($array[0][$i]-(1.9))**2)+(($array[1][$i]-(1.6))**2);
    $C[3]= (($array[0][$i]-(1.2))**2)+(($array[1][$i]-(3.5))**2);
    $C[4]= (($array[0][$i]-(2.6))**2)+(($array[1][$i]-(5.9))**2);
    $sum=$sum+(min(@C));
}
print "SSE for K=5: ",$sum," with centres at (-2.5,4.5), (-3.5,1.3), (1.9,1.6), (1.2,3.5), (2.6,5.9)";
print "\n";
close FILE;