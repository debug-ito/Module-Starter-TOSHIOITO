requires "perl" => "5.10.0";
requires "Module::Starter::Simple";
requires "Carp";
requires "File::Spec";
requires "ExtUtils::Command";

on 'test' => sub {
    requires 'Test::More' => "0";
};

on 'configure' => sub {
    requires 'Module::Build', '0.42';
    requires 'Module::Build::Pluggable', '0.09';
    requires 'Module::Build::Pluggable::CPANfile', '0.02';
};
