#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day13_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

my @ids;
my $index = 0;
foreach my $id (split /,/, $lines[1]) {
    if($id ne 'x') {
        push @ids, {id => $id, offset => $index};
    }
    $index ++;
}

# From example input
# index 0;  
#        start at time 0
#        keep adding 7 in a loop until total + (offset 1) is a number devisiable by 13
#        ? total = 77
# index 1;
#        start at time 77
#        keep adding (7 * 13) in a loop until total + (offset 4) is a number devisable by 59
#        ? total = 350
# index 2;
#        start at time 350
#        keep adding (7 * 13 * 59) in a loop until total + (offset 6) is a number devisable by 31
#        ? total = 70147
# ....
#  answer is 1068781

my $tot = $ids[0];
for(my $i = 1; $i < @ids; $i++) {
    my $b = $ids[$i];
    my $total = $tot->{offset};
    while(($total + $b->{offset}) % $b->{id} != 0) {
        $total += $tot->{id};
    }
    $tot = {id => ($tot->{id} * $b->{id}), offset => $total };
}

print "Part 2 answer: $tot->{offset} \n";

