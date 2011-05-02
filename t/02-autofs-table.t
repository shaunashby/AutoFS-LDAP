#!perl
use strict;
use warnings;

use Test::More tests => 4;

use AutoFS::Map::Master;

my $master = AutoFS::Map::Master->new( { map_name => 'auto_master' });
my $maps = $master->maps;
my $entry = $maps->[0];

cmp_ok(ref($entry),'eq','AutoFS::Map');
can_ok($entry,"mountpoint");
can_ok($entry,"map_name");
can_ok($entry,"map_file");
