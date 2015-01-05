#!/bin/bash

# This script unhooks a store and removes it afterwards.
# Optionally it creates a new store again.

CREATE_STORE=0
zadmin=$(which zarafa-admin)

if ! [ -x "$zadmin" ]; then
   echo "error: can not execute zarafa-admin !"
   exit 1
fi

if [[ "$1" == '-c' ]]; then
   CREATE_STORE=1
   shift
fi

if [ -n "$1" ]; then
   USER="$1"
else
   echo "usage: $0 [-c] <user>"
   exit 0
fi

# test account
$zadmin --details $USER &> /dev/null
if [[ "$?" != 0 ]]; then
   echo "error: failed to access user store!"
   exit 1
else
   STOREID=$($zadmin --unhook-store $USER | awk '{ print $6 }')
   $zadmin --remove-store $STOREID
   if [[ "$?" != 0 ]]; then
      echo "error: failed to remove store with ID $STOREID !"
      exit 1
   fi
fi

# create store if requested
if [[ $CREATE_STORE == '1' ]]; then
   $zadmin --create-store $USER
fi

