# Application: bridge_inspection_gazebo

This application illustrates how two drones inspects a bridge each from a different side. During the mission execution, it is possible to pause and continue the mission execution. While the mission is executing, the drones explores and notify when the inspection is done.

In order to execute the mission, perform the following steps:

- Execute the script that launches Gazebo for this project:

        $ ./launcher_gazebo.sh


- Wait until the following window is presented:

<img src="https://github.com/aerostack/bridge_inspection_gazebo/blob/master/doc/gazebobridge.png" width=600>

- Execute the script that launches the Aerostack components for this project:

        $ ./main_launcher.sh

As a result of this command, a set of windows are presented to monitor the execution of the mission. These windows include:
- Belief viewer
- Lidar mapping
- View of the cameras

In order to start the execution of the mission, execute the following commands:

	$ rosservice call /drone111/python_based_mission_interpreter_process/start
	$ rosservice call /drone112/python_based_mission_interpreter_process/start

The following video illustrates how to launch the project:

[ ![Launch](https://i.ibb.co/dMQkBCZ/launchbridge.png)](https://youtu.be/gAgD24DToro)

The following video shows the complete execution with the image of the front camera:

[ ![Execution](https://i.ibb.co/59ZkFLq/exebridge.png)](https://youtu.be/-OT8aXepNZI )


