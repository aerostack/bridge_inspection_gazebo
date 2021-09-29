#!/bin/bash

NUMID_DRONE=2
NETWORK_ROSCORE=$1
SESSION=$USER
UAV_MASS=1.5
NAMESPACE=drone

mv $AEROSTACK_WORKSPACE/develIgnore $AEROSTACK_WORKSPACE/devel
export APPLICATION_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Create new session  (-2 allows 256 colors in the terminal, -s -> session name, -d -> not attach to the new session)
tmux -2 new-session -d -s main_launcher2

# Create one window per roslaunch (-t -> target session , -n -> window name) 
tmux new-window -t main_launcher2:1 -n 'viewer + teleop'
tmux send-keys "roslaunch alphanumeric_viewer alphanumeric_viewer.launch --wait \
    drone_id_namespace:=$NAMESPACE$NUMID_DRONE \
    my_stack_directory:=${APPLICATION_PATH}" C-m
            
tmux new-window -t main_launcher2:2 -n 'pixhawk interface'
tmux send-keys "roslaunch pixhawk_interface pixhawk_interface.launch \
--wait namespace:=$NAMESPACE$NUMID_DRONE acro_mode:=false simulation_mode:=true fcu_url:=udp://:14541@localhost:14581 tgt_system:=$NUMID_DRONE" C-m

tmux new-window -t main_launcher2:3 -n 'Basic Quadrotor Behaviors'
tmux send-keys "roslaunch basic_quadrotor_behaviors basic_quadrotor_behaviors.launch --wait \
  namespace:=$NAMESPACE$NUMID_DRONE" C-m

tmux new-window -t main_launcher2:4 -n 'Quadrotor Motion With PID Control'
tmux send-keys "roslaunch quadrotor_motion_with_pid_control quadrotor_motion_with_pid_control.launch --wait \
    namespace:=$NAMESPACE$NUMID_DRONE \
    robot_config_path:=${APPLICATION_PATH}/configs/drone$NUMID_DRONE \
    uav_mass:=$UAV_MASS" C-m

tmux new-window -t main_launcher2:5 -n 'Swarm behaviors'
tmux send-keys "roslaunch swarm_interaction swarm_interaction.launch --wait \
  namespace:=$NAMESPACE$NUMID_DRONE" C-m

#tmux new-window -t main_launcher2:6 -n 'GroundTruth Gazebo'
#tmux send-keys "rosrun topic_tools relay /drone${NUMID_DRONE}/mavros/local_position/pose /drone${NUMID_DRONE}/self_localization/pose & \
#rosrun topic_tools relay drone${NUMID_DRONE}/mavros/local_position/velocity_local /drone${NUMID_DRONE}/self_localization/speed" C-m

tmux new-window -t main_launcher2:7 -n 'Throttle_Controller'
tmux send-keys "roslaunch thrust2throttle_controller thrust2throttle_controller.launch --wait \
  namespace:=$NAMESPACE$NUMID_DRONE \
  uav_mass:=$UAV_MASS" C-m

tmux new-window -t main_launcher2:8 -n 'Python interpreter'
tmux send-keys "roslaunch python_based_mission_interpreter_process python_based_mission_interpreter_process.launch --wait \
  drone_id_namespace:=$NAMESPACE$NUMID_DRONE \
  drone_id_int:=$NUMID_DRONE \
  my_stack_directory:=${APPLICATION_PATH} \
  mission:=mission2.py \
  mission_configuration_folder:=${APPLICATION_PATH}/configs/mission" C-m

tmux new-window -t main_launcher2:9 -n 'Behavior Coordinator'
tmux send-keys "roslaunch behavior_coordinator behavior_coordinator.launch --wait \
  robot_namespace:=$NAMESPACE$NUMID_DRONE \
  catalog_path:=${APPLICATION_PATH}/configs/mission/behavior_catalog.yaml" C-m

tmux new-window -t main_launcher2:10 -n 'Camera Raw'
tmux send-keys "rqt_image_view /iris_1/usb_cam/image_raw" C-m

tmux attach-session -t main_launcher2:1
