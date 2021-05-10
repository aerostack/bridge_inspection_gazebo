#!/bin/bash

DRONE_SWARM_MEMBERS=2
MAV_NAME="hummingbird_adr"
AEROSTACK_PROJECT=${AEROSTACK_STACK}/projects/bridge_inspection_gazebo

if [ -z $DRONE_SWARM_MEMBERS ] # Check if DRONE_SWARM_MEMBERS is NULL
  then
  	#Argument 1 empty
    	echo "-Setting Swarm Members = 1"
    	DRONE_SWARM_MEMBERS=1
  else
    	echo "-Setting DroneSwarm Members = $1"
fi

gnome-terminal  \
  --tab --title "bridge" --command "bash -c \"
  roslaunch ${AEROSTACK_PROJECT}/configs/gazebo_files/launch/suspension_bridge.launch project:=${AEROSTACK_PROJECT};
  exec bash\""  &

gnome-terminal  \
  --tab --title "Spawn_mav1" --command "bash -c \"
  roslaunch rotors_gazebo spawn_mav.launch --wait \
    namespace:=${MAV_NAME}1 \
    mav_name:=$MAV_NAME \
    x:=-1 \
    y:=0 \
    log_file:=${MAV_NAME}1 ; \
  roslaunch rotors_gazebo spawn_mav.launch --wait \
    namespace:=${MAV_NAME}2 \
    mav_name:=$MAV_NAME \
    x:=-5 \
    y:=0 \
    log_file:=${MAV_NAME}2;
  exec bash\""  &
