# NAME

AnyEvent::Clipboard - observation and hook clipboard changing.

# SYNOPSIS

    use AnyEvent;
    use AnyEvent::Clipboard;
    
    my $cv = AnyEvent->condvar;
    
    my $pb_watcher = AnyEvent::Clipboard->new(
      interval => [1, 1, 2, 3, 5], # see following key specify description.
      on_change => sub {
        my $pb_content = shift;
        print "change pasteboard content: $pb_content\n";
      },
      on_unchange => sub {
        # ...some code...
      },
      on_error => sub {
         my $error = shift;
         print "Error occured.";
         die $error;
      },
    );
    
    $cv->recv;

# CAUTION

\*\*\*THIS IS ALPHA VERSION. IF YOU ARE MAC OS X USER, THEN USE [AnyEvnet::Mac::Psateboard](https://metacpan.org/pod/AnyEvnet::Mac::Psateboard) PREFER.\*\*\*

# DESCRIPTION

This module is observation and hook Any OS'es clipboard changing.

# METHODS

## AnyEvent::Clipboard->new( ... )

    my $pb_watcher = AnyEvent::Clipboard->new( ... );

This object runs at recv'ing AnyEvent->condver.

new gives key value pairs as argument.

- interval => POSITIVE\_DIGIT or ARRAYREF having POSITIVE\_DIGITS

    Specify pasteboard observation interval.

        interval => 2, # per 2 seconds.

    or

        # 1st 0.5 second, 2nd 0.5 too, 3rd, 1 second, ...
        # and last per 5 seconds interval.
        interval => [0.5, 0.5, 1, 2, 3, 4, 5],

    This key is optional.
    Default interval is defined by $AnyEvent::Clipboard::DEFAULT\_INTERVAL.

        perl -MAnyEvent::Clipboard -E 'say $AnyEvent::Clipboard::DEFAULT_INTERVAL;'

- on\_change => CALLBACK

        on_change => sub {
           my $clipboard_content = shift;
           print qq(Run on_change. clipboard content is "$clipboard_content"\n);
        },

    While this module observates per specified interval,
    if it detects clipboard changing at per observation,
    then call this "on\_change" callback.

    This callback gives changed new clipboard content at 1st argument.

- on\_unchagnge => CALLBACK

        on_unchange => sub {
           my $pb_content = shift;
           print "Run on_unchange.\n" if DEBUG;
        },

    The converse of "on\_change" callback.

    This callback may be using at DEBUG.

- on\_error => CALLBACK

    This callback "on\_error" is called at error occuring.

    However this callback is **BETA STATUS**,
    so it may be obsoluted at future release.

- multibyte => BOOL

    On Mac OS X, It seems internal using Mac::Pasteboard#pbpaste()
    (given pasteboard content subroutine) is broken multibyte UTF-8 characters.

    Because this AnyEvent::Clipboard is used low cost Mac::Pasteboard#pbpate()
    via [Clipboard](https://metacpan.org/pod/Clipboard) as observation,
    high cost external command call \`pbpaste\` as picking up content.

    If you use only single byte UTF-8 characters (ASCII only),
    then it is no problem this flag is false.
    However if you use multibyte UTF-8 character,
    then let this flag true for safety.

    Default is false.

# SEE ALSO

[Clipboard](https://metacpan.org/pod/Clipboard).

# AUTHOR

OGATA Tetsuji, <ogata {at} gmail.com>

# COPYRIGHT AND LICENSE

Copyright (C) 2014 by OGATA Tetsuji

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
