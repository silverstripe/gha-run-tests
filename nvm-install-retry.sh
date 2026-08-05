#!/usr/bin/env bash

# Wrapper for `nvm install` that retries on failure.
#
# nvm resolves loose versions such as "18" by downloading https://nodejs.org/dist/index.tab.
# That download is made with curl in silent mode, so a network blip or a 429 from nodejs.org
# produces an empty version list and nvm exits 3 with a misleading
# "Version '18' not found - try `nvm ls-remote`" message rather than a download error.
#
# Source this file after loading nvm.sh, then call `nvm_install_retry` in place of `nvm install`.
# Any arguments are passed through to `nvm install`.
nvm_install_retry() {
    local attempt
    local attempts=3
    for ((attempt = 1; attempt <= attempts; attempt++)); do
        if nvm install "$@"; then
            return 0
        fi
        echo "nvm install ${*} failed (attempt ${attempt} of ${attempts})"
        if [[ $attempt -lt $attempts ]]; then
            # Show what the remote version list actually did, to distinguish a genuinely
            # missing version from a failed download, then back off before retrying
            nvm ls-remote --no-colors > /dev/null || echo "nvm ls-remote also failed"
            sleep $((attempt * 10))
        fi
    done
    echo "Could not install the node version requested by .nvmrc"
    return 1
}
