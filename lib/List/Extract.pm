package List::Extract;
use 5.006001;

$VERSION = 0.01;

use base 'Exporter';
@EXPORT_OK = qw/ extract /;
$EXPORT_TAGS{ALL} = \@EXPORT_OK;

use strict;

sub extract (&\@) {
    my ($code, $array) = @_;

    my (@keep, @extracted);
    for my $orig (@$array) {
        local $_ = $orig;
        if ($code->()) {
            push @extracted, $_;
        }
        else {
            push @keep, $orig;
        }
    }
    @$array = @keep;

    return @extracted;
}

1;

__END__

=head1 NAME

List::Extract - grep and splice combined


=head1 SYNOPSIS

    use List::Extract 'extract';

    my @foo = 0 .. 9;
    my @odd = extract { $_ % 2 } @foo;

    print "Odd : @odd\n";
    print "Even: @foo\n";

    __END__
    Odd : 1 3 5 7 9
    Even: 0 2 4 6 8


=head1 DESCRIPTION

C<List::Util> exports a C<grep>-like routine called C<extract> that both returns and extracts the elements that tests true. It's C<grep> and C<splice> combined.


=head1 EXPORTED FUNCTIONS

Nothing is exported by default. The :ALL tag exports everything that can be exported.

=over

=item extract BLOCK ARRAY

Returns and removes the elements from array for which C<BLOCK> returns true. In C<BLOCK> the elements in C<ARRAY> will be accessible through C<$_>. Modifications to C<$_> will be preserved in the returned list, but discarded for elements left in the array.

    my @keywords = qw/ foo !bar baz /;

    my @exclude = extract { s/^!// } @keywords;

    print "@keywords\n";
    print "@exclude\n";

    __END__
    foo baz
    bar

=back


=head1 AUTHOR

Johan Lodin <lodin@cpan.org>


=head1 COPYRIGHT

Copyright 2007 Johan Lodin. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.


=head1 SEE ALSO

L<List::Part>

=cut
