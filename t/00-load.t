#!perl

use Test::More tests => 1;

BEGIN {
	use_ok( 'AutoFS::LDAP' );
}

diag( "Testing AutoFS::LDAP $AutoFS::LDAP::VERSION, Perl $], $^X" );