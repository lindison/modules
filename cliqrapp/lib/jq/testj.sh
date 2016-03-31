. jobs_util.sh

export SLAVE=204
export MASTER=149
export DTV_ENV=pi8

export API_USER=jenkins_3
export API_PASSWORD=F8A171B7B62767AC
export SERVER=cliqrmee-msdc01.ds.dtveng.net
export APP_ID=$MASTER
export CRITERIA='.status == "JobRunning" and .appId == "'$APP_ID'"'

get_jobs_matching_criteria jobIds

