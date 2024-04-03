#!/usr/bin/env bash

wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh
php -r '
    $hash = "dd4b116a7452fc3bb8c0e410ceac27e19b0ba0f900fe2f91818a95c12e92130fdfb8170fec170b9fb006d316f6386f2b";
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
