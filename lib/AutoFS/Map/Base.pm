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
use Carp;

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

sub _read() {
    my ($self,$file) = @_;
    push(@{ $self->{content} }, Path::Class::File->new($file)->slurp( chomp => 1 ) );
}

1;

__END__

=back

=head1 AUTHOR/MAINTAINER

Shaun ASHBY

=cut

