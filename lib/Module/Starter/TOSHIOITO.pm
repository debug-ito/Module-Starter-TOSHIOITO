package Module::Starter::TOSHIOITO;
use strict;
use warnings;
use base "Module::Starter::Simple";

sub create_distro {
    my ($either, %args) = @_;
    $args{ignores_type} ||= [qw(git manifest)];
    $args{verbose} = 1;
    $args{github_user_name} ||= "debug-ito";
    return $either->SUPER::create_distro(%args);
}

sub _github_repo_name {
    my ($self) = @_;
    return $self->{distro};
}

sub Build_PL_guts {
    my ($self, $main_module, $main_pm_file) = @_;
    my $author = "$self->{author} <$self->{email}>";
 
    my $slname = $self->{license_record} ? $self->{license_record}->{slname} : $self->{license};
    my $reponame = $self->_github_repo_name;
     
    return <<"HERE";
use $self->{minperl};
use strict;
use warnings FATAL => 'all';
use Module::Build::Pluggable (
    'CPANfile'
);
 
my \$builder = Module::Build::Pluggable->new(
    module_name         => '$main_module',
    license             => '$slname',
    dist_author         => q{$author},
    dist_version_from   => '$main_pm_file',
    release_status      => 'stable',
    add_to_cleanup     => [ '$self->{distro}-*' ],
    recursive_test_files => 1,
    no_index => {
        directory => ["t", "xt", "eg", "inc"],
        file => ['README.pod'],
    },
    meta_add => {
        resources => {
            bugtracker => 'https://github.com/$self->{github_user_name}/$reponame/issues',
            repository => 'git://github.com/$self->{github_user_name}/$reponame.git'
        }
    }
);
 
\$builder->create_build_script();
HERE
}

sub create_Build_PL {
    my ($self, $main_module) = @_;
    my $result = $self->SUPER::create_Build_PL($main_module);
    $self->create_file("cpanfile", <<<'HERE');

on 'test' => sub {
    requires 'Test::More' => "0";
};

on 'configure' => sub {
    requires 'Module::Build::Pluggable',           '0.09';
    requires 'Module::Build::Pluggable::CPANfile', '0.02';
};
HERE
    $self->progress("Created cpanfile");
    return $result;
}

sub module_guts {
    my ($self, $module, $rtname) = @_;
    my $reponame = $self->_github_repo_name;
    my $username = $self->{github_user_name};
    my $license = $self->_module_license($module, $rtname);
    return <<<"HERE"
package $module;
use strict;
use warnings;

our \$VERSION = "0.01";

1;
__END__

\=pod

\=head1 NAME

$module - the great new whatever

\=head1 SYNOPSIS

\=head1 DESCRIPTION

\=head1 SEE ALSO

\=head1 REPOSITORY

L<https://github.com/$username/$reponame>

\=head1 AUTHOR
 
$self->{author}, C<< <$self->{email_obfuscated}> >>

$license

\=cut

HERE
}

1;

__END__

=head1 NAME

Module::Starter::TOSHIOITO - The great new Module::Starter::TOSHIOITO!

=head1 SYNOPSIS


=head1 SUBROUTINES/METHODS


=head1 AUTHOR

Toshio Ito, C<< <toshioito at cpan.org> >>

=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Toshio Ito.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
