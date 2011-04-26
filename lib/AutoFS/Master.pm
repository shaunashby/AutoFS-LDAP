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
package AutoFS::Master;

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
    map { exists($self->{$_}) || croak "Must have attribute $_" } qw(master);
    bless($self => $class);
    
    # Check that master table exists:
    croak sprintf("Unable to read master table %s",$self->{master}) unless (-f $self->{master});
    # Now read it:
    my @master = Path::Class::File->new($self->{master})->slurp( chomp => 1 );
    $self->_read(\@master);
    return $self;
}

sub name() { return shift->{master} }

sub tables() { return shift->{tables} }

sub getTable() { 
	my ($self, $mountpoint) = @_;
	my $table = [ grep { $_->mountpoint eq $mountpoint } @{ $self->tables } ];
	($#$table == 0 && ref($table->[0]) eq "AutoFS::Table") ? return $table->[0] : return undef;
}

sub _read() {
	my ($self,$master) = @_;
	$self->{tables} = [];
	map {
		if ($_ !~ /^#/ && $_ !~ m|^/net|) {
			if (my ($mnt,$tab) = ($_ =~ m|(^/.*[^\s])\s+(.*?)$|g)) {
				push(@{$self->{tables}}, AutoFS::Table->new( { mountpoint => $mnt, key => $tab } ));
			}
		}
	} @$master;
}

1;

__END__
