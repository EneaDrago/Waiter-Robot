function [waypoints,Tree_expansion] = path_planning(T_ge_des_dataset, T_ce_rest, omap)
% PATH_PLANNING Plans a path between a sequence of end-effector poses
% using RRT* and returns all concatenated waypoints.
%
% INPUT:
%   - T_ge_des_dataset: 4x4xN array of desired end-effector poses
%   - T_ce_rest: rigid transformation from the end-effector center to the chassis
%   - omap: 3D occupancy map (occupancyMap3D object)
%
% OUTPUT:
%   - waypoints: Mx7 matrix of concatenated waypoints in SE(3)
%   - Tree_expansion: structure containing all the tree nodes explored

    arguments
        T_ge_des_dataset (4,4,:) double
        T_ce_rest (4,4) double
        omap (1,1) occupancyMap3D
    end

    % Setup the state space and validator
    ss = stateSpaceSE3([0 10; 0 10; 0.1 0.1; inf inf; inf inf; inf inf; inf inf]);
    sv = validatorOccupancyMap3D(ss, Map = omap, ValidationDistance = 0.01);

    % Configure the RRT* planner
    planner = plannerRRTStar(ss, sv, ...
        MaxConnectionDistance = 1, ...
        MaxIterations = 10000, ...
        GoalReachedFcn = @(~,s,g)(norm(s(1:3)-g(1:3)) < 0.1), ...
        GoalBias = 0.9);

    % Fix the random seed for reproducibility
    rng(1, "twister");

    % Plan path between each pair of consecutive poses
    num_poses = size(T_ge_des_dataset, 3);
    waypoints = [];
    TreeData_all = []; 

    for i = 1:num_poses-1
        T_start = T_ge_des_dataset(:, :, i);
        T_goal = T_ge_des_dataset(:, :, i+1);

        % Compute chassis poses from the end-effector poses
        start = get_chassis_pose_from_endeffector(T_start, T_ce_rest);
        goal  = get_chassis_pose_from_endeffector(T_goal,  T_ce_rest);

        % Perform planning
        [pthObj, Tree] = plan(planner, start, goal);
        shortenedPath = shortenpath(pthObj, sv);
        TreeData_all = [TreeData_all; Tree.TreeData];

        % Append the path states (avoid duplicating points)
        if isempty(waypoints)
            waypoints = shortenedPath.States;
        else
            waypoints = [waypoints; shortenedPath.States(2:end, :)];
        end

        show(omap); 
        hold on; 
        axis equal;
        scatter3(start(1),start(2),start(3),"g","filled","LineWidth",7)
        scatter3(goal(1),goal(2),goal(3),"r","filled","LineWidth",7)
        plot3(shortenedPath.States(:,1),shortenedPath.States(:,2),shortenedPath.States(:,3),"b-",LineWidth=2)
        plot3(Tree.TreeData(:,1),Tree.TreeData(:,2),Tree.TreeData(:,3),'.-')
        grid on
        set(gca, 'FontSize', 18, ...
            'TickLabelInterpreter', 'latex', ...
            'XAxisLocation', 'origin', ...
            'YAxisLocation', 'origin', ...
            'Box', 'off', ...              % Rimuove i bordi
            'Layer', 'top', ...            % Porta gli assi in primo piano
            'LineWidth', 0.1, ...          % Aumenta lo spessore degli assi
            'GridAlpha', 0.1, ...          % Riduce la trasparenza della griglia
            'GridLineStyle', '-');

        xlabel('$x$ [m]', 'Interpreter', 'latex', 'FontSize', 22, ...
            'Units', 'normalized') 
        ylabel('$y$ [m]', 'Interpreter', 'latex', 'FontSize', 22, ...
            'Units', 'normalized', ...
            'Rotation', 0)     
         zlabel('$z$ [m]', 'Interpreter', 'latex', 'FontSize', 22, ...
            'Units', 'normalized', ...
            'Rotation', 0)     
        axis tight
    end

    Tree_expansion = struct('TreeData', TreeData_all);
end
