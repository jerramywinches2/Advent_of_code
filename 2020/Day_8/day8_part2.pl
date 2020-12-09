 #!/usr/bin/perl
 use strict;
 use warnings;
 use Data::Dumper;

 my $path_to_input_file = "./day8_input.txt";

 open my $file_handle, '<', $path_to_input_file;
 chomp(my @lines = <$file_handle>);
 close $file_handle;

 #print Dumper(\@lines); 

my %lookup;
my $index = 0;
my $acc = 0;
my $result = -1;

while($index < @lines) {
    my $instruction = substr($lines[$index], 0, 3);
    my $value = substr($lines[$index], 4);

    # sort of deep clone so we can test with this array without altering 
    # the original
    my @data_new = map { $_ } @lines;

    if($instruction eq 'nop') {
        $data_new[$index] = "jmp $value";
    } elsif($instruction eq 'jmp') {
        $data_new[$index] = "nop $value";
    }

    $acc = 0;
    %lookup = ();
    $result = test(0, $acc, @data_new);
    if($result > 0) {
        last;
    }
    $index ++;
}

print "Part 2 answer: $result \n"; 
exit 1;

##########################################
## Functions

sub test {
    my ($i, $acc, @l) = @_;

    while($i < @l) {        
        if(defined $lookup{$i}) {
            return -1;
        }
        $lookup{$i} = 1;

        my $instruction = substr($l[$i], 0, 3);
        my $value = substr($l[$i], 4);

        if($instruction eq 'nop') {
            $i ++;
        } elsif($instruction eq 'jmp') {
            $i += $value;
        } elsif($instruction eq 'acc') {
            $i ++;
            $acc += $value
        } 
    }
    return $acc;
}


