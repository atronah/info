#!/usr/bin/env bash

# example of using
# ./backup.sh atronah_projects https://gitlab.com/api/v4/users/atronah/projects "${OAUTH_TOKEN}" -d per_page=100


BACKUP_NAME="$1"
shift

API_URL="$1"
shift

OAUTH_TOKEN="$1"
shift


if [[ -n $API_RESOURCE ]] ; then
    exit 1
fi

work_dir=${BACKUP_NAME}_$(date +%Y%m%d_%H%M%S)

mkdir $work_dir

pushd $work_dir

for repo_url in $(curl -s -G --header "Authorization: Bearer ${OAUTH_TOKEN}" "${API_URL}" $* | grep -oP '"http_url_to_repo":\s*"\K[^"]*')
do
    echo "======== ${repo_url} ========"

    group_dir=$(basename $(dirname $repo_url))
    repo_dir=$(basename $repo_url)

    git clone --bare "$repo_url" "${group_dir}/${repo_dir}"

    wiki_url=$(dirname $repo_url)/${repo_dir%%.git}.wiki.git
    wiki_repo_dir=$(basename $wiki_url)
    git clone --bare "$wiki_url" "${group_dir}/${wiki_repo_dir}"
done

popd

7z a -sdel "${work_dir}".7z "$work_dir"
