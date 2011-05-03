#!perl
use strict;
use warnings;

use Test::More tests => 2;

use AutoFS::Config qw(:all);

cmp_ok(AUTOMOUNT_LDAP_BASE_DN,'eq','ou=autofs,ou=Services,dc=integral,dc=ops');

my $map_name = '/testing';

my $expected_automount_map_entry = "
dn: automountMapName=/testing,ou=autofs,ou=Services,dc=integral,dc=ops
objectClass: top
objectClass: automountMap
automountMapName: /testing";

my $automount_map_entry = sprintf(AUTOMOUNT_MAP_LDAP_DN,$map_name,$map_name);
cmp_ok($automount_map_entry,'eq',$expected_automount_map_entry);
