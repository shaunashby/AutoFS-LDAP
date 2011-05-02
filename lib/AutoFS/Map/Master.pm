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

use AutoFS::Table;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?           # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? $_[0] # Got hashref already - OK
	: { @_ };                        # Otherwise, store the params in a hash

    # Simple validation:
    map { exists($self->{$_}) || croak "Must have attribute $_" } qw(map_name);
    bless($self => $class);
    
    # Check that master table exists:
    croak sprintf("Unable to read master_map file %s",$self->{map_name}) unless (-f $self->{map_name});
    # Now read it:
    my @master_map_entries = Path::Class::File->new($self->{map_name})->slurp( chomp => 1 );
    $self->_read(\@master_map_entries);
    return $self;
}

sub map_name() { return shift->{map_name} }

sub tables() { return shift->{tables} }

sub getTable() { 
	my ($self, $mountpoint) = @_;
	my $table = [ grep { $_->mountpoint eq $mountpoint } @{ $self->tables } ];
	($#$table == 0 && ref($table->[0]) eq "AutoFS::Table") ? return $table->[0] : return undef;
}

sub _read() {
	my ($self,$master_map_entries) = @_;
	$self->{tables} = [];
	map {
		if ($_ !~ /^#/ && $_ !~ m|^/net|) {
			if (my ($mnt,$tab) = ($_ =~ m|(^/.*[^\s])\s+(.*?)$|g)) {
				push(@{$self->{tables}}, AutoFS::Table->new( { mountpoint => $mnt, key => $tab } ));
			}
		}
	} @$master_map_entries;
}

1;

__END__
