#!/bin/bash

echo "#############################"
echo "#   add hostname /ets/hosts  #"
echo "#############################"

HOSTNAME='dev.addeos'
HOSTS_LINE='127.0.0.1 dev.addeos'

if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME already exists : $(grep $HOSTNAME /etc/hosts)"
    else
        echo "Adding $HOSTNAME to your /etc/hosts";
        sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

        if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
            then
                echo "$HOSTNAME was added successfully \n $(grep $HOSTNAME /etc/hosts)";
            else
                echo "Failed to Add $HOSTNAME, Try again!";
        fi
fi

echo "#########################################"
echo "#      docker down clean volumes        #"
echo "#########################################"

docker-compose -f docker-compose.mac.yml down -v
docker rm `$(docker ps -a -q) -f`
docker volume prune -f

echo "#####################################"
echo "#      docker up                    #"
echo "#####################################"

sudo sysctl -w vm.max_map_count=262144
docker-compose -f docker-compose.mac.yml up --build -d
