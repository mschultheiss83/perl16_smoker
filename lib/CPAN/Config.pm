# This is CPAN.pm's systemwide configuration file provided for
# ActivePerl. This file provides defaults for users, and the values
# can be changed in a per-user configuration file. The user-config
# file is being looked for as ~/.cpan/CPAN/MyConfig.pm.

my $CPAN_HOME = "$ENV{HOME}/.cpan";
$CPAN_HOME = do {require Config; "$Config::Config{prefix}/cpan"}
    if $^O eq "MSWin32";

my $SHELL = $ENV{SHELL};
$SHELL ||= $ENV{COMSPEC} if $^O eq "MSWin32";

my $PAGER = $ENV{PAGER} || "more";

$CPAN::Config = {
  'auto_commit' => q[0],
  'build_cache' => q[15000],
  'build_dir' => qq[$CPAN_HOME/build],
  'build_dir_reuse' => q[1],
  'build_requires_install_policy' => q[no],
  'cache_metadata' => q[1],
  'check_sigs' => q[0],
  'colorize_output' => q[1],
  'colorize_print' => q[green],
  'colorize_warn' => q[red],
  'commandnumber_in_prompt' => q[1],
  'connect_to_internet_ok' => q[1],
  'cpan_home' => $CPAN_HOME,
  'ftp' => q[],
  'ftp_passive' => q[1],
  'ftp_proxy' => q[],
  'getcwd' => q[cwd],
  'gpg' => q[],
  'gzip' => q[],
  'halt_on_failure' => q[0],
  'histfile' => qq[$CPAN_HOME/histfile],
  'histsize' => q[100],
  'http_proxy' => q[],
  'inactivity_timeout' => q[0],
  'index_expire' => q[1],
  'inhibit_startup_message' => q[0],
  'keep_source_where' => qq[$CPAN_HOME/sources],
  'load_module_verbosity' => q[none],
  'lynx' => q[],
  'make' => q[],
  'make_arg' => q[],
  'make_install_arg' => q[],
  'make_install_make_command' => q[],
  'makepl_arg' => q[INSTALLDIRS=site],
  'mbuild_arg' => q[],
  'mbuild_install_arg' => q[],
  'mbuildpl_arg' => q[--installdirs=site],
  'no_proxy' => q[],
  'pager' => $PAGER,
  'perl5lib_verbosity' => q[none],
  'prefer_external_tar' => q[0],
  'prefer_installer' => q[MB],
  'prefs_dir' => qq[$CPAN_HOME/prefs],
  'prerequisites_policy' => q[follow],
  'scan_cache' => q[never],
  'shell' => $SHELL,
  'show_upload_date' => q[0],
  'tar' => q[],
  'tar_verbosity' => q[none],
  'term_is_latin' => q[1],
  'term_ornaments' => q[1],
  'test_report' => q[1],
  'trust_test_report_history' => q[1],
  'unzip' => q[],
  'urllist' => [q[http://cpan.cpantesters.org/], q[http://www.cpan.org/]],
  'use_sqlite' => q[1],
  'version_timeout' => q[15],
  'wget' => q[],
  'yaml_load_code' => q[0],
  'yaml_module' => q[YAML::XS],
};

if ($^O eq "MSWin32") {
    $ENV{TERM} = "dumb";
    $CPAN::Config->{colorize_output} = eval { require Win32::Console::ANSI };
}
else {
    $CPAN::Config->{mbuild_install_build_command} = './Build install';
}

1;
