#!/usr/bin/env perl

use Test::More tests => 1;

BEGIN {
	use_ok( 'App::ZofCMS::Plugin::ConditionalRedirect' );
}

diag( "Testing App::ZofCMS::Plugin::ConditionalRedirect $App::ZofCMS::Plugin::ConditionalRedirect::VERSION, Perl $], $^X" );
