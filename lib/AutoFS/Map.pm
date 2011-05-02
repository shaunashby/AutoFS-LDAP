#____________________________________________________________________ 
# File: Map.pm
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: Apr 19, 2011 9:05:03 PM
# Revision: $Id$
#
# Copyright: 2011 (C) Shaun Ashby
#
#--------------------------------------------------------------------
package AutoFS::Map;

use strict;
use warnings;

use Carp qw(croak);

use base 'AutoFS::Map::Base';

use AutoFS::Map::Entry;

use overload qw{""} => \&as_text;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@_);

    bless($self, $class);
    
    # Simple validation:
    map { exists($self->{$_}) || croak "Must have attribute $_" } qw(mountpoint map_name);
    # Now read it:
    $self->_read( $self->{map_name} );

    return $self;
}

sub _read() {
    my ($self,$map_name) = @_;
    $self->{entries} = [];
    $self->SUPER::_read($map_name);

    map {
	if ($_ !~ /^#/) {
	    if (my ($key, $opts, $location) = ($_ =~ m|([a-zA-Z0-9_]*)\s+([a-zA-Z0-9-_=,]*)\s+([a-zA-Z0-9:&/]*)|g)) {
		push(@{$self->{entries}}, AutoFS::Map::Entry->new(
			 {
			     key => $key,
			     options => $opts,
			     location => $location,
			     mountpoint => $self->{mountpoint}."/$key"
			 }
		     ));
	    }
	}
    } @{ $self->{content} };
}

sub mountpoint() { return shift->{mountpoint} };

sub type() { return shift->{type} || 'indirect' }

sub entries() { return shift->{entries} || [] }

sub as_text() {
	my $self = shift;
	return sprintf("%-30s\t%-55s\n", $self->{mountpoint}, $self->{map_name});	
}

1;

__END__
