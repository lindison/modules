#!/bin/bash
run_do()
{
for server in $SVRS
do
  echo $SVR$server
  TMP=$DIR/${SVR}${server}
  TMPOUT=$DIR/${SVR}${server}.out
  vmware-cmd --server esxvc-ga-msdc01.ds.dtveng.net --username $OS_USERNAME --password $OS_PASSWORD \
	--vihost ${SVR}${server}.ds.dtveng.net -l >${TMP}
  #grep cqjw ${TMP}|awk -F/ '{print $5}' >>${TMPOUT}
  for node in `grep cqjw ${TMP}|awk -F/ '{print $5}'`
      do 
	 JOBDIR=$CQRTMPNEW
         JOBID=`cd $CQRTMPNEW/;grep -l $node *`
         if [ X$JOBID = X ]
	 then
		JOBID=`cd $CQRTMP/;grep -l $node *`
		JOBDIR=$CQRTMP
         fi
         if [ X$JOBID != X ]
	 then
            STATUS=`jq -r .status $JOBDIR/$JOBID`
	    environment=`jq -r .environment $JOBDIR/$JOBID`
	    appName=`jq -r .appName $JOBDIR/$JOBID`
	    appId=`jq -r .appId $JOBDIR/$JOBID`
         else
            STATUS=Null
	    environment=Null
	    appName=Null
	    appId=Null
	 fi
	 #read
         echo $SVR$server,$node,$JOBID,$STATUS,$environment,$appName,$appId,`grep $node /tmp/list|awk '{print $1 "," $3}'`
         echo $SVR$server,$node,$JOBID,$STATUS,$environment,$appName,$appId,`grep $node /tmp/list|awk '{print $1 "," $3}'` >>$FOUNDLIST
      done
done
}

echo run this command on a different windows ssh -L3306:localhost:3306 ccm
CQRTMP=/tmp/cliqr.jobs.8800
DIR=~/.cqlist
#cp -rp /tmp/cliqr.jobs.8800 ~/.cqlist
mkdir -p $DIR
FOUNDLIST=$DIR/found.txt
rerun cliqrapp: jobs >$DIR/jobs.list
CQRTMPNEW=/tmp/`ls -tr /tmp/|grep cliqr.jobs.|tail -1`
echo Enter to continue
mysql --raw --skip-column-names -h 127.0.0.1 -u osmosix -posmosix -e 'SELECT jobId,nodeId,status from NODE_STATUS' osmosixdb |cat >$DIR/list
#>$FOUNDLIST
echo server,node,JOBID,STATUS,environment,appName,appId,DB_JOBID,DB_Status
echo server,node,JOBID,STATUS,environment,appName,appId,DB_JOBID,DB_Status >$FOUNDLIST
echo EE-POP
SVRS="01 02 03 04 17 18 19 20 33 34 35 36 49 50 51 52"
SVR=esxccbga1msdc
run_do
echo EE-POP2
SVRS="05 06 07 08 21 22 23 24 37 38 39 40 53 54 55 56"
SVR=esxccbga1msdc
run_do
echo EE-POP
SVRS="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16"
SVR=esxccbga2msdc
run_do
cat $FOUNDLIST
