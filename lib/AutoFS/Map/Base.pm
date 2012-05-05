#____________________________________________________________________ 
# File: Base.pm
#____________________________________________________________________ 
#  
# Author: Shaun ASHBY <Shaun.Ashby@gmail.com>
# Update: 2011-05-02 17:18:22+0200
# Revision: $Id$ 
#
# Copyright: 2011 (C) Shaun ASHBY
#
#--------------------------------------------------------------------
package AutoFS::Map::Base;

=head1 NAME

AutoFS::Map::Base - Base class for automount maps.

=head1 SYNOPSIS

	my $obj = AutoFS::Map::Base->new();

=head1 DESCRIPTION

This is the base class for automount maps.

=head1 METHODS

=over

=cut

use strict;
use warnings;

use Carp qw(croak);

use AutoFS::Config qw(:all);

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = (@_ == 0) ?           # Error if no params given
	croak("No params given.\n")
	: (ref($_[0]) eq 'HASH') ? $_[0] # Got hashref already - OK
	: { @_ };                   # Otherwise, store the params in a hash

    $self->{content} = [];
    bless($self => $class);
    return $self;
}

sub map_name() { return shift->{map_name} }

sub map_file() { return shift->{map_file} }

sub _project_base() { return shift->{project_base} }

sub _read() {
    my ($self,$map_name) = @_;

    $self->{map_file} = $self->_project_base()."/".AUTOMOUNT_CONFIG_DIR.'/'.$map_name;
    croak sprintf("Unable to read automount map file %s",$self->{map_file}) unless (-f $self->{map_file});

    push(@{ $self->{content} }, Path::Class::File->new($self->{map_file})->slurp( chomp => 1 ) );
}

1;

__END__

=back

=head1 AUTHOR/MAINTAINER

Shaun ASHBY

=cut

