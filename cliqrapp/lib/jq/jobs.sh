#!/bin/bash -e

# jobs.json is made (probably using curl)

. jobs_util.sh

SLAVE=204
MASTER=149
DTV_ENV=pi8

TOMCAT_APP_ID=111
#roller_deployment_tomcat
TIER_ID_TOMCAT=112
#AppCluster
TIER_ID_FMW=113
#FMW
FMW_APP_ID=114
#roller_deployment_fmw
`
#API_USER=cliqradmin
#API_PASSWORD=373A0E355AD94039
#SERVER=saad.cliqrtech.com
API_USER=jenkins_3
API_PASSWORD=F8A171B7B62767AC
SERVER=cliqrmee-msdc01.ds.dtveng.net

function get_existing_fmw_job_id {
  local jobId

  APP_ID=$FMW_APP_ID \
  CRITERIA='.status == "JobRunning" and .appId == "'$FMW_APP_ID'"' \
  get_jobs_matching_criteria jobIds

  local jobCriteria='.parameters.appParams[] | select(.name == "dtvEnvironment").value == "'$DTV_ENV'"'
  for jobId in ${jobIds[@]}; do
    if jobMatchingCriteria $jobId "$jobCriteria"; then
      echo "Job $jobId matches criteria"
      eval "$1='$jobId'"
      break
    fi
  done
}

function start_fmw {
  local job_id

  APP_ID="$FMW_APP_ID" \
  JOB_NAME="FMW_DB_API_$$_ENV_$DTV_ENV" \
  DTV_ENV="$DTV_ENV" \
  submit_job ./launch_fmw.json job_id

  echo "FMW job successfully submitted: $job_id"
  eval "$1='$job_id'"
} 

function start_tomcat_app {
  local fmwJobId=$1

  local job_id

  APP_ID=$TOMCAT_APP_ID \
  TIER_ID_TOMCAT=$TIER_ID_TOMCAT \
  TIER_ID_FMW=$TIER_ID_FMW \
  JOB_NAME="Tomcat_API_$$_ENV_$DTV_ENV" \
  REFERRED_JOB="$fmwJobId" \
  submit_job ./launch_tomcat.json job_id

  echo "Job successfully submitted: $job_id"
  eval "$2='$job_id'"
}

#install_jq

get_existing_fmw_job_id fmwJobId

if [[ -z $fmwJobId ]]; then
  echo "No matching job found"

  start_fmw fmwJobId
  [[ -z $fmwJobId ]] && echo "Error: FMW couldn't start" && exit 2

  wait_for_job_running $fmwJobId || exit 3
fi

echo "Got FMW JobId: $fmwJobId"

start_tomcat_app $fmwJobId tomcatJobId
