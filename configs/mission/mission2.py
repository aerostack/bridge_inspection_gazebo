#!/usr/bin/env python3

import mission_execution_control as mxc
import rospy

def mission():
  print("Starting mission...")

  print("Paying attention to robots...")
  mxc.startTask('PAY_ATTENTION_TO_ROBOT_MESSAGES')

  print("informing position to robots...")
  mxc.startTask('INFORM_POSITION_TO_ROBOTS')

  print("Taking off...")
  mxc.executeTask('TAKE_OFF')

  print("Following path...")
  mxc.executeTask('FOLLOW_PATH', path=[ [-5, 0, 2.3], [-5, 12, 2.3] ])

  print("Informing the other drone...")
  mxc.executeTask('INFORM_ROBOTS', receiver='drone1', message='second_surface_inspection_completed')

  print("Landing...")
  result = mxc.executeTask('LAND')

  print('Mission completed.')

