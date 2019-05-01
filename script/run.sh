#!/usr/bin/env bash

##   Retrieve a page of pull requests in the current repository that contain the given commit.   
##  Details: https://docs.atlassian.com/bitbucket-server/rest/6.1.2/bitbucket-rest.html#idp206
echo "Get PRs ==> /rest/api/1.0/projects/${PROJECT_KEY}/repos/${REPOSITORY}/commits/${COMMIT_ID}/pull-requests"
PRS_OF_COMMIT=$(curl -s -u ${USERNAME}:${PASSWORD} ${BB_URL}/rest/api/1.0/projects/${PROJECT_KEY}/repos/${REPOSITORY}/commits/${COMMIT_ID}/pull-requests)

##  If there are PRs associated to that COMMIT_ID, then, filter the PRs by those that match the same BRANCH name and with state OPEN
if [ $(echo ${PRS_OF_COMMIT} | jq '.values | length') -ge 1 ]; then
    echo "Found PR(s) for that commit"
    PR_ID=$(echo ${PRS_OF_COMMIT} | jq --arg BRANCH "refs/heads/$BRANCH" '.values[] | select( ( .fromRef.id == $BRANCH ) and ( .state == "OPEN" ) )' | jq .id )
else
    echo "No Prs found for that commit"
fi

echo "PR_ID is '${PR_ID}'"

## Export the var locally and at CF level
export PR_ID=${PR_ID}
if [ "$CF_URL" != "" ]; then
    cf_export PR_ID
fi

