use strict;
use warnings;

use CPAN;
CPAN::HandleConfig->load;
$CPAN::Config->{test_report} = 1;
$CPAN::Config->{colorize_output} = 0;
CPAN::Index->reload;
$CPAN::META->reset_tested;
test( 'MSTROUT/Moo-0.091011.tar.gz' );