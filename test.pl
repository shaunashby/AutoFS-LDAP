#!perl

use strict;
use warnings;
use Template;

use AutoFS::Map::Master;

my ($template, $output);
my $master = AutoFS::Map::Master->new( { map_name => "auto_master" } );

my $map = $master->getMap('/cons');

$template = Template->new( { } ) || die Template->error(), "\n";
$template->process(\*DATA, { map => $map }, \$output);

print $output,"\n";

__DATA__
[% FOR entry IN map.entries -%]
automountKey=[% entry.mountpoint %]
automountOpts=[% entry.options %]
automountInformation=[% entry.location %]
[% END -%]
