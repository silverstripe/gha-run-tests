<?php
// this script will update the modules behat.yml to work with headless chrome
// uses behat_headless.yml as the main behat.yml file,
// and adds in the 'suites' from the module behat.yml
$a = trim(file_get_contents('__behat_headless.yml'));
$b = file_get_contents('__behat.yml');
preg_match("#(?s)  suites:(.+?)\n  [a-z]#", $b, $m);
if (!$m) {
    preg_match("#(?s)  suites: (.+?)$#", $b, $m);
}
if (!$m) {
    echo "Could not match suites in behat.yml, cannot run behat\n\n";
    die;
}
$c = str_replace('suites: []', 'suites: ' . $m[1], $a);
file_put_contents('__behat.yml', $c);
