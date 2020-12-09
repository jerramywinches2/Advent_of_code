#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use Switch;

my $path_to_input_file = "./day4_input.txt";

open my $file_handle, '<', $path_to_input_file;
chomp(my @lines = <$file_handle>);
close $file_handle; 

# For reference
# --------------------
# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

my %passport_hash;
my @passport_types = ('byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid');
my $valid_passport_count = 0;

foreach my $line (@lines) {
    if($line eq '') {        
        my $is_valid_passport = 1;
        foreach my $type (@passport_types) {
            if(!defined $passport_hash{$type} || !$passport_hash{$type} ) {
                $is_valid_passport = 0;
            }
        }
        if($is_valid_passport) {
            $valid_passport_count++;
        }
        %passport_hash = ();
    } else {
        my @words = split / /, $line;

        foreach my $word_type (@words) {
            if($word_type =~ /([a-z][a-z][a-z]):([\w#]+)/) {
                my $type = $1;
                my $value = $2;

                # Part 1
                #$passport_hash{$type} = 1;

                # Part 2
                $passport_hash{$type} = validate_type($type, $value);
            }
        }   
    }
}

print "Valid passport count: $valid_passport_count \n";
exit 1;

#################################################
## Functions

sub validate_type {
    my ($type, $value) = @_;

    switch($type) {
        case "byr" {
            if(int($value) >= 1920 && int($value) <= 2002) {
                return 1;
            }
            return 0;
        }
        case 'iyr' {
            if(int($value) >= 2010 && int($value) <= 2020) {
                return 1;
            }
            return 0;
        }
        case 'eyr' {
            if(int($value) >= 2020 && int($value) <= 2030) {
                return 1;
            }
            return 0;
        }
        case 'hgt' {
            if($value =~ /([0-9]+)([a-z]+)/) {
                my $v = $1;
                my $units = $2;
                return 0 unless defined $v;
                if($units eq 'cm') {
                    if(int($v) >= 150 && int($v) <= 193) {
                        return 1;
                    }
                } elsif($units eq 'in') {
                    if(int($v) >= 59 && int($v) <= 76) {
                        return 1;
                    }
                } 
            }
            return 0;
        }
        case 'hcl' {
            if($value =~ /#[0-9a-f]{6}/) {
                return 1;
            }
            return 0;
        }
        case 'ecl' {
            if($value =~ /(brn|amb|blu|brn|gry|grn|hzl|oth)/) {
                return 1;
            }
            return 0;
        }
        case 'pid' {
            if($value =~ /^[0-9]{9}$/) {
                return 1;
            }
            return 0;
        }
        else {
            return 1;
        }        
    }
}