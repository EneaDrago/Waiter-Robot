## Click to see the YouTube video
[![YouTube](https://img.youtube.com/vi/CQSC1y-ab6w/0.jpg)](https://www.youtube.com/watch?v=CQSC1y-ab6w)


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

```
waiter_robot/
├── setup.m                        # Initializes paths and parameters, runs Simulink simulation
├── main.m                         # Main script to start the project
├── animations/
│   ├── animation_hold_in_place.m # Robot holds the tray while the base moves
│   ├── animation_restaurant.m    # Restaurant environment animation
│   └── map/
│       ├── map_builder.m         # Generates the environment map
│       ├── add_obstacle.m        # Adds obstacles to the environment
│       ├── add_mannequin.m       # Adds mannequins (e.g., human models)
│       └── actor/                # Meshes and URDF files
├── simulations/
│   └── kinematic_simulation/
│       ├── kinematic_simulation.xlsx        # Simulink model
│       ├── generate_poses_dataset.m         # Generates reachable poses
│       ├── get_chassis_pose_from_endeffector.m # Computes base pose from EE pose
│       ├── hat.m                            # Utility function
│       ├── inv_hat.m                        # Utility function
│       └── path_planning.m                  # Utility function
```

## How to use

To run the project:

- Open the file `main.m` in MATLAB.
- Select the simulation mode by setting the following variable:

  ```matlab
  simulation_choice = 1;  % Holding tray in place
  simulation_choice = 2;  % Waiter robot in action
  ```

- Run the script to start the simulation.

## Collaborators

- [AndreaVivai](https://github.com/AndreaVivai) – Contributor 
