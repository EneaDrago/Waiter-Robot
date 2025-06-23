% ================================================
% Add relevant paths
% ================================================
addpath(genpath('animations'));
addpath(genpath('simulations'));
addpath(genpath('simulations/kinematic_simulation'));
addpath(genpath('animations/Actor'));
addpath(genpath('animations/map'));
load("shop.mat", "shop");

% ================================================
% Arm parameters definition
% ================================================
theta_arm_initial = [0; 0; 0.3; 0.1; 0.1; 0; 0];
links_arm_length = [0.12; 0.11; 0.42; 0.11; 0.42; 0.11; 0.085]; % Link lengths [m]

% ================================================
% Vehicle parameters definition
% ================================================
chassis_height = 0.05207; % [m]
chassis_position_initial = [0; 0; chassis_height];
alpha_roller = pi/10; % [rad] angle roller long. axis - wheel long. axis
d_wheel_g = 0.185;    % [m] distance center of wheel-G 
r_wheel = 0.025;      % [m] wheel radius

% ================================================
% EndEffector desired pose
% ================================================
% Rest pose configuration (while the vehicle is moving)
t_ce_rest = [0;  0;  0.6]; % [m]
R_ce_rest = eye(3);
T_ce_rest = [R_ce_rest, t_ce_rest; zeros(1,3), 1];

% Customer reach configuration dataset
% Each row is a pose that the endeffector have to reach
t_ge_des_dataset = [
    0.5  0.5  1;
    1.5  2.0  1;
    4.5  5.5  1
]; %[x    y   z] % [m]

yaw_ge_des_dataset = [
    90;
    30;
    45
]; % [rad]

T_ge_des_dataset = generate_poses_dataset(t_ge_des_dataset, yaw_ge_des_dataset);

% Arm rest configuration
T_ge_static = [1 0 0   0;
               0 1 0   0;
               0 0 1 0.8;
               0 0 0   1]; % [m]

% ================================================
% Car path planning
% ================================================
% Map parameters
omap = shop;
omap.FreeThreshold = 0.5;
inflate(omap, 0.25);
% Generate the waypoints from RRT*
[waypoints,Tree_expansion] = path_planning(T_ge_des_dataset, T_ce_rest, omap);
save('simulations/kinematic_simulation/waypoints_restaurant.mat','waypoints');
load('waypoints_restaurant.mat');

% ================================================
% Simulink simulation 
% ================================================
Simulation_Time = 30; % [sec]
simulation_time_step = 0.01; %[sec] fixed step
out = sim('simulations/kinematic_simulation/kinematics_simulation.slx', Simulation_Time);

