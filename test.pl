#!perl

use strict;
use warnings;

use AutoFS::Master;
use AutoFS::Config qw(:all);

my $master = AutoFS::Master->new( { master => AUTOMOUNT_CONFIG_DIR.'/auto_master' });

use Data::Dumper;
print Dumper($master),"\n";