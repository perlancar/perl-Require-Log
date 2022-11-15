## no critic: TestingAndDebugging::RequireUseStrict
package Require::Log;

#IFUNBUILT
use strict;
use warnings;
#END IFUNBUILT

# AUTHORITY
# DATE
# DIST
# VERSION

# saving the original require() does snot work
#my $orig_require = \&CORE::GLOBAL::require;
*CORE::GLOBAL::require = sub {
    my @caller = caller(1);
    warn "require($_[0]) called from package $caller[0] file $caller[1]:$caller[2]\n";
    CORE::require(@_);
};

1;
# ABSTRACT: Log require()

=head1 SYNOPSIS

 use Require::Log;
 # now each time someone require()'s, a message will be printed to STDERR


=head1 DESCRIPTION


=head1 SEE ALSO

L<Require::HookChain::log::stderr>

L<Require::HookChain::log::logger>

L<App::tracepm>
