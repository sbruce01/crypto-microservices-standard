#!/bin/bash

if [ $# -eq 1 ]
then
    echo -e 'Starting' $1 'environment...\n'
else
    echo "No argument given - please provide environment name"
    exit
fi
BASE_DIRECTORY=$(cd $(dirname $0) && pwd)
if [ ! -d ${BASE_DIRECTORY}/logs ]
then
	echo "Creating logs directory ${BASE_DIRECTORY}/logs"
	mkdir -p ${BASE_DIRECTORY}/logs
fi

LOG_DIRECTORY=${BASE_DIRECTORY}/logs

#Create the db directory
#sudo su -
#rm -rf db

#if [[ -d $mnt_dir ]]
#then
#    echo "ERROR: db directory already exists - delete as root user and run start.sh again"
#    exit
#fi

echo -e 'Running source ./env...\n'
source ./env.local
source './env_'$1

#Run prepEnv and source each time just in case it's the first run of the day or something has been changed
echo -e 'Running prepEnv...\n'
'./prepEnv_'$1'.sh'

echo "Making and permissioning the db"
mkdir -p $mnt_dir
chmod o+rw $mnt_dir

echo -e 'Check for running qce procs and kill\n'
kill -9 $(ps -ef | grep $1'/kdb-tick' | grep -v grep |  awk '{print $2}')

echo -e 'Starting TP on port '${NODES_PORT}'...\n'



#Navigate into kdb-tick directory to start the TP
cd ./kdb-tick/
q tick.q $1 ./data/tplogs -p ${NODES_PORT} -env $1 > ${LOG_DIRECTORY}/tp.log 2>&1 &

#Move back to directory with the docker-compose files
cd ../

#Start the procs
docker-compose -f 'docker-compose_'$1'_sm.yaml' up -d
docker-compose -f 'docker-compose_'$1'_sg.yaml' up -d
docker-compose -f 'docker-compose_'$1'_da.yaml' up -d

sleep 3

cd kdb-tick
#q feedhandler_ETH.q -env $1 &
#q feedhandler_ETH.q -p 6003 -env $1 >> alchemy.log 2>&1 &
#q feedhandler_allLevels_new.q -env $1 &
#q feedhandler_gda.q -p 6001 -env $1 >> feedhandler_gda.log 2>&1 &

# Sam's local setup
PATH="/home/sbruce1/anaconda3/bin:/home/sbruce1/bin:/home/sbruce1/anaconda3/bin:/home/sbruce1/anaconda3/bin:/home/sbruce1/anaconda3/condabin:$PATH"
#####
q feedhandler_microservicesBitmexBitfinex.q -p 6001 -env $1 > ${LOG_DIRECTORY}/feedhandler_microservices.log 2>&1 &
## Start the CTP GW for processes to query and subscribe to
q ctp_gw.q -p 5555 -env $1 > ${LOG_DIRECTORY}/ctp_gw.log 2>&1 &

cd tick
q wschaintick_0.2.2.q localhost:5010 -p 5110 -t 1000 > ${LOG_DIRECTORY}/wschaintick.log 2>&1 &
cd ../

sleep 3

echo -e '\nRunning processes: \n'
docker ps | grep $1'_'
ps aux | grep $1

cd ../

q gateway.q -p 40002 > ${LOG_DIRECTORY}/gateway.log 2>&1 &

# Starting Dashboards
cd dash
q sample/demo.q -u 1 &
q dash.q -p 10010 -u 1 &
cd ../
