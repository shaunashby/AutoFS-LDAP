#!perl

use strict;
use warnings;

use AutoFS::Master;
use AutoFS::Config qw(:all);

my $master = AutoFS::Master->new( { master => AUTOMOUNT_CONFIG_DIR.'/auto_master' });

foreach my $table (@{ $master->tables() }) {
	print $table;
}