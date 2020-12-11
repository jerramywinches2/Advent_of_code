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
                if($cnt == 0) { # must see no occupied seats around it then occupy
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
                if($cnt >= 5) {  # 5 or more occupied seats before flip
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
 print "Part 2 answer:$total_count \n";
 exit 1;


###################################################################
## functions
sub checkSeatsToLeave {
    my ($row, $col) = @_;
    my $cnt = 0;
 
    # North
    for(my $i = $row - 1; $i >= 0; $i--) {
        if($seats[$i][$col] eq 'L') {
            last;
        } elsif($seats[$i][$col] eq '#') { 
            $cnt++;
            last;
        }
    }

    # North East
    my $z = $col;
    for(my $i = $row - 1; $i >= 0; $i--) {
        if($z + 1 < @{$seats[0]}) {
            $z++;
        } else {
            last;
        }
        if($seats[$i][$z] eq 'L') {
            last;
        } elsif($seats[$i][$z] eq '#') { 
            $cnt++;
            last;
        }
    }

    # East
    for(my $i = $col + 1; $i < @{$seats[0]}; $i++) {
        if($seats[$row][$i] eq 'L') {
            last;
        } elsif($seats[$row][$i] eq '#') { 
            $cnt++;
            last;
        }
    }

    # South East
    $z = $col;
    for(my $i = $row + 1; $i < @seats; $i++) {
        if($z + 1 < @{$seats[0]}) {
            $z++;
        } else {
            last;
        }
        if($seats[$i][$z] eq 'L') {
            last;
        } elsif($seats[$i][$z] eq '#') { 
            $cnt++;
            last;
        }
    }

    # South
    for(my $i = $row + 1; $i < @seats; $i++) {
        if($seats[$i][$col] eq 'L') {
            last;
        } elsif($seats[$i][$col] eq '#') { 
            $cnt++;
            last;
        }
    }

    # South West
    $z = $col;
    for(my $i = $row + 1; $i < @seats; $i++) {
        if($z - 1 >=0 ) {
            $z--;
        } else {
            last;
        }
        if($seats[$i][$z] eq 'L') {
            last;
        } elsif($seats[$i][$z] eq '#') { 
            $cnt++;
            last;
        }
    }

    # West
    for(my $i = $col - 1; $i >= 0; $i--) {
        if($seats[$row][$i] eq 'L') {
            last;
        } elsif($seats[$row][$i] eq '#') { 
            $cnt++;
            last;
        }
    }

    # North West
    $z = $col;
    for(my $i = $row - 1; $i >= 0; $i--) {
        if($z - 1 >=0 ) {
            $z--;
        } else {
            last;
        }
        if($seats[$i][$z] eq 'L') {
            last;
        } elsif($seats[$i][$z] eq '#') { 
            $cnt++;
            last;
        }
    }
    return $cnt;
}
