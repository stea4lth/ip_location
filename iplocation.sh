#!/bin/bash

# Copyright (c) 2023, Christopher Nowlan
# This script is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this script; if not, write to the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

# Check if curl is installed
if ! command -v curl &> /dev/null
then
    echo "curl could not be found. Please install it first."
    exit
fi

# Check input argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [IP address or domain]"
    exit 1
fi

IP_OR_DOMAIN="$1"

# If it's a domain and doesn't start with http:// or https://, prepend https://
if [[ ! "$IP_OR_DOMAIN" =~ ^http:// ]] && [[ ! "$IP_OR_DOMAIN" =~ ^https:// ]]; then
    IP_OR_DOMAIN="https://$IP_OR_DOMAIN"
fi

DATA=$(curl -s "http://ipinfo.io/${IP_OR_DOMAIN}/json")

CITY=$(echo "$DATA" | jq -r '.city')
REGION=$(echo "$DATA" | jq -r '.region')
COUNTRY=$(echo "$DATA" | jq -r '.country')

echo "City: $CITY"
echo "State/Region: $REGION"
echo "Country: $COUNTRY"
