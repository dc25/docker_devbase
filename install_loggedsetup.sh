#! /bin/bash

cd

cat > logged_setup.sh << 'DONE'
#! /usr/bin/perl
use strict;
use warnings;
use File::Basename qw(fileparse);

my ($short_command, $unused_command_path) = fileparse($ARGV[0]);
my $toplevel = "$ENV{HOME}/setup_logs/$short_command";
system("mkdir -p $toplevel");

my $filename=`date +%Y-%m-%d__%H-%M-%S`;
chomp($filename);

print "STARTING @ARGV \n";
# run command, capture results.
# timing code thanks to : https://stackoverflow.com/a/17108388
my $Start = time();
`@ARGV > $toplevel/$filename 2>&1`;
my $res = $?;
my $End = time();
my $Diff = $End - $Start;
my $timemsg = "Elapsed time : ".$Diff;

if ($res) {
   die "ERROR RUNNING @ARGV; ".$timemsg."\n";
}

print "COMPLETED @ARGV; ".$timemsg."\n\n";
DONE

chmod +x logged_setup.sh
