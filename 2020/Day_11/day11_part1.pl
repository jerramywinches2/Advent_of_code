#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $path_to_input_file = "./day11_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

# Create double array of seats
my @seats;
foreach my $line (@lines) {
    my @row;
    foreach my $char (split //, $line) {
        push @row, $char; 
    }
    push @seats, \@row;
}

# While seats keep flipping
my $seat_changes = 1;
while($seat_changes > 0) {
    $seat_changes = 0;

    my @new_board;
    # occupy seats
    for(my $i = 0; $i < @seats; $i++) {
        my @row;
        for(my $z = 0; $z < @{$seats[$i]}; $z++) {
            my $char = $seats[$i][$z];
            if($char eq 'L') {
                my $cnt = checkSeatsToLeave($i, $z);
                if($cnt == 0) {
                    $seat_changes++;
                    $new_board[$i][$z] = '#';
                } else {
                    $new_board[$i][$z] = $char;
                }
            } else {
                $new_board[$i][$z] = $char;
            }
        }
    }

    @seats = map { $_ } @new_board;
    @new_board = ();
    # leave seats
    for(my $i = 0; $i < @seats; $i++) {
        for(my $z = 0; $z < @{$seats[$i]}; $z++) {
            my $char = $seats[$i][$z];
            if($char eq '#') {                
                my $cnt = checkSeatsToLeave($i, $z);
                if($cnt >= 4) {
                    $seat_changes++;
                    $new_board[$i][$z] = 'L';
                } else {
                    $new_board[$i][$z] = $char;
                }
            } else {
                $new_board[$i][$z] = $char;
            }
        }
    }
    @seats = map { $_ } @new_board;
}

# Count occupied seats
my $total_count = 0;
for(my $i = 0; $i < @seats; $i++) {
    for(my $z = 0; $z < @{$seats[$i]}; $z++) {
        my $char = $seats[$i][$z];
        if($char eq '#') {
            $total_count++;
        }

    }
}
 print "Part 1 answer:$total_count \n";
 exit 1;


###################################################################
## functions
sub checkSeatsToLeave {
    my ($row, $col) = @_;
    my $cnt = 0;
    for(my $i = ($row - 1 < 0? 0 : $row - 1); $i <= ($row >= @seats - 1? @seats - 1 : $row + 1); $i++) {
        for(my $z = ($col - 1 < 0? 0 : $col - 1); $z <= ($col >= @{$seats[0]} - 1? @{$seats[0]} - 1 : $col + 1); $z++) {
            if($i == $row && $z == $col) {
                next;
            }
            if($seats[$i][$z] eq '#') {
                $cnt++;
            }
        }
    }
    return $cnt;
}
