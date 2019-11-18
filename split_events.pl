#!/usr/bin/perl
# This is a script to print StarTrek query results

my %tagval;
my $event;
my $file = shift @ARGV;

if ($file)
{
    open (FILE, $file) || die "CANNOT OPEN FILE - $file FOR READING - $!\n";
    while(<FILE>)
    {
        print "\n";
        if (/=>MT[A-Z]+:(.*)$/)
        {
            $event = $1;
        }
        elsif (/^MT[A-Z]+:(.*)$/)
        {
            $event = $1;
        }

        %tagval = split (":", "$event");

        print "\n".$tagval{"55"}.":\n";
        
        foreach my $k (sort {$a <=> $b} keys %tagval) {
            if (length $tagval{$k} > 0) {
                printf "%-6s: %s\n", $k, $tagval{$k};
            }
        }
    }
}
print "Done.\n";
