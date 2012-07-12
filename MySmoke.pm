use strict;
use warnings;

package MySmoke;

use CPAN::Reporter::Smoker;

sub run {
    shift;
    $ENV{PERL_JSON_BACKEND} = "JSON::XS";
    $ENV{PERL_YAML_BACKEND} = "YAML::XS";
    start( restart_delay => 600, @_ );
}

1;
