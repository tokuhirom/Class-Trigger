use strict;
use Test::More tests => 7;

use IO::Scalar;

use lib 't/lib';
use Foo;			# should be use()

ok(Foo->add_trigger(before_foo => sub { print "before_foo\n" }), 'add_trigger');
ok(Foo->add_trigger(after_foo  => sub { print "after_foo\n" }), 'add_trigger');

my $foo = Foo->new;

{
    tie *STDOUT, 'IO::Scalar', \my $out;
    $foo->foo;
    untie *STDOUT;
    is $out, "before_foo\nfoo\nafter_foo\n";
}

ok(Foo->add_trigger(after_foo  => sub { print "after_foo2\n" }), 'add_trigger');

{
    tie *STDOUT, 'IO::Scalar', \my $out;
    $foo->foo;
    untie *STDOUT;
    is $out, "before_foo\nfoo\nafter_foo\nafter_foo2\n";
}

ok(Foo->add_trigger(after_foo  => sub { print ref $_[0] }), 'add_trigger');

{
    tie *STDOUT, 'IO::Scalar', \my $out;
    $foo->foo;
    untie *STDOUT;
    is $out, "before_foo\nfoo\nafter_foo\nafter_foo2\nFoo", 'class name';
}

