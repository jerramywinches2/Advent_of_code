#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day9_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle;

my $frame_size = 25;
my $min_index = 0;
my $max_index = $frame_size;

while($max_index < scalar(@lines) - 1) {
    my $next = $lines[$max_index];
    my %possible;
    for(my $i = $min_index; $i < $max_index; $i++) {
        for(my $z = ($min_index + 1); $z < $max_index; $z++) {
            my $sum = $lines[$i] + $lines[$z];
            $possible{$sum} = 1;
        }
    }
    if(!exists $possible{$next}) {
        print "Part 1 answer: $next \n";
        last;
    }
    $min_index++;
    $max_index++;
}

