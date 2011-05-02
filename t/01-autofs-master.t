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

use Test::More tests => 8;

use AutoFS::Map::Master;
use AutoFS::Config qw(:all);

my $master = AutoFS::Map::Master->new( { map_name => AUTOMOUNT_CONFIG_DIR.'/auto_master' });

cmp_ok(ref($master),'eq','AutoFS::Map::Master');
can_ok($master,"map_name");
can_ok($master,"tables");
can_ok($master,"getTable");

my $cons_table = $master->getTable('/cons');
cmp_ok(ref($cons_table),'eq','AutoFS::Table');
cmp_ok($cons_table->mountpoint,'eq','/cons');

my $fail_table = $master->getTable('/carp');
ok(!defined($fail_table),"Non-existent mount table.");

my $tables = $master->tables;
isa_ok($tables,'ARRAY');
