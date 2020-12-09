#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use List::MoreUtils qw( minmax );

my $path_to_input_file = "./day9_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle;

my $frame_size = 25;
my $min_index = 0;
my $max_index = $frame_size;
my @seq;

MAIN:
while($max_index < scalar(@lines) - 1) {
    my $next = $lines[$max_index];

    my %possible;
    for(my $i = $min_index; $i < $max_index; $i++) {
        for(my $z = ($min_index + 1); $z < $max_index; $z++) {
            my $sum = $lines[$i] + $lines[$z];
            $possible{$sum} = 1;
        }
    }
    # If we have found the broken number
    if(!defined $possible{$next}) {
        my $index = 0;
        while($index < $max_index) {
            my @rec;
            my $total = 0;
            my $i = $index;
            while($i < $max_index) {
                $total = $total + $lines[$i];
                push @rec, $lines[$i];
                if($total == $next) {
                    @seq = @rec;
                    # Break out of all while loops we have found the sequence of 
                    # numbers that sum to the broken number
                    last MAIN; 
                } elsif($total > $next) {
                    last; # Over the limit so break out of this while loop
                }
                $i ++;
            }
            $index ++;
        }
    }
    $min_index++;
    $max_index++;
}

my ($min, $max) = minmax @seq;
print "Part 2 answer:" . ($min + $max) . "\n";

