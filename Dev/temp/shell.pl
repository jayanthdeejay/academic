#!/usr/local/bin/perl
use File::ReadBackwards; #use Cwd;
use Switch;
#my $pwd=cwd();
open $FILE, '>>', '.hist' or die "Could not open file '$filename' $!"; #print "MyShell: ",$pwd,"# ";
print "osh> ";
do{
    $text=<>;
chomp($text); }while(!defined $text); chomp($text);
@command=split(/ /,$text); while($command[0] ne "exit") {
my $pid=fork();
if (!defined $pid) {
die "Cannot fork: $!"; }
elsif ($pid == 0) {
my $temp=join("",@command); chomp($temp);
if(!defined $temp){
exit; }
$fh = File::ReadBackwards->new('.hist') or die "can't read file: $!\n"; my $line;
my @hist;
my @last;
my $i=0;
while (defined($line = $fh->readline)){
chomp($line);
if( length($line)<1){
next; }
$hist[$i]=$line; $i++; #if($i==10){
# break;
#}
}
if($command[0] =~
    if(-z $FILE){
        print "No
exit; }
/^!!$/){
commands in history!\n";
$last[0]=$hist[0]; if($hist[0]=~ /history/){
goto HIST; }
chomp($last[0]); system(@last);
print $FILE $last[0]; print $FILE "\n";
if ($? == -1) {
print "failed to execute in !!: $!\n";
}
exit; }
elsif($command[0] =~ /^!/ && $command[0] =~ /[0-9]$/){ my $index=0;
switch(length($command[0])){ case 2 {
$command[0]=~ /(\d)/; if($1>=$i){
print "Invalid reference!\n";
exit; }
$last[0]=$hist[$i-$1]; if($last[0]=~ /history/){
goto HIST; }
chomp($last[0]);
13
system(@last);
print $FILE $last[0]; print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n"; }
exit; }
case 3 {
$command[0]=~ /(\d)(\d)/; $index=0+($1.$2); if($index>=$i){
print "Invalid reference!\n";
exit; }
$last[0]=$hist[$i-$index]; if($last[0]=~ /history/){
goto HIST; }
chomp($last[0]); system(@last);
print $FILE $last[0]; print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n";
}
exit; }
case 4 {
$command[0]=~ /(\d)(\d)(\d)/; $index=0+($1.$2.$3); if($index>=$i){
print "Invalid reference!\n";
exit; }
$last[0]=$hist[$i-$index]; if($last[0]=~ /history/){
goto HIST; }
chomp($last[0]); system(@last);
print $FILE $last[0]; print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n";
}
exit; }
case 5 {
$command[0]=~ /(\d)(\d)(\d)(\d)/; $index=0+($1.$2.$3.$4); if($index>=$i){
print "Invalid reference!\n";
exit; }
$last[0]=$hist[$i-$index]; if($last[0]=~ /history/){
goto HIST; }
chomp($last[0]); system(@last);
print $FILE $last[0]; print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n";
}
exit; }
case 6 {
$command[0]=~ /(\d)(\d)(\d)(\d)(\d)/; $index=0+($1.$2.$3.$4.$5); if($index>=$i){
print "Invalid reference!\n"; exit;
14
} $last[0]=$hist[$i-$index]; if($last[0]=~ /history/){
goto HIST; }
chomp($last[0]); system(@last);
print $FILE $last[0]; print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n";
}
exit; }
else {print "99999 commands only!\n"; exit; } }
}
elsif($command[0] eq "history"){
HIST: if(-z $FILE){
print "No commands in history!\n"; print $FILE $text;
print $FILE "\n";
exit;
} if($i<10){
for(my $j=0;$j<$i;$j++){
print $i-$j," ",$hist[$j],"\n";
} }
else{
for(my $j=0;$j<=9;$j++){
print $i-$j," ",$hist[$j],"\n"; }
}
if($text =~ /^!!$/){
print $FILE $last[0]; print $FILE "\n"; exit;
}
if($command[0] =~ /^!/ && $command[0] =~ /[0-9]$/){
print $FILE $last[0]; print $FILE "\n"; exit;
}
print $FILE $text; print $FILE "\n"; exit;
}
elsif($text =~ /&$/) {
$text=~ s/&//; @command=split(/ /,$text); exec(@command); $text=$text," &";
print $FILE $text;
print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n"; }
exit
} else {
system(@command); if($text =~ /^$/){
exit; }
print $FILE $text; print $FILE "\n";
if ($? == -1) {
print "failed to execute: $!\n"; }
exit; }
}
#elsif($text =~ /&$/ && $pid!=0){
15
#sleep 1;
#print "osh> ";
#do{
#$text=<>;
#$text=~ s/^\s+|\s+$//g; #chomp($text); #}while(!defined $text); #chomp($text); #@command=split(/ /,$text); #}
else{
waitpid (-1,0);
#print "MyShell: ",$pwd,"# "; print "osh> ";
        do{
            $text=<>;
$text=~ s/^\s+|\s+$//g;
chomp($text); }while(!defined $text); chomp($text);
if($text =~ /history/){
print $FILE $text;
            print $FILE "\n";
        }
@command=split(/ /,$text); }
}
close $FILE;

