 #!/usr/bin/perl
 use strict;
 use warnings;
 use Data::Dumper;

 my $path_to_input_file = "./day1_input.txt";

 open my $file_handle, '<', $path_to_input_file;
 chomp(my @lines = <$file_handle>);
 close $file_handle;

 my $first_value;
 my $second_value;

MAIN:
for(my $i = 0; $i < scalar(@lines) && !defined $first_value; $i ++) {
    my $fvalue = int($lines[$i]);
    for(my $k = 0; $k < scalar(@lines) && !defined $second_value; $k ++) {
        my $svalue = int($lines[$k]);
        if($fvalue + $svalue == 2020) {
            $first_value = $fvalue;
            $second_value = $svalue;
            last MAIN;
        }
    }
}

 print "Part 1 answer:" . ($first_value * $second_value) . "\n";