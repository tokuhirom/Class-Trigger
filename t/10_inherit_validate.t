use strict;
use Test::More tests => 1;

{
    package Parent;
    use Class::Trigger qw/before after/;
}

{
    package Child;
    use base qw/Parent/;
}

eval { Child->add_trigger("unknown", sub { }) };
like $@, qr/is not valid triggerpoint for/;

