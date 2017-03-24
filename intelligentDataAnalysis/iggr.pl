#!/opt/local/bin/perl

use strict;
use warnings;
use autodie;
use Switch;

my @array;
my $lines=0;

#File is opened here and the data is dumped into a 2D array, line by line (each attribute value is separated by tab)
open FILE, "<", "zoo.tab" or die $!;
while(<FILE>) {
    chomp($_);
    my @line=split(/\t/,$_);
    push(@array,\@line);
    $lines++;
}

#classes0 is to calculate the Information Gain of each attribute before the split
my @classes0=(["mammal","fish","bird","invertebrate","amphibian","insect","reptile"],[0,0,0,0,0,0,0]);
for(my $j=3; $j<$lines; $j++) {
    switch($array[$j][17])
    {
        case /mammal/ { $classes0[1][0]+=1 }
        case /fish/ { $classes0[1][1]+=1 }
        case /bird/ { $classes0[1][2]+=1 }
        case /invertebrate/ { $classes0[1][3]+=1 }
        case /amphibian/ { $classes0[1][4]+=1 }
        case /insect/ { $classes0[1][5]+=1 }
        case /reptile/ { $classes0[1][6]+=1 }
        else {print "idiot!"; exit; }
    }
}
my $infogain0=0;
my $sum0=0;
for(my $k=0; $k<=6; $k++) {
    $sum0+=$classes0[1][$k];
}
for(my $k=0; $k<=6; $k++) {
    $infogain0+=(-1)*($classes0[1][$k]/$sum0)*(log($classes0[1][$k]/$sum0)/log(10));
}
print "\n\nInfo gain before split:",$infogain0;

#classes1 is to calculate the weight of a given attribute when it is 0 (zero)
#classes2 is to calculate the weight of a given attribute when it is 1 (one)

for(my $i=1; $i<scalar(@{$array[3]})-1; $i++) {
    next if $i==13;
    my @classes1=(["mammal","fish","bird","invertebrate","amphibian","insect","reptile"],[0,0,0,0,0,0,0]);
    my @classes2=(["mammal","fish","bird","invertebrate","amphibian","insect","reptile"],[0,0,0,0,0,0,0]);
    my $count_0=0;
    my $count_1=0;
    for(my $j=3; $j<$lines; $j++) {
        if($array[$j][$i]==0) {
            $count_0++;
			switch($array[$j][17]) 
			{
				case /mammal/ { $classes1[1][0]+=1 }
				case /fish/ { $classes1[1][1]+=1 }
                case /bird/ { $classes1[1][2]+=1 }
                case /invertebrate/ { $classes1[1][3]+=1 }
                case /amphibian/ { $classes1[1][4]+=1 }
                case /insect/ { $classes1[1][5]+=1 }
                case /reptile/ { $classes1[1][6]+=1 }
                else {print "idiot!"; exit; }
            }
		}
		if($array[$j][$i]==1) {
            $count_1++;
            switch ($array[$j][17])
			{
                case /mammal/ { $classes2[1][0]+=1 }
                case /fish/ { $classes2[1][1]+=1 }
                case /bird/ { $classes2[1][2]+=1 }
                case /invertebrate/ { $classes2[1][3]+=1 }
                case /amphibian/ { $classes2[1][4]+=1 }
                case /insect/ { $classes2[1][5]+=1 }
                case /reptile/ { $classes2[1][6]+=1 }
                else {print "idiot!"; exit; }
			}
		}
	}
	my $sum_0=0;
	my $sum_1=0;
    for(my $k=0; $k<=6; $k++) {
		$sum_0+=$classes1[1][$k]; #total # of occurances of each class, when an attribute value is 0
		$sum_1+=$classes2[1][$k]; #total # of occurances of each class, when an attribute value is 1
	}
    
    #though these variables are named as infogain_0 and infogain_1, they are actually used to store entropy!
    #calculating weighted entropy in the following loop
	my $infogain_0=0;
	my $infogain_1=0;
    for(my $k=0; $k<=6; $k++) { #calculating entropy here. As computers cant' define log0, I had to have four conditions as follows.
        if($classes1[1][$k]!=0 && $classes2[1][$k]!=0) {
            $infogain_0+=(-1)*($classes1[1][$k]/$sum_0)*(log($classes1[1][$k]/$sum_0)/log(10));
			$infogain_1+=(-1)*($classes2[1][$k]/$sum_1)*(log($classes2[1][$k]/$sum_1)/log(10));
		}
		elsif($classes1[1][$k]==0 && $classes2[1][$k]!=0) {
            $infogain_0+=(-1)*0;
			$infogain_1+=(-1)*($classes2[1][$k]/$sum_1)*(log($classes2[1][$k]/$sum_1)/log(10));
		}
		elsif($classes1[1][$k]!=0 && $classes2[1][$k]==0) {
            $infogain_0+=(-1)*($classes1[1][$k]/$sum_0)*(log($classes1[1][$k]/$sum_0)/log(10));
			$infogain_1+=(-1)*0;
        }
		else {
			$infogain_0+=(-1)*0;
			$infogain_1+=(-1)*0;
		}
	}
    
    #infogain is expected information and infogain0 is information before split for the given attribute
	my $infogain=(($sum_0/($sum_0+$sum_1))*$infogain_0)+(($sum_1/($sum_0+$sum_1))*$infogain_1);
    print "\n\nAttribute: ",$array[0][$i],"\n";
    
    #Actual Information gain is the difference of Information before and after split
	print "Information gain: ",$infogain0-$infogain,"\n";
    my $gainratio=0;
    my $splitinfo=0;
    
    #splitinfo variable is used to store intrinsic information and gainratio to store the actual gain ratio!
    $splitinfo=(-1)*($count_0/($count_0+$count_1))*(log(($count_0/($count_0+$count_1)))/log(10))+(-1)*($count_1/($count_0+$count_1))*(log(($count_1/($count_0+$count_1)))/log(10));
    $gainratio=($infogain0-$infogain)/$splitinfo;
    print "Gain Ratio: ",$gainratio,"\n";
}
close FILE;
