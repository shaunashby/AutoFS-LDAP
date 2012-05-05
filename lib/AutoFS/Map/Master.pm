#____________________________________________________________________ 
# File: Master.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <shaun.ashby@gmail.com>
# Update: Apr 19, 2011 4:22:20 PM
# Revision: $Id:$
#
# Copyright: 2011 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package AutoFS::Map::Master;

use strict;
use warnings;

use Path::Class::File;
use Carp qw(croak);

use base 'AutoFS::Map::Base';

use AutoFS::Map;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@_);

    bless($self, $class);

    # Simple validation:
    map { exists($self->{$_}) || croak "Must have attribute $_" } qw(project_base map_name);
    # Now read it:
    $self->_read( $self->{map_name} );

    return $self;
}

sub maps() { return shift->{maps} }

sub getMap() {
    my ($self, $mountpoint) = @_;
    my $map = [ grep { $_->mountpoint eq $mountpoint } @{ $self->maps } ];
    ($#$map == 0 && ref($map->[0]) eq "AutoFS::Map") ? return $map->[0] : return undef;
}

sub _read() {
    my ($self,$map_name) = @_;
    $self->{maps} = [];
    $self->SUPER::_read($map_name);

    map {
	if ($_ !~ /^#/ && $_ !~ m|^/net|) {
	    if (my ($mountpoint,$mapname) = ($_ =~ m|(^/.*[^\s])\s+(.*?)$|g)) {
		push(@{$self->{maps}}, AutoFS::Map->new( { project_base => $self->_project_base(),
							   mountpoint => $mountpoint,
							   map_name => $mapname } ));
	    }
	}
    } @{ $self->{content} };
}

1;

__END__
