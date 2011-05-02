#!perl

use strict;
use warnings;
use Template;

use AutoFS::Map::Master;
use AutoFS::Config qw(:all);

my ($template, $output);
my $master = AutoFS::Map::Master->new( { map_name => AUTOMOUNT_CONFIG_DIR . '/auto_master' } );

my $table = $master->getTable('/cons');

$template = Template->new( { } ) || die Template->error(), "\n";
$template->process(\*DATA, { table => $table }, \$output);

print $output,"\n";

__DATA__
[% FOR entry IN table.entries -%]
automountKey=[% entry.mountpoint %]
automountInformation=[% entry.info %]
[% END -%]
