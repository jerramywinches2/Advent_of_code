 #!/usr/bin/perl
 use strict;
 use warnings;
 use Data::Dumper;

 my $path_to_input_file = "./day2_input.txt";

 open my $file_handle, '<', $path_to_input_file;
 chomp(my @lines = <$file_handle>);
 close $file_handle; 

 my $valid_passwords = 0;

 foreach my $line (@lines) {
     if($line =~ /(\d+)-(\d+)\s([a-z]):\s([a-z]+)/) {
        my $start_number = $1;
        my $end_number = $2;
        my $key = $3;
        my $test_str = $4;

        my $first_char = substr($test_str, $start_number - 1, 1);
        my $second_char = substr($test_str, $end_number - 1, 1);

        if(($key eq $first_char && $key ne $second_char) 
        || ($key ne $first_char && $key eq $second_char)) {
            $valid_passwords ++;
        }
     }
 }

 print "Valid passwords: $valid_passwords \n";

 