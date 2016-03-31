#!/bin/bash -e


function install_jq {
  if ! command -v jq >/dev/null 2>&1; then
    echo "installing jq"
    wget http://stedolan.github.io/jq/download/linux64/jq
    chmod +x jq
    sudo cp jq /usr/bin
  fi
}

function submit_job {
  # env variables contain ALL INFO
  local config_template="$1"

  local response=$(envsubst < $config_template |

  curl -sS -i -k -X POST \
  -u $API_USER:$API_PASSWORD \
  -H "Content-Type: application/json" \
  -d @- \
  https://$SERVER/v1/jobs/)

  echo "$response"

  local location=$(echo "$response" | grep Location | tr -d '\r')
  local jobId=$(echo "${location##*/}")
  eval "$2='$jobId'"
}

function get_jobs_matching_criteria {
  local jobId

  local url="https://$SERVER/v1/jobs/${jobId}"

  curl -sS -k -X GET \
  -u $API_USER:$API_PASSWORD \
  -H "Content-Type: application/json" $url > jobs.$$.json

  jobs=(
    $(jq -c '
    .jobs[] 
    | select('"$CRITERIA"') 
    | {id,name}' \
    jobs.$$.json)
  )

  rm -f jobs.$$.json

  echo "Running jobs (appId=$APP_ID): ${#jobs[@]}"
  echo ${jobs[@]} | jq --slurp .
  echo

  # [[ ${#jobs[@]} > 1 ]] && echo "WARNING: More than one running job matched"

  jobIds=( $(echo ${jobs[@]} | jq -r '.id') )

  eval "$1=(${jobIds[@]})"

}

function jobMatchingCriteria {
  local jobId=$1
  local criteria=$2

  local url="https://$SERVER/v1/jobs/${jobId}"
  response=$(curl -sS -k -X GET \
    -u $API_USER:$API_PASSWORD \
    -H "Content-Type: application/json" \
    $url)

  local result=$(echo $response | jq "$criteria")

  [[ $result == "true" ]] && return 0 || return 1
}

function wait_for_job_running {
  local jobId=$1

  # Try for 10 minutes
  local secs=600

  local response

  local url="https://$SERVER/v1/jobs/${jobId}"
  echo "Parse url: $url"

  SECONDS=0   # Reset $SECONDS; counting of seconds will (re)start from 0(-ish).
  while (( SECONDS < secs )); do

    response=$(curl -sS -k -X GET \
      -u $API_USER:$API_PASSWORD \
      -H "Content-Type: application/json" \
      $url)

    local jobStatus=$(echo "$response" | jq -r '.status')

    if [[ $jobStatus == 'JobRunning' ]]; then
      echo "Job successfully running: $jobStatus"
      return 0
    elif [[ $jobStatus != 'JobInProgress' ]]; then
      echo "Job Status failed: $jobStatus"
      return 6
    fi

    echo "Job status: $jobStatus ($(date))"
    sleep 10

  done

  echo "ERROR: Job didn't start in $secs seconds"
  return 5
}