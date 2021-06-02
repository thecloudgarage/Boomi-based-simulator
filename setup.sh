#!/bin/bash
read -sp "boomiToken: " boomiToken
read -sp "boomiEnvironmentId: " boomiEnvironmentId
mkdir /home/ubuntu/boomi-iot-simulation/boomi_dir
mkdir /home/ubuntu/boomi-iot-simulation/boomi_dir/test
chmod 777 /home/ubuntu/boomi-iot-simulation/boomi_dir/test
cd /home/ubuntu/boomi-iot-simulation
wget docker-compose.yml
sed -i "s/boomiToken/$boomiToken/g" /home/ubuntu/boomi-iot-simulation/docker-compose.yml
sed -i "s/boomiEnvironmentId/$boomiEnvironmentId/g" /home/ubuntu/boomi-iot-simulation/docker-compose.yml
mkdir /home/ubuntu/boomi-iot-simulation
mkdir /home/ubuntu/boomi-iot-simulation/portainer
mkdir /home/ubuntu/boomi-iot-simulation/mosquitto
cd /home/ubuntu/boomi-iot-simulation/mosquitto && wget abc.conf
cd /home/ubuntu/boomi-iot-simulation && docker-compose up -d
