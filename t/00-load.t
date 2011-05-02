#!perl

use Test::More tests => 5;

BEGIN {
	use_ok( 'AutoFS::Config' );
	use_ok( 'AutoFS::LDAP' );
	use_ok( 'AutoFS::Map::Master' );
	use_ok( 'AutoFS::Map' );
	use_ok( 'AutoFS::Table::Entry' );
}

diag( "Testing AutoFS::LDAP $AutoFS::LDAP::VERSION, Perl $], $^X" );
