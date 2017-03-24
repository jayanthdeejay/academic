use strict;
use warnings;
use autodie;  

open (my $fh, "<", "dataFile.txt");
my @file_array;
while (my $line = <$fh>) {
    chomp $line;
    my @line_array = split(/\s+/, $line);
    push (@file_array, \@line_array);
}
