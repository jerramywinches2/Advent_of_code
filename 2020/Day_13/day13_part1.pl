#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day13_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

my $leaving = $lines[0];
my @ids;
foreach my $char (split /,/, $lines[1]) {
    if($char ne 'x') {
        push @ids, $char;
    }
}
my $min_leaving = 9999999999;
my $answer;
foreach my $id (@ids) {
    my $mod = $leaving % $id;
    my $next = $id - $mod + $leaving;
    my $min = $next - $leaving;
    if($min_leaving > $min) {
        $min_leaving = $min;
        $answer = $id * $min_leaving;
    }
}

print "Part1 answer:$answer \n";

