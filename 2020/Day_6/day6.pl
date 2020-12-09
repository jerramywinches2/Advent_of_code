#!/usr/bin/perl
 use strict;
 use warnings;
 use Data::Dumper;

 my $path_to_input_file = "./day6_input.txt";

 open my $file_handle, '<', $path_to_input_file;
 chomp(my @lines = <$file_handle>);
 close $file_handle;

 my %unique_letters = ();
 my $total = 0;
 my $person = 0;

 foreach my $line (@lines) {
    if($line eq '') {
        my $group_cnt = keys %unique_letters;
        $total = $total + $group_cnt;
        %unique_letters = ();
        $person = 0;
    } else {
        my %new_hash = ();
        foreach my $char (split //, $line) {
            if($person == 0) {
                if(!defined $unique_letters{$char}) {
                    $unique_letters{$char} = 1;
                }
            } else {
                if(defined $unique_letters{$char}) {
                    $new_hash{$char} = 1;
                }
            }
        }
        if($person > 0) {
            %unique_letters = %new_hash;
        }
        $person++;
    }
 }

 print "Part 2 answer: $total \n"
