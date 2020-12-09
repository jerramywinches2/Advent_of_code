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
 my $third_value;


MAIN:
for(my $i = 0; $i < scalar(@lines) && !defined $first_value; $i ++) {
    my $fvalue = int($lines[$i]);
    for(my $k = 0; $k < scalar(@lines) && !defined $second_value; $k ++) {
        my $svalue = int($lines[$k]);
        for(my $z = 0; $z < scalar(@lines) && !defined $third_value; $z ++) {
            my $tvalue = int($lines[$z]);
            if($fvalue + $svalue + $tvalue == 2020) {
                $first_value = $fvalue;
                $second_value = $svalue;
                $third_value = $tvalue;
                last MAIN;
            }
        }
    }
}

 print "Part 2 answer:" . ($first_value * $second_value * $third_value) . "\n"; 
