#____________________________________________________________________ 
# File: Entry.pm
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: Apr 19, 2011 11:27:17 PM
# Revision: $Id$
#
# Copyright: 2011 (C) Shaun Ashby
#
#--------------------------------------------------------------------
package AutoFS::Table::Entry;

use strict;
use warnings;

use Carp qw(croak);

our $VERSION = '0.1';

sub new() {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = (@_ == 0) ?           # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? $_[0] # Got hashref already - OK
	: { @_ };                        # Otherwise, store the params in a hash
	
	# Simple validation:
	map { exists($self->{$_}) || croak "Must have attribute $_" } qw(key options location mountpoint);
	bless($self => $class);

	return $self;
}

sub key() { return shift->{key} }

sub options() { return shift->{options} }

sub location() { return shift->{location} }

sub mountpoint() { return shift->{mountpoint} }

1;

__END__
