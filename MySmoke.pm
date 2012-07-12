use strict;
use warnings;

package MySmoke;

use CPAN::Reporter::Smoker;

sub run {
    shift;
    start( restart_delay => 600, @_ );
}

1;
