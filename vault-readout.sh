#!/bin/bash

if [ -z ${VAULT_ADDR+x} ]
then
  echo "Please see \$VAULT_ADDR environment variable."
  exit 1
else
  echo "VAULT_ADDR: ${VAULT_ADDR}"
fi

if [ -z ${VAULT_TOKEN+x} ]
then
  echo "Please set \$VAULT_TOKEN environment variable."
  echo "Token should have admin permissions."
  exit 1
fi

vault_readout_tmp_dir="/tmp/vault-$(echo $RANDOM | md5sum | head -c 20;)"
if [ -z ${vault_readout_tmp_dir} ]
then
  "Error defining \$vault_readout_tmp_dir."
  exit 1
else
  mkdir -p ${vault_readout_tmp_dir}
  if [ $? -ne 0 ]
  then
    echo "Failed to create \$vault_readout_tmp_dir: ${vault_readout_tmp_dir}."
    exit 1
  else
    echo "Working directory: ${vault_readout_tmp_dir}"
    cd ${vault_readout_tmp_dir}
  fi 
fi

echo "Getting vault status."
vault status -format=json 2>&1 > ${vault_readout_tmp_dir}/status.json
if [ $? -ne 0 ]
then
  echo "Error reading Vault status."
  exit 1
fi

echo "Getting list of secret engines that are enabled and writing them to ${vault_readout_tmp_dir}/secrets.json."
vault secrets list -format=json 2>&1 > ${vault_readout_tmp_dir}/secrets.json
if [ $? -ne 0 ]
then
  echo "Error getting list of secret engines that are enabled."
  exit 1
fi

echo "Getting list of auth methods that are enabled and writing them to ${vault_readout_tmp_dir}/auth.json."
vault auth list -format=json 2>&1 > ${vault_readout_tmp_dir}/auth.json
if [ $? -ne 0 ]
then
  echo "Error getting list of auth methods that are enabled."
  exit 1
fi

echo "Getting usage metrics and writing them to ${vault_readout_tmp_dir}/usage.json."
vault read -format=json  sys/internal/counters/activity 2>&1 > ${vault_readout_tmp_dir}/usage.json
if [ $? -ne 0 ]
then
  echo "Error getting usage metrics."
  exit 1
fi

echo "Creating tar.gz file with information captured:"
ls -l ${vault_readout_tmp_dir}
tar cvfz ${vault_readout_tmp_dir}.tar.gz *json
if [ $? -ne 0 ]
then
  echo "Error creating tar.gz file ${vault_readout_tmp_dir}.tar.gz."
  exit 1
else
  echo "Please send ${vault_readout_tmp_dir}.tar.gz to your friendly neighborhood HashiCorp SE."
fi

