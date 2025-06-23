## Waiter robot simulation

This project simulates a waiter robot. The robot consists of a 7-DOF robotic arm mounted on a mobile base equipped with 3 omnidirectional wheels.
The robot is capable of navigating an environment using an RRT* planner and reaching a sequence of poses with its arm, while carrying a tray in its hand.

## Requirements

This project was developed using MATLAB and Simulink. 
The following toolboxes are required:

- **Simulink** 
- **Navigation Toolbox** 
- **Mapping Toolbox**
- **Robotics System Toolbox**v


## Project structure

waiter_robot/
├── setup.m # Initializes paths and parameters, run simulink simulation
├── main.m # Main script to start the project
├── readme.txt
├── animations/
│ ├── animation_hold_in_place.m # Animation of the robot holding the tray in place, while the base is moving
│ ├── animation_restaurant.m # Restaurant environment animation
│ └── map/
│ ├── map_builder.m # Generates the map of the environment
│ ├── add_obstacle.m # Adds obstacles to the environment
│ └── add_mannequin.m # Adds mannequins (e.g., human models) 
│ └── actor/ # meshes and URDF files for the animation
├── simulations/
│ └── kinematic_simulation/
│ ├── kinematic_simulation.xlsx # Robot simulation simulink
│ ├── generate_poses_dataset.m # Generates reachable poses for the arm
│ ├── get_chassis_pose_from_endeffector.m # Computes base pose from desired EE pose
│ ├── hat.m # Utility function 
│ ├── inv_hat.m # Utility function 
│ └── path_planning.m # Utility function 


## How to use

To run the project, select the preferred settings in main.m then run the script.

simulation_choice: 
    1 <--- Holding tray in place
    2 <--- Waiter robot in action



[![Guarda il video su YouTube](https://youtu.be/CQSC1y-ab6w)](https://youtu.be/CQSC1y-ab6w)

## Collaborators

- [AndreaVivai](https://github.com/AndreaVivai) – Contributor 
