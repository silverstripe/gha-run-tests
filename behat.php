<?php
// this script will update the modules behat.yml to work with headless chrome
// uses behat_headless.yml as the main behat.yml file,
// and adds in the 'suites' from the module behat.yml
$behatHeadless = trim(file_get_contents('__behat_headless.yml'));
$behat = file_get_contents('__behat.yml');
// Match where suites are defined with additional configuration.
// Matches everything after "suites" before the next property starts.
preg_match("#  suites:(.+?)\n  [a-z]#s", $behat, $matches);
if (!$matches) {
    // Match where a suite name is given as a string or array inline with the suites key
    // e.g. "suites: some-suite" or "suites: []"
    preg_match("#  suites: (.+?)$#s", $behat, $matches);
}
if (!$matches) {
    echo "Could not match suites in behat.yml, cannot run behat\n\n";
    exit(1);
}
$combinedBehat = str_replace('suites: []', 'suites: ' . $matches[1], $behatHeadless);
file_put_contents('__behat.yml', $combinedBehat);
