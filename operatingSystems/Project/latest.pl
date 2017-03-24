#!/usr/local/bin/perl
use File::ReadBackwards;
use Cwd;
my $pwd=cwd();
open $FILE, '>>', '.hist' or die "Could not open file '$filename' $!";
#print "MyShell: ",$pwd,"# ";
print "osh> ";

do{
    $text=<>;
    chomp($text);
}while(!defined $text);
chomp($text);
@command=split(/ /,$text);
while($command[0] ne "exit") {
	my $pid=fork();	
	if (!defined $pid) {
		die "Cannot fork: $!";
	}
	elsif ($pid == 0) {
        my $temp=join("",@command);
        chomp($temp);
        if(!defined $temp){
            exit;
        }
        $fh = File::ReadBackwards->new('.hist') or die "can't read file: $!\n";
        my $line;
        my @hist;
        my @last;
        my $i=0;
        while (defined($line = $fh->readline)){
            chomp($line);
            if( length($line)<1){
                next;
            }
            $hist[$i]=$line;
            $i++;
            #if($i==10){
            #    break;
            #}
        }
        if($command[0] =~ /^!!$/){
            if(-z $FILE){
                print "No commands in history!\n";
                exit;
            }
            $last[0]=$hist[0];
            if($hist[0]=~ /history/){
                goto HIST;
            }
            chomp($last[0]);
            system(@last);
            print $FILE $last[0];
            print $FILE "\n";
            if ($? == -1) {
                print "failed to execute in !!: $!\n";
            }
            exit;
        }
        elsif($command[0] =~ /^!/ && $command[0] =~ /^![0-9]{1,2}$/ && $command[0] =~ /[0-9]$/){
            if(length($command[0])==3){
                if($i<10){
                    print "Invalid reference!\n";
                    exit;
                }
                $command[0]=~ /(\d)(\d)/;
                if($2==0){
                    $1=$1,"",$2;
                    $last[0]=$hist[$1];
                    chomp($last[0]);
                    system(@last);
                    print $FILE $last[0];
                    print $FILE "\n";
                    if ($? == -1) {
                        print "failed to execute: $!\n";
                    }
                    exit;
                }
                else{
                    print "Last 10 commands only!\n";
                    exit;
                }
            }
            if(length($command[0])==2){
                $command[0]=~ /(\d)/;
                if($1>=$i){
                    print "Invalid reference!\n";
                    exit;
                }
                $last[0]=$hist[$1];
                chomp($last[0]);
                system(@last);
                print $FILE $last[0];
                print $FILE "\n";
                if ($? == -1) {
                    print "failed to execute: $!\n";
                }
                exit;
            }
            else{
                exit;
            }
        }
		elsif($command[0] eq "history"){
        HIST: if(-z $FILE){
                print "No commands in history!\n";
                print $FILE $text;
                print $FILE "\n";
                exit;
            }
            if($i<10){
                for(my $j=0;$j<$i;$j++){
                    print $i-$j," ",$hist[$j],"\n";
                }
            }
            else{
                for(my $j=0;$j<=9;$j++){
                    print $i-$j," ",$hist[$j],"\n";
                }
            }
            print $FILE $text;
            print $FILE "\n";
            exit;
		}
        elsif($text =~ /&$/) {
            $text=~ s/&//;
            @command=split(/ /,$text);
            system(@command);
            $text=$text," &";
            print $FILE $text;
            print $FILE "\n";
            if ($? == -1) {
                print "failed to execute: $!\n";
            }
            exit
        }
		else {
			system(@command);
            if($text =~ /^$/){
                exit;
            }
            print $FILE $text;
            print $FILE "\n";
			if ($? == -1) {
                print "failed to execute: $!\n";
			}
			exit;
		}
	}
    #elsif($text =~ /&$/ && $pid!=0){
    #sleep 1;
    #print "osh> ";
    #do{
    #$text=<>;
    #$text=~ s/^\s+|\s+$//g;
    #chomp($text);
    #}while(!defined $text);
    #chomp($text);
    #@command=split(/ /,$text);
    #}
	else{
		waitpid (-1,0);
		#print "MyShell: ",$pwd,"# ";
		print "osh> ";
        do{
            $text=<>;
            $text=~ s/^\s+|\s+$//g;
            chomp($text);
        }while(!defined $text);
        chomp($text);
        if($text =~ /history/){
            print $FILE $text;
            print $FILE "\n";
        }
		@command=split(/ /,$text);
	}	
}
close $FILE;
