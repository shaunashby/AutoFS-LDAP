#!perl
#____________________________________________________________________ 
# File: 01-autofs-master.t
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: Apr 19, 2011 4:55:24 PM
# Revision: $Id$
#
# Copyright: 2011 (C) Shaun Ashby
#
#--------------------------------------------------------------------
use strict;
use warnings;

use Test::More tests => 1;

use AutoFS::Master;
use AutoFS::Config qw(:all);

my $master = AutoFS::Master->new( { master => AUTOMOUNT_CONFIG_DIR.'/auto_master' });

cmp_ok(ref($master),'eq','AutoFS::Master');