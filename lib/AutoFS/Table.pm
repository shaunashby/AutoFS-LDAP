#____________________________________________________________________ 
# File: Table.pm
#____________________________________________________________________ 
#  
# Author: Shaun Ashby <Shaun.Ashby@gmail.com>
# Update: Apr 19, 2011 9:05:03 PM
# Revision: $Id$
#
# Copyright: 2011 (C) Shaun Ashby
#
#--------------------------------------------------------------------
package AutoFS::Table;

use strict;
use warnings;

use Carp qw(croak);

our $VERSION = '0.1';

use AutoFS::Config qw(:all);
use AutoFS::Table::Entry;

use overload qw{""} => \&as_text;

sub new() {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self = (@_ == 0) ?           # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? $_[0] # Got hashref already - OK
	: { @_ };                        # Otherwise, store the params in a hash
	
	# Simple validation:
	map { exists($self->{$_}) || croak "Must have attribute $_" } qw(mountpoint key);
	bless($self => $class);
	
	# Set the automount table name for this key:
	$self->{table} = AUTOMOUNT_CONFIG_DIR.'/'.$self->{key};
	# Check that the automount table exists :
	croak sprintf("Unable to read automount table %s",$self->{table}) unless (-f $self->{table});
	# Now read it:
	my @entries = Path::Class::File->new($self->{table})->slurp( chomp => 1 );
	$self->_read(\@entries);
	return $self;
}

sub _read() {
	my ($self,$entries) = @_;
	$self->{entries} = [];
	map {
	    if ($_ !~ /^#/) {
		if (my ($mount, $opts, $info) = ($_ =~ m|([a-zA-Z0-9_]*)\s+([a-zA-Z0-9-_=,]*)\s+([a-zA-Z0-9:&/]*)|g)) {
		    push(@{$self->{entries}}, AutoFS::Table::Entry->new( { mountpoint => $mount, options => $opts, info => $info } ));
		}
	    }
	} @$entries;
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
