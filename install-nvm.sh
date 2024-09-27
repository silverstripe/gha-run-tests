#!/usr/bin/env bash

wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh
php -r '
    $hash = "faff9a72a1c8a202d6ad9b79e124684a8b128a0b3f44bdff0898bb6f4ca18550178cc7d435cfe10b2cc37396075b338d";
    if (hash_file("sha384", "install.sh") === $hash) {
        echo "Installer verified";
    } else {
        echo "Installer corrupt";
        unlink('install.sh');
    }
    echo PHP_EOL;
'
if [[ ! -f install.sh ]]; then
    echo "Cannot install nvm"
    exit 1
fi
. install.sh
rm install.sh
