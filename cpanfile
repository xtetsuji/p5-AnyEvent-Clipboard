requires 'perl', '5.008001';

# Common
requires 'AnyEvent';
requires 'Clipboard';
requires 'Scalar::Util';
requires 'Time::HiRes';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

