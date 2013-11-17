use 5.006;
use strict;
use warnings;
use Module::Build::Pluggable (
    'CPANfile'
);
 
my $builder = Module::Build::Pluggable->new(
    module_name         => 'Module::Starter::TOSHIOITO',
    license             => 'perl',
    dist_author         => q{Toshio Ito <toshioito@cpan.org>},
    dist_version_from   => 'lib/Module/Starter/TOSHIOITO.pm',
    release_status      => 'stable',
    add_to_cleanup     => [ 'Module-Starter-TOSHIOITO-*' ],
    recursive_test_files => 1,
    no_index => {
        directory => ["t", "xt", "eg", "inc"],
        file => ['README.pod'],
    },
    meta_add => {
        resources => {
            bugtracker => 'https://github.com/debug-ito/Module-Starter-TOSHIOITO/issues',
            repository => 'git://github.com/debug-ito/Module-Starter-TOSHIOITO.git',
        }
    }
);
 
$builder->create_build_script();
