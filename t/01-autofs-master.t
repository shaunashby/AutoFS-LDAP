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

my $master = AutoFS::Map::Master->new( { map_name => 'auto_master' });

cmp_ok(ref($master),'eq','AutoFS::Map::Master');
can_ok($master,"map_name");
can_ok($master,"maps");
can_ok($master,"getMap");

my $cons_map = $master->getMap('/cons');
cmp_ok(ref($cons_map),'eq','AutoFS::Map');
cmp_ok($cons_map->mountpoint,'eq','/cons');

my $fail_map = $master->getMap('/carp');
ok(!defined($fail_map),"Non-existent mount table.");

my $maps = $master->maps;
isa_ok($maps,'ARRAY');
