#!/bin/bash -x
set -o nounset
set -o errexit

domain=*.lab.kerz.dev

openssl req \
  -x509 \
  -newkey rsa:4096 \
  -sha256 \
  -days 3650 \
  -nodes \
  -keyout ${domain}.key \
  -out ${domain}.crt \
  -subj "/CN=${domain}"
  #-addext "subjectAltName=DNS:${domain}"
