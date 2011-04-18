package AutoFS::LDAP;

use warnings;
use strict;

our $VERSION = 0.1;

sub new(){
	my ($proto) = shift;
	my ($args) = shift || {}; 
	my $class = ref($proto) || $proto;
	return bless({}, $class);
}

1;
__END__