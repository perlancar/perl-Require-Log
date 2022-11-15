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

# check if building archive
sub _is_dzil_build { my $i = 1; while (my @c = caller($i++)) { return 1 if $c[3] eq 'Dist::Zilla::Dist::Builder::build_archive' } 0 }

my $patched;

{
    last if $patched;
    last if _is_dzil_build(); # avoid patching if we are loaded during build

    # saving the original require() does snot work
    #$orig_require = \&CORE::GLOBAL::require;
    *CORE::GLOBAL::require = sub {
        my @caller = caller(1);
        warn "require($_[0]) called from package $caller[0] file $caller[1]:$caller[2]\n";
        warn "\@_: ".join(", ", @_)."\n";
        CORE::require(@_);
    };
    $patched++;
}

1;
# ABSTRACT: Log require()

=head1 SYNOPSIS

 use Require::Log;
 # now each time someone require()'s, a message will be printed to STDERR


=head1 DESCRIPTION

XXX. Currently does not work properly because we add a level of call in
require().


=head1 SEE ALSO

L<Require::HookChain::log::stderr>

L<Require::HookChain::log::logger>

L<App::tracepm>
