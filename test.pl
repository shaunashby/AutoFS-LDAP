#!perl

use strict;
use warnings;
use Template;

use AutoFS::Map::Master;

use constant AUTOFS_LDAP_BASE_DN => 'dc=integral,dc=ops';

my $outFile = "./autofs.ldif";
my $template;
my $master = AutoFS::Map::Master->new( { map_name => "auto_master" } );

$template = Template->new( { } ) || die Template->error(), "\n";
$template->process(\*DATA, { master_map => $master, ldap_base_dn => AUTOFS_LDAP_BASE_DN }, $outFile);

__DATA__
dn: ou=autofs,ou=Services,[% ldap_base_dn %]
objectClass: top
objectClass: organizationalUnit
ou: autofs

dn: automountMapName=auto_master,ou=autofs,ou=Services,[% ldap_base_dn %]
objectClass: top
objectClass: automountMap
automountMapName: auto_master

[% FOR map IN master_map.maps -%]

dn: automountMapName=[% map.map_name %],ou=autofs,ou=Services,[% ldap_base_dn %]
objectClass: top
objectClass: automountMap
automountMapName: [% map.map_name %]

dn: automountKey=[% map.mountpoint %],automountMapName=auto_master,ou=autofs,ou=Services,[% ldap_base_dn %]
objectClass: automount
automountInformation: [% map.map_name %]
automountKey: [% map.mountpoint %]

[% FOR automount IN map.entries %]
# Mountpoint [% automount.mountpoint %]:
dn: automountKey=[% automount.key %],automountMapName=[% map.map_name %],ou=autofs,ou=Services,[% ldap_base_dn %]
objectClass: automount
automountInformation: [% automount.options %] [% automount.location %]
automountKey: [% automount.key %]
[% END %]
[% END -%]
