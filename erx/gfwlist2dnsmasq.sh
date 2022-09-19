#!/usr/bin/env bash
# -*- coding: utf-8 -*-

GFW_RAW_FILE="./gfwlist.txt"
GFW_DECODED_FILE="./gfwlist.decoded.txt"

DNS_SERVER="1.1.1.1"
CN_DNS_SERVER="114.114.114.114"


update_gfwlist_file() {
  if [ -f $GFW_DECODED_FILE ]; then
    # TODO: check expiration
    return
  fi
  # ensure gfwlist.txt existance
  if [ ! -f $GFW_RAW_FILE ]; then
    # Fetch latest gfwlist file
    # See https://github.com/gfwlist/gfwlist
    curl -O https://pagure.io/gfwlist/raw/master/f/gfwlist.txt
  fi
  base64 -d $GFW_RAW_FILE > $GFW_DECODED_FILE
}



update_gfwlist_file

# you can add any domains you want to bypass here
custom_domains=(
  
)

declare -A domains

for domain in ${costom_domains[@]}; do
    domains[$domain]=1
done

while read -r line; do
    # !comment
    if [[ $line =~ ^!.* ]] ; then
      echo "comment line. skipping"
      continue
    fi

    # @@||domain
    if [[ $line =~ ^@@\|\|(.*) ]]; then
      domain="${BASH_REMATCH[1]}"
      echo "double whitelist $domain found"
      continue
    fi

    # ||domain
    if [[ $line =~ ^\|\|(.*) ]]; then
      domain="${BASH_REMATCH[1]}"
      echo "double $domain found"
      domains[$domain]=1
      continue
    fi

    # @|domain
    if [[ $line =~ ^@@\|(.*) ]]; then
      domain="${BASH_REMATCH[1]}"
      echo "single whitelist $domain found"
      continue
    fi

    # |domain
    if [[ $line =~ ^\|(.*) ]]; then
      domain="${BASH_REMATCH[1]}"
      echo "single $domain found"
      domains[$domain]=1
      continue
    fi

done < $GFW_DECODED_FILE

OUTPUT_FILE="./dist/dnsmasq-gfwlist-dns.conf"
IPSET_FILE="./dist/dnsmasq-gfwlist-ipset.conf"

for domain in "${!domains[@]}"; do
    echo "server=/$domain/$DNS_SERVER" >> $OUTPUT_FILE
    echo "ipset=/$domain/gfwlist" >> $IPSET_FILE
done
