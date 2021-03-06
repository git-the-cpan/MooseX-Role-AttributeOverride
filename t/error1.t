use strict;
use warnings;

{

    package MyApp::Role;
    use Moose::Role;
    use MooseX::Role::AttributeOverride;

    has_plus 'fun' => ( default => 'yep', );

}
{

    package MyApp;
    use Moose;

    has 'notfun' => (
        is  => 'rw',
        isa => 'Str'
    );

}
{

    package main;
    use Moose::Util;
    use Try::Tiny;
    use Test::More tests => 1;    # last test to print

    my $error = undef;
    try {
        Moose::Util::apply_all_roles( 'MyApp', 'MyApp::Role' );
        my $test = MyApp->new();
    }
    catch {
        $error = $_;
    };
    ok( $error =~ /Can't find attribute/, 'Missing Attribute dies' );

}
