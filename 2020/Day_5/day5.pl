#!/usr/bin/perl
 use strict;
 use warnings;
 use Data::Dumper;

 my $path_to_input_file = "./day5_input.txt";

 open my $file_handle, '<', $path_to_input_file;
 chomp(my @lines = <$file_handle>);
 close $file_handle;

my $max = 0;
my %seats;

foreach my $line (@lines) {
    my $row_min = 0;
    my $row_max = 127;
    my $col_min = 0;
    my $col_max = 7;

    foreach my $char (split //, $line) {
        if($char eq 'F') {
            $row_max = int(($row_max - $row_min) / 2) + $row_min;
        } elsif($char eq 'B') {
            $row_min = int(($row_max - $row_min) / 2) + $row_min + 1;
        } elsif($char eq 'R') {
            $col_min = int(($col_max - $col_min) / 2) + $col_min + 1;
        } elsif($char eq 'L') {
            $col_max = int(($col_max - $col_min) / 2) + $col_min;
        }
    }

    $seats{$row_min}{$col_min} = 1;
    my $final_value = ($row_min * 8) + $col_min;
    if($max < $final_value) {
        $max = $final_value;
    }
}

# Part 1
print "\nPart 1: Total highest value found:$max \n";

my $hash_ref = \%seats;
for(my $i = 0; $i <= 127; $i++) {
    for(my $c = 0; $c <= 7; $c++) {
        my $row = $i + "";
        my $col = $c + "";
        #print "row:$row " . Dumper($hash_ref->{$row}->{$col});
        if(!defined $hash_ref->{$row}->{$col} ) {
            # NOTE Look down through the output and you'll see the odd seat
            #      in the middle. Then just row * 8 + col to get the answer
            # Part 2: The seat could be row:7 col:4 
            # Part 2: The seat could be row:7 col:5
            # Part 2: The seat could be row:7 col:6 
            # Part 2: The seat could be row:92 col:7  <-- This one is the answer 
            # Part 2: The seat could be row:117 col:0 
            # Part 2: The seat could be row:117 col:1 
            # Part 2: The seat could be row:117 col:2
            print "Part 2: The seat could be row:$i col:$c \n";
        }
    }
}
