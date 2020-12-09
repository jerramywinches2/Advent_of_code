#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day7_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle;

 
my %lookup = ();
my %contains = ();
my @bags = ();
my %done;

foreach my $line (@lines) {
    my @words = split / bags contain /, $line;
    my $color_bag = $words[0];
    $lookup{$color_bag} = [];

    my @other_bags = split /, /, $words[1];
    foreach my $bag_line (@other_bags) {
        if($bag_line =~ /(\d+)\s([\w\s]+)\sbag[s]*[\.]*/) {
            my $number_of_bags = $1;
            my $child_color = $2;
            push @{$lookup{$color_bag}}, {
                count => $number_of_bags,
                color => $child_color
            };
        }
    }
}


my @queue = (['shiny gold', 1]);
my %bags_sum = ();

while ( my $bag = pop(@queue)) {
    my $color = $bag->[0];
    my $num = $bag->[1];

    my @bag_list = @{$lookup{$color}};
    foreach my $b (@bag_list) {
        push @queue, ([$b->{color}, $b->{count} * $num ]);
        $bags_sum{$color} += $b->{count} * $num;
    }
}

my $count = 0;
for my $key (keys %bags_sum) {
    $count += $bags_sum{$key};
}

print("Part 2 answer:$count\n");