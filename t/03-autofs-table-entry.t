#!perl
use strict;
use warnings;

use Test::More tests => 5;

use AutoFS::Map::Master;

my $master = AutoFS::Map::Master->new( { map_name => 'auto_master' });
my $map = $master->maps->[0];
my $entry = $map->entries->[0];

cmp_ok(ref($entry),'eq','AutoFS::Map::Entry');
can_ok($entry,"key");
can_ok($entry,"options");
can_ok($entry,"location");
can_ok($entry,"mountpoint");
