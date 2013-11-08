package App::ZofCMS::Plugin::ConditionalRedirect;

use warnings;
use strict;

our $VERSION = '0.0102';

sub new { bless {}, shift }

sub process {
    my ( $self, $template, $query, $config ) = @_;
    return
        unless $template->{plug_redirect}
            or $config->conf->{plug_redirect};

    my $sub = delete $template->{plug_redirect} || delete $config->conf->{plug_redirect};

    my $uri = $sub->( $template, $query, $config );

    defined $uri
        or return;

    print $config->cgi->redirect($uri);
    exit;
}

1;
__END__

=encoding utf8

=head1 NAME

App::ZofCMS::Plugin::ConditionalRedirect - redirect users based on conditions

=head1 SYNOPSIS

In Main Config file or ZofCMS template:

    plugins => [ qw/ConditionalRedirect/ ],
    plug_redirect => sub { time() % 2 ? 'http://google.com/' : undef },

=head1 DESCRIPTION

The module is a plugin for L<App::ZofCMS>. It provides means to redirect user to pages
depending on certain conditions, e.g. some key having a value in ZofCMS Template hashref or
anything else, really.

This documentation assumes you've read L<App::ZofCMS>, L<App::ZofCMS::Config>
and L<App::ZofCMS::Template>

=head1 MAIN CONFIG FILE AND ZofCMS TEMPLATE KEYS

=head2 C<plugins>

    plugins => [ qw/ConditionalRedirect/ ],

    plugins => [ { UserLogin => 1000 }, { ConditionalRedirect => 2000 } ],

The obvious is that you'd want to stick this plugin into the list of plugins to be
executed. However, since functionality of this plugin can be easily implemented using
C<exec> and C<exec_before> special keys in ZofCMS Template, being able to set the
I<priority> to when the plugin should be run would probably one of the reasons for you
to use this plugin (it was for me at least).

=head2 C<plug_redirect>

    plug_redirect => sub {
        my ( $template_ref, $query_ref, $config_obj ) = @_;
        return $template_ref->{foo} ? 'http://google.com/' : undef;
    }

The C<plug_redirect> first-level key in Main Config file or ZofCMS Template takes a subref
as a value. The sub will be executed and its return value will determine where to redirect
(if at all). Returning C<undef> from this sub will B<NOT> cause any redirects at all. Returning
anything else will be taken as a URL to which to redirect and the plugin will call C<exit()>
after printing the redirect headers.

The C<@_> of the sub will receive the following: ZofCMS Template hashref, query parameters
hashref and L<App::ZofCMS::Config> object (in that order).

If you set C<plug_redirect> in both Main Config File and ZofCMS Template, the one in
ZofCMS Template will take precedence.

=head1 AUTHOR

'Zoffix, C<< <'zoffix at cpan.org'> >>
(L<http://zoffix.com/>, L<http://haslayout.net/>, L<http://zofdesign.com/>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-zofcms-plugin-conditionalredirect at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ZofCMS-Plugin-ConditionalRedirect>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ZofCMS::Plugin::ConditionalRedirect

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ZofCMS-Plugin-ConditionalRedirect>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ZofCMS-Plugin-ConditionalRedirect>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ZofCMS-Plugin-ConditionalRedirect>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ZofCMS-Plugin-ConditionalRedirect>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 'Zoffix, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

