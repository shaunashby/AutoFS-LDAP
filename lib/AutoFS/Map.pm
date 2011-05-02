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

use AutoFS::Config qw(:all);
use AutoFS::Table::Entry;

use overload qw{""} => \&as_text;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@_);

    bless($self, $class);

    # Simple validation:
    map { exists($self->{$_}) || croak "Must have attribute $_" } qw(mountpoint key);
    # Set the automount table name for this key:
    $self->{map_file} = AUTOMOUNT_CONFIG_DIR.'/'.$self->{key};
    # Check that the automount table exists :
    croak sprintf("Unable to read automount map file %s",$self->{map}) unless (-f $self->{map_file});

    # Now read it:
    $self->_read( $self->{map_file} );

    return $self;
}

sub _read() {
    my ($self,$file) = @_;
    $self->{entries} = [];
    $self->SUPER::_read($file);

    map {
	if ($_ !~ /^#/) {
	    if (my ($mount, $opts, $info) = ($_ =~ m|([a-zA-Z0-9_]*)\s+([a-zA-Z0-9-_=,]*)\s+([a-zA-Z0-9:&/]*)|g)) {
		push(@{$self->{entries}}, AutoFS::Table::Entry->new( { mountpoint => $mount, options => $opts, info => $info } ));
	    }
	}
    } @{ $self->{content} };
}

sub type() { return shift->{type} || 'indirect' }

sub entries() { return shift->{entries} || [] }

sub mountpoint() { return shift->{mountpoint} };

sub key() { return shift->{key} };

sub table() { return shift->{table} };

sub as_text() {
	my $self = shift;
	return sprintf("%-30s\t%-55s\n", $self->{mountpoint}, $self->{key});	
}

1;
__END__
