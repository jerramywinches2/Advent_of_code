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
            
            push @{$lookup{$color_bag}}, $child_color;

            if($child_color eq "shiny gold") {
                push @bags, $color_bag;
            }

            if(!exists($contains{$child_color})) {
                $contains{$child_color} = [];
            }
            push @{$contains{$child_color}}, $color_bag;
        }
    }
}

my $count = 0;
while (my $bag = pop(@bags)) {
    if(defined $done{$bag}) {
        next; #If we have already done this bag then skip
    } else {
        $done{$bag} = 1;
        $count++;

        foreach my $c (@{$contains{$bag}}){
            if ( defined($c) && !defined $done{$c}){
                push(@bags, $c);
            }
        }
   }
}

print("Part 1 answer:$count\n");



    
 