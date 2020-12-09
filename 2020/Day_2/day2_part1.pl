#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day2_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

my $number_of_fails = 0;

foreach my $line (@lines) {
    if($line =~ /(\d+)-(\d+)\s([a-z]):\s([a-z]+)/) {
        my $start_number = $1;
        my $end_number = $2;
        my $key = $3;
        my $test_str = $4;
        my $count = () = $test_str =~ /\Q$key/g;

        if($count >= $start_number && $count <= $end_number) {
            $number_of_fails ++;
        }
    }
}

print "The number of fails is: $number_of_fails \n";
