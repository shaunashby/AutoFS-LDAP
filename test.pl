#!perl

use strict;
use warnings;

use AutoFS::LDAP;

my $autofs = AutoFS::LDAP->new( { map => "/etc/auto_master" } );

use Data::Dumper;
print Dumper($autofs),"\n";