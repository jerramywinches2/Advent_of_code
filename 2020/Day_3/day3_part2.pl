#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day3_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

my @slopes = ([1,1], [3,1], [5, 1], [7,1], [1,2]);
my @answers;
my $total_number = 0;

foreach my $slope (@slopes) {
    my $right = @$slope[0];
    my $down = @$slope[1];

    my $answer = get_slope_value($right, $down);
    if($total_number == 0) {
        $total_number = $answer;
    } else {
        $total_number = $total_number * $answer;
    }
}

print "Total number: $total_number \n" ;
exit 1;


#####################################################
## Funtions
sub get_slope_value {
    my ($right, $down) = @_;
    my $pointer = 1;
    my $number_of_trees_hit = 0;

    for(my $i = 0; $i < scalar(@lines); $i = $i + $down) {
        my $line = $lines[$i];
        my $length_of_line = length($line);
        my $virtual_pointer = remainder($pointer, $length_of_line);
        my $char = substr($line, $virtual_pointer - 1, 1);

        if($char eq '#') {
            $number_of_trees_hit++;
        }

        $pointer = $pointer + $right;
    }
    return $number_of_trees_hit;
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a % $b;
} 
