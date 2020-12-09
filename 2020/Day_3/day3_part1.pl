#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day3_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

my $number_of_trees_hit = 0;
my $pointer = 1;

foreach my $line (@lines) {
    my $length_of_line = length($line);
    my $virtual_pointer = remainder($pointer, $length_of_line);
    my $char = substr($line, $virtual_pointer - 1, 1);
    if($char eq '#') {
        $number_of_trees_hit++;
    }
    $pointer = $pointer + 3;
}

print "Number of trees hit is: $number_of_trees_hit \n";

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a % $b;
}
 
