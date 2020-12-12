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
push @sorted_list, $highest_jolts;

my $total_count = 0;
my %unique_keys = ( 0 => 1 );

foreach my $value (@sorted_list) {
    # Look back in the hash to see if there is a link to the
    # current value we are looking at from the previous three
    # values that could have been before.
    my $first = $unique_keys{$value - 1};
    my $second = $unique_keys{$value - 2};
    my $third = $unique_keys{$value - 3};

    if(!defined $unique_keys{$value}) {
        $unique_keys{$value} = 0;
    }

    # If there is a link then add it 
    if(defined $first) {
        $unique_keys{$value} += $first;
    }
    if(defined $second) {
        $unique_keys{$value} += $second;
    }
    if(defined $third) {
        $unique_keys{$value} += $third;
    }

    $total_count = $unique_keys{$value};
}

print "Part 2 answer: $total_count\n";


