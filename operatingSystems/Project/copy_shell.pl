#!/usr/local/bin/perl
use File::ReadBackwards;
use Cwd;
my $pwd=cwd();
open $FILE, '>>', '.hist' or die "Could not open file '$filename' $!";
print $pwd,"# ";
#while(<FILE>) {
#    chomp($_);
#    my @line=split(/\t/,$_);
#    push(@array,\@line);
#    $lines++;
#}

$text=<>;
chomp($text);
@command=split(/ /,$text);
#if($command[0] ne "exit"){
#	if($command[0] ne "history"){
#		print $FILE $text;
#		print $FILE "\n";
#	}
#}
while($command[0] ne "exit") {
	my $pid=fork();	
	if (!defined $pid) {
		die "Cannot fork: $!";
	}
	elsif ($pid == 0) {
        $fh = File::ReadBackwards->new('.hist') or die "can't read file: $!\n";
        my $line;
        my @hist;
        my @last;
        my $i=0;
        while ( defined($line = $fh->readline)){
            chomp($line);
            $hist[$i]=$line;
            $i++;
            if($i==10){
                break;
            }
        }
        if($command[0] =~ /^!!$/){
            $last[0]=$hist[0];
            chomp($last[0]);
            system(@last);
            print $FILE $last[0];
            print $FILE "\n";
            exit;
        }
        elsif($command[0] =~ /^!/ && $command[0] =~ /^![0-9]{1,2}$/ && $command[0] =~ /[0-9]$/){
            if(length($command[0])==3){
                $command[0]=~ /(\d)(\d)/;
                if($2==0){
                    $1=$1,"",$2;
                    $last[0]=$hist[$1];
                    chomp($last[0]);
                    system(@last);
                    print $FILE $last[0];
                    print $FILE "\n";
                    exit;
                }
                else{
                    print "Last 10 commands only!\n";
                    exit;
                }
            }
            if(length($command[0])==2){
                $command[0]=~ /(\d)/;
                $last[0]=$hist[$1];
                chomp($last[0]);
                system(@last);
                print $FILE $last[0];
                print $FILE "\n";
                exit;
            }
            else{
                exit;
            }
        }
		elsif($command[0] eq "history"){
            #$text="tail -10 .hist";
            #@command=split(/ /,$text);
            #system(@command);
            for($i=9;$i>=0;$i--){
                print $i+1," ",$hist[$i],"\n";
            }
            print $FILE $text;
            print $FILE "\n";
            exit;
		}
		else {
			system(@command);
            print $FILE $text;
            print $FILE "\n";
			if ($? == -1) {
    				print "failed to execute: $!\n";
			}
			exit;
		}
	}
	else{
		waitpid (-1,0);
		print $pwd,"# ";
		$text=<>;
       		chomp($text);
		@command=split(/ /,$text);
        #if($command[0] ne "exit"){
        #	if($command[0] ne "history"){
        #print $FILE $text;
        #print $FILE "\n";
        #	}
        #}

	}	
}
close $FILE;
