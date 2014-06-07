#!/usr/bin/perl

use strict;
use warnings;

use FindBin;

use lib "$FindBin::Bin/../lib";

use AnyEvent::Clipboard;

my $cv = AnyEvent->condvar;

my $watcher = AnyEvent::Clipboard->new(
    on_change => sub {
        my $content = shift;
        print "===Changing clipboard: content is ...\n$content\n===\n";
    },
);

$cv->recv;

exit;
