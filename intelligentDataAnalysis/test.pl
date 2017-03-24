my @txt;
$txt[0][0]="text1";
$txt[0][1]="text2";
$txt[0][2]="text3";

$txt[1][0]="text4";
$txt[1][1]="text5";
$txt[1][2]="text6";

print scalar @{$txt[1]}; 
for(my $i=0; $i<scalar(@{$txt[1]});$i++){
	print $i;
}
