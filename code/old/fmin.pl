#!/opt/local/bin/perl
$n=46;
$k=18;
$a=7;
$b=11;
$c=9;
$r=46;
my @m;
$m[0]=$a;
print $m[0]," ";
for($i=1;$i<$k;$i++)
{
    $m[i]=($b*$m[i-1]+$c)%$r;
    print $m[i]," ";
}