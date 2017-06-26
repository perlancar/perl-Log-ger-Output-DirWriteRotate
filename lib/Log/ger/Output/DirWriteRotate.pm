package Log::ger::Output::DirWriteRotate;

# DATE
# VERSION

use strict;
use warnings;

sub get_hooks {
    my %conf = @_;

    require Dir::Write::Rotate;
    my $dwr = Dir::Write::Rotate->new(%conf);

    return {
        create_log_routine => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                my $logger = sub {
                    my ($ctx, $msg) = @_;
                    $dwr->write($msg);
                };
                [$logger];
            }],
    };
}

1;
# ABSTRACT: Log to Dir::Write::Rotate

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Log::ger::Output DirWriteRotate => (
     path               => 'somedir.log',            # required
     filename_pattern   => '%Y-%m-%d-%H%M%S.pid-%{pid}.%{ext}', # optional
     filename_sub       => sub { ... },              # optional
     max_size           => undef,                    # optional
     max_files          => undef,                    # optional
     max_age            => undef,                    # optional
     rotate_probability => 0.25,                     # optional
 );


=head1 DESCRIPTION

This output sends logs to Dir::Write::Rotate object.


=head1 CONFIGURATION

These configuration parameters are Dir::Write::Rotate's.

=head2 path

=head2 filename_pattern

=head2 filename_sub

=head2 max_size

=head2 max_files

=head2 max_age

=head2 rotate_probability


=head1 SEE ALSO

L<Log::ger>

L<Dir::Write::Rotate>

=cut
