%% Load Data

theta = out.theta.Data;              
theta_time = out.theta.Time;

link_poses = out.link_poses.Data;    
arm_poses = link_poses(:,:,3:end,:);
link_poses_time = out.link_poses.Time; 

chassis_poses = link_poses(:,:,2,:);

theta_wheel_1 = squeeze(out.theta_wheel_1.Data);
theta_wheel_2 = squeeze(out.theta_wheel_2.Data);
theta_wheel_3 = squeeze(out.theta_wheel_3.Data);

T_ge_desired = out.T_ge_desired.Data;  % [4x4xN]

%% Load URDF arm
robot = importrobot('arm.urdf');
robot.DataFormat = 'row';
robot.Gravity = [0 0 -9.81];

figure('Color',[0.7 0.9 1]); % sky
ax = show(robot,theta(1,:), 'PreservePlot', false);
hold on;
grid on;
view(3);
xlabel('X'); ylabel('Y'); zlabel('Z');
zlim([0 inf]);
xlim([-2 2]);
ylim([-2 2]);

%% Lighting
light('Position',[1 3 5],'Style','infinite'); 
lighting gouraud;
material dull;
camlight headlight;

%% Load URDF vehicle
vehicle = importrobot('vehicle.urdf');
vehicle.DataFormat = 'row';
vehicle.Gravity = [0 0 -9.81];
show(vehicle,[0 0 0], 'PreservePlot', false);

%% Ground plane with texture
x_plane = linspace(-2, 8, 2);  
y_plane = linspace(-2, 8, 2);
[X, Y] = meshgrid(x_plane, y_plane);
Z = zeros(size(X));

if exist('marmo.png','file')
    ground_img = imread('marmo.png');
    surface(ax, X, Y, Z, ...
        'FaceColor', 'texturemap', ...
        'CData', ground_img, ...
        'EdgeColor', 'none');
else
    surf(X, Y, Z, 'FaceColor', [0.4 0.26 0.13], 'EdgeColor', 'none');
end

%% Simulation speed
sim_speed = 20;

%% EndEffector Trajectory
ee_traj = [];
traj_dyn_colors = jet(length(theta_time));


%% Plot EE desired frame
T_des = T_ge_desired(:,:,:);
origin = T_des(1:3,4)';
x_axis = T_des(1:3,1)';
y_axis = T_des(1:3,2)';
z_axis = T_des(1:3,3)';
scale = 0.2;

% Rimuovi eventuali vecchi frame per evitare accumulo
if exist('h_desired_frame', 'var')
    delete(h_desired_frame);
end

h_desired_frame(1) = quiver3(origin(1), origin(2), origin(3), ...
    scale*x_axis(1), scale*x_axis(2), scale*x_axis(3), ...
    'Color', 'r', 'LineWidth', 2);

h_desired_frame(2) = quiver3(origin(1), origin(2), origin(3), ...
    scale*y_axis(1), scale*y_axis(2), scale*y_axis(3), ...  
    'Color', 'g', 'LineWidth', 2);

h_desired_frame(3) = quiver3(origin(1), origin(2), origin(3), ...
    scale*z_axis(1), scale*z_axis(2), scale*z_axis(3), ...
    'Color', 'b', 'LineWidth', 2);

%% Time Text
time_text = text(ax, 0, 0, 1.5, '', 'FontSize', 14, 'Color', 'w', ...
    'FontWeight', 'bold', 'BackgroundColor', [0 0 0 0.5]);

% pause(20)

%% Animation loop
for i=1:10:length(theta_time)

    current_time = theta_time(i);
    
    T_ee = arm_poses(:,:,end,i);
    ee_pos = T_ee(1:3,4)';
    ee_traj = [ee_traj; ee_pos];

    T_chassis = chassis_poses(:, :, i);
    x = T_chassis(1, 4);
    y = T_chassis(2, 4);
    z = T_chassis(3, 4);
    yaw = atan2(T_chassis(2,1), T_chassis(1,1));

    Position = [x, y, z, yaw];

    show(robot, theta(i,:), 'PreservePlot', false, 'Parent', ax, 'Frames','on', ...
        'Visuals','on', 'Position', Position);

    show(vehicle, [theta_wheel_1(i) theta_wheel_2(i) theta_wheel_3(i)], ...
        'PreservePlot', false, 'Parent', ax, 'Frames','off', ...
        'Visuals','on', 'Position', Position);

        % trajectory plot
    if i > 2000
        plot3(ee_traj(end-1:end,1), ee_traj(end-1:end,2), ee_traj(end-1:end,3), ...
            'Color', traj_dyn_colors(i,:), 'LineWidth', 2);
        set(time_text, 'Position', ee_pos + [0 0 1], 'String', sprintf('Time: %.1fs', current_time-20));
    end

    

    drawnow;
    
    if i < length(theta_time)
        pause((theta_time(i+1)-theta_time(i)) / sim_speed);
    end

end