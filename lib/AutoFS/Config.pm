#____________________________________________________________________ 
# File: Config.pm
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: Apr 19, 2011 11:03:02 PM
# Revision: $Id$
#
# Copyright: 2011 (C) Shaun Ashby
#
#--------------------------------------------------------------------
package AutoFS::Config;

use strict;
use warnings;

use base qw(Exporter);
use vars qw( @EXPORT_OK %EXPORT_TAGS );

%EXPORT_TAGS = ( 'all' => [ qw(
AUTOMOUNT_CONFIG_DIR
AUTOMOUNT_LDAP_BASE_DN
AUTOMOUNT_MAP_LDAP_DN
)] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

use constant AUTOMOUNT_CONFIG_DIR 	=> "/automount";
use constant AUTOMOUNT_LDAP_BASE_DN     => 'ou=autofs,ou=Services,dc=test,dc=com';
use constant AUTOMOUNT_MAP_LDAP_DN      => "
dn: automountMapName=%s,ou=autofs,ou=Services,dc=test,dc=com
objectClass: top
objectClass: automountMap
automountMapName: %s";

1;
__END__
