use strict;
use Test::More tests => 1;

use lib 't/lib';
use Foo;

my $foo = Foo->new();
is($foo->call_trigger(), undef, 'no triggers, no action');
