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
    map { exists($self->{$_}) || croak "Must have attribute $_" } qw(map_name);    
    # Check that master table exists:
    croak sprintf("Unable to read master_map file %s",$self->{map_name}) unless (-f $self->{map_name});
    # Now read it:
    $self->_read( $self->{map_name} );

    return $self;
}

sub map_name() { return shift->{map_name} }

sub maps() { return shift->{maps} }

sub getMap() { 
    my ($self, $mountpoint) = @_;
    my $map = [ grep { $_->mountpoint eq $mountpoint } @{ $self->maps } ];
    ($#$map == 0 && ref($map->[0]) eq "AutoFS::Map") ? return $map->[0] : return undef;
}

sub _read() {
    my ($self,$file) = @_;
    $self->{maps} = [];
    $self->SUPER::_read($file);
    map {
	if ($_ !~ /^#/ && $_ !~ m|^/net|) {
	    if (my ($mnt,$tab) = ($_ =~ m|(^/.*[^\s])\s+(.*?)$|g)) {
		push(@{$self->{maps}}, AutoFS::Map->new( { mountpoint => $mnt, key => $tab } ));
	    }
	}
    } @{ $self->{content} };
}

1;

__END__
