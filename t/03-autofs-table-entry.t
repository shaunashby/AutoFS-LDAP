#!perl
use strict;
use warnings;

use Test::More tests => 4;

use AutoFS::Map::Master;
use AutoFS::Config qw(:all);

my $master = AutoFS::Map::Master->new( { map_name => AUTOMOUNT_CONFIG_DIR.'/auto_master' });
my $table = $master->tables->[0];
my $entry = $table->entries->[0];

cmp_ok(ref($entry),'eq','AutoFS::Table::Entry');
can_ok($entry,"mountpoint");
can_ok($entry,"options");
can_ok($entry,"info");
