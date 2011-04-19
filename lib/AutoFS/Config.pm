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
)] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

use constant PROJECT_BASE_DIR 		=> '/Users/sashby/Desktop/Workspace/Projects/AutoFS-LDAP';
use constant AUTOMOUNT_CONFIG_DIR 	=> PROJECT_BASE_DIR."/automount";

1;
__END__