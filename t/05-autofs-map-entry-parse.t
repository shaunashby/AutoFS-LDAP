#!perl
use strict;
use warnings;

use Test::More tests => 2;

use AutoFS::Map::Master;

my $master = AutoFS::Map::Master->new( { map_name => 'auto_master' });
my $map = $master->getMap('/isdc/arc/rev_2/obs_isgri');

cmp_ok(ref($map),'eq','AutoFS::Map');
my $expected="key: 0600.002 (opts=-bg,soft,ro,retrans=3,retry=2,timeo=5,proto=udp) archive4:/export/diskF3/rev_2/obs_isgri/&";

# Just read all the entries in the map: $info will be set for the last entry in the map
# which we'll use in our comparison test:
my $info;
map {
    $info = sprintf("key: %s (opts=%s) %s",$_->key,$_->options,$_->location);
} @{ $map->entries };

cmp_ok($info,'eq',$expected);
