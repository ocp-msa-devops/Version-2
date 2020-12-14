#!/bin/bash

chain_pem="${1}"

if [[ ! -f "${chain_pem}" ]]; then
    echo "Usage: $0 BASE64_CERTIFICATE_CHAIN_FILE" >&2
    exit 1
fi

if ! openssl x509 -in "${chain_pem}" -noout 2>/dev/null ; then
    echo "${chain_pem} is not a certificate" >&2
    exit 1
fi

awk -F'\n' '
        BEGIN {
            showcert = "openssl x509 -noout -subject -issuer -startdate -enddate && echo ''"
        }

        /-----BEGIN CERTIFICATE-----/ {
            printf "%2d: ", ind
        }

        {
            printf $0"\n" | showcert
        }

        /-----END CERTIFICATE-----/ {
            close(showcert)
            ind ++
        }
    ' "${chain_pem}"

