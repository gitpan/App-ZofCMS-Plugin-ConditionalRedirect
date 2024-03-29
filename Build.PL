use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'App::ZofCMS::Plugin::ConditionalRedirect',
    license             => 'perl',
    dist_author         => q|Zoffix <'zoffix@cpan.org'>|,
    dist_version_from   => 'lib/App/ZofCMS/Plugin/ConditionalRedirect.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        perl => '5.006',
    },
    configure_requires => { 'Module::Build' => 0 },
    add_to_cleanup      => [ 'App-ZofCMS-Plugin-ConditionalRedirect-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
