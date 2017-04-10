#!/usr/bin/perl
################################################################################
#
# Convert audacity output to plist
#
################################################################################

# Write plist header
printHeader();

# Read in file
open(IN,"<$ARGV[0]");
$file = <IN>;
close IN;

# Strip newlines
$file =~ s/\r/\n/g;
# print STDERR $file;

# Create key/value pairs
@lines = split /\n/,$file;
foreach $line (@lines) {
    ($start,$stop,$word) = split /\s+/,$line;
    #print STDERR ">...$start...$stop...$word...\n";
    print "<dict>
    <key>word</key><string>$word</string>
    <key>start</key><real>$start</real>
    <key>stop</key><real>$stop</real>
    </dict>
    ";
}

# Write plist footer
printFooter();


## Subroutines #################################################################

##------------------------------------------------------------------------------
sub printHeader {
    print '<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <array>'
    ;
}

##------------------------------------------------------------------------------
sub printFooter {
    print '
    </array>
    </plist>';
}
