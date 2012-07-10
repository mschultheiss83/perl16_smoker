@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl
#line 15
use 5.006;
use strict;
use warnings;
package metabase_profile; # dzil needs this
# PODNAME: metabase-profile
# ABSTRACT: create a metabase profile
our $VERSION = '0.021'; # VERSION

use Getopt::Long;
use JSON 2;
use Metabase::User::Profile;
use Metabase::User::Secret;
use Pod::Usage;

my (%profile, $help, $output, $full_name, $email_address, $password);
my $result = GetOptions(
  'help|h'      => \$help,
  'output|o:s'  => \$output,
  'name:s'      => \$full_name,
  'email:s'     => \$email_address,
  'secret:s'    => \$password,
);

pod2usage({-verbose => 2}) if ! $result || $help;

# setup output file and confirm it doesn't exist
if ( ! defined $output ) {
  $output = "metabase_id.json";
}
if ( -f $output ) {
  die "Won't over-write existing '$output' file.  Aborting.\n";
}

# get profile information
$profile{full_name}     = $full_name      if defined $full_name;
$profile{email_address} = $email_address  if defined $email_address;
$profile{password}      = $password       if defined $password;

my @prompts = (
  full_name     => 'full name',
  email_address => 'email address',
  password      => 'password/secret',
);

$|++; # autoflush prompts
while (@prompts) {
  my ($key, $phrase) = splice(@prompts,0,2);
  next if $profile{$key};
  print "Enter $phrase\: ";
  chomp( my $answer = <STDIN> );
  $profile{$key} = $answer;
}

# create profile and secret objects
$password = delete $profile{password};
my $profile = Metabase::User::Profile->create( %profile );
my $secret = Metabase::User::Secret->new(
  resource => $profile->resource,
  content  => $password,
);

# write output
print "Writing profile to '$output'\n";
open my $fh, ">", $output;
print {$fh} JSON->new->ascii->pretty->encode([
  $profile->as_struct,
  $secret->as_struct,
]);
close $fh;
chmod 0600, $output;



=pod

=head1 NAME

metabase-profile - create a metabase profile

=head1 VERSION

version 0.021

=head1 SYNOPSIS

  $ metabase-profile
  Enter full name: John Doe
  Enter email address: jdoe@example.com
  Enter password/secret: zqxjkh
  Writing profile to 'metabase_id.json'

=head1 USAGE

The metabase-profile program makes it easy to create a user profile for
submitting facts and reports to a Metabase server.

Valid options include:

      --email   ADDRESS   user email address eg "jd@example.com"
      --name    FULLNAME  full user name, eg "John Doe"
  -o, --output  FILENAME  output filename
      --secret  PASSWORD  password for authentication
  -h, --help              print man page

If no output file name is given, the default name 'metabase_id.json' will be
used.  If the the output filename (or default) exists, the program will abort
rather than overwrite the file.  The output file will be in JSON and contain
the user profile and the user's shared secret.

Typically, when a Metabase server first receives a report from a new user
profile, the shared secret is recorded and will be used to authenticate
subsequent submissions.  The output should not be shared publicly or
made group or world readable.

Use the resulting file according to the instructions of your Metabase
client program. You may wish to copy it across computers if you would like
to be identified consistently when submitting reports from different
locations.

=head1 AUTHORS

=over 4

=item *

David Golden <dagolden@cpan.org>

=item *

Ricardo Signes <rjbs@cpan.org>

=item *

H.Merijn Brand <hmbrand@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut


__END__



__END__
:endofperl
