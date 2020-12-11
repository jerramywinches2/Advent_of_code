#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day10_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle;

my @sorted_list = sort {$a <=> $b} @lines;
my $highest_jolts = $sorted_list[-1] + 3;
my $diff1 = 0;
my $diff3 = 0;
my $index = 0;
while($index < @sorted_list) {
    my $current = $sorted_list[$index];
    my $next = $sorted_list[$index + 1];
    if(($index + 1) == @sorted_list) {
        $next = $highest_jolts;
    }
    if($next - $current == 1) {
        if($index == 0) {
            $diff1++;
        }
        $diff1++;
    } elsif($next - $current == 3) {
        if($index == 0) {
            $diff3 ++;
        }
        $diff3++;
    }
    $index++;
}

print "Part 1 answer: " . ($diff1 * $diff3) . "\n";



