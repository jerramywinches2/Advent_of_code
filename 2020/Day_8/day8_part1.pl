#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day8_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle;

my %lookup;
my $index = 0;
my $acc = 0;

while($index < @lines) {
    if(defined $lookup{$index}) {
        last;
    }
    $lookup{$index} = 1;

    my $instruction = substr($lines[$index], 0, 3);
    my $value = substr($lines[$index], 4);

    if($instruction eq 'nop') {
        $index ++;
    } elsif($instruction eq 'jmp') {
        $index += $value;
    } elsif($instruction eq 'acc') {
        $index ++;
        $acc += $value;
    }   
}

print "Part 1 answer: $acc \n";
