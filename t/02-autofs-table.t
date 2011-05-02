#!perl
use strict;
use warnings;

use Test::More tests => 4;

use AutoFS::Map::Master;
use AutoFS::Config qw(:all);

my $master = AutoFS::Map::Master->new( { map_name => AUTOMOUNT_CONFIG_DIR.'/auto_master' });
my $maps = $master->maps;
my $entry = $maps->[0];

cmp_ok(ref($entry),'eq','AutoFS::Map');
can_ok($entry,"mountpoint");
can_ok($entry,"key");
can_ok($entry,"table");
