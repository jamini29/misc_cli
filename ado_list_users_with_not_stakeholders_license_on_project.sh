#!/bin/bash

#set -xve
set -e

organization='https://dev.azure.com/hyperspace-pipelines/'
project='AssetPerformanceManagement'
#project='business-process-insights'

echo "Organization: ${organization}"
echo "Project: ${project}"


echo "-- Authorize:"

echo ${ADO_AMINICH_PAT} | az devops login --org ${organization}

echo "-- List projects security groups, collect members:"
emails=()
#declare -A sec_groups

while IFS=$'\t' read -r name descriptor; do
        echo -n "  Group: \"${name}\""

        count=0
        while read -r email; do
                count=$((count+1))
                emails+=($email)
        done < <(az devops security group membership list \
                --org ${organization} \
                --id ${descriptor} \
                --query "@.* | [? subjectKind=='user' && metaType!=null && mailAddress!='azureprod@global.corp.sap' && mailAddress!='azuretest@global.corp.sap'].[mailAddress]" \
                --output tsv)
        .
        echo ", members collected: ${count}"
done < <(az devops security group list \
        --org ${organization} \
        --project=${project} \
        --query "graphGroups[? isCrossProject==null && isDeleted==null].[displayName, descriptor]" \
        --output tsv)

echo -e "\n  Total collected: ${#emails[@]}"

unique_emails=($(echo "${emails[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
echo "  Sorted unique emails: ${#unique_emails[@]}"

echo "-- Search for users with a license other than 'Stakeholder'.:"
echo "-----------"
for email in ${unique_emails[@]}; do
        IFS=$'\t' read -r email sapid name license <<< $(az devops user show \
                --org ${organization} \
                --user ${email} \
                --query "[[user.mailAddress, user.directoryAlias, user.displayName, accessLevel.licenseDisplayName]]" \
                --output tsv)

        if [[ ${license} == 'Stakeholder' ]]; then continue; fi
        echo "${name} (${sapid}), ${email}, license type: ${license}"
done
echo "-----------"

#echo "-- Terminate session"
#az devops logout --org ${organization}
