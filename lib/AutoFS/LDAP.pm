package AutoFS::LDAP;

use warnings;
use strict;

use AutoFS::Config qw(:all);

our $VERSION = 0.1;

sub new() {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    return bless({}, $class);
}

1;

__END__
