use strict;
use warnings;

{

    package MyApp::RoleA;
    use Moose::Role;
    use MooseX::Role::AttributeOverride;

    has_plus 'fun' => ( default => 'yep', );

    1;

}
{

    package MyApp::RoleB;
    use Moose::Role;

    requires qw(have);

    1;

}
{

    package MyApp;
    use Moose;

    has 'fun' => (
        is  => 'rw',
        isa => 'Str'
    );

    sub have {
        shift->fun('you betcha');
    }

    with qw(MyApp::RoleA MyApp::RoleB);

    1;

}
{

    package main;

    use Test::More tests => 2;

    my $test = MyApp->new();

    is( $test->fun, 'yep', "Default was set by role" );
    $test->have;
    is( $test->fun, 'you betcha', "can be modified" );

}
