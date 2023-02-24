# vault-readout
---
[vault-readout.sh](vault-readout.sh) captures a readout of your Vault cluster, including status, secret engines that are enabled, auth methods that are enabled, and usage metrics.

## Prerequisites
Please set the following environment variables prior to running [vault-readout.sh](vault-readout.sh)
* `VAULT_ADDR`
* `VAULT_TOKEN`

## Usage
```
EXPORT VAULT_ADDR=<VAULT_ADDR>
export VAULT_TOKEN=<VAUL_TOKEN>
./vault-readout.sh
```

### Example output:
```
$ ./vault-readout.sh 
VAULT_ADDR: https://vault.home.seva.cafe
Working directory: /tmp/vault-5a05b9aa569c0052b2a3
Getting vault status.
Getting list of secret engines that are enabled and writing them to /tmp/vault-5a05b9aa569c0052b2a3/secrets.json.
Getting list of auth methods that are enabled and writing them to /tmp/vault-5a05b9aa569c0052b2a3/auth.json.
Getting usage metrics and writing them to /tmp/vault-5a05b9aa569c0052b2a3/usage.json.
Creating tar.gz file with information captured:
total 56
-rw-r--r--  1 superstar  superstar  3320 Feb 24 14:18 auth.json
-rw-r--r--  1 superstar  superstar  4293 Feb 24 14:18 secrets.json
-rw-r--r--  1 superstar  superstar   642 Feb 24 14:18 status.json
-rw-r--r--  1 superstar  superstar  8398 Feb 24 14:18 usage.json
a auth.json
a secrets.json
a status.json
a usage.json
Please send /tmp/vault-5a05b9aa569c0052b2a3.tar.gz to your friendly neighborhood HashiCorp SE.
```

---

