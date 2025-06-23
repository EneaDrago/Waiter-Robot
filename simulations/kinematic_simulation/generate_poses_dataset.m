function T_ge_des_dataset = generate_poses_dataset(positions, yaws_deg)
% GENERATE_POSES_DATASET generates a sequence of SE(3) transformations
% for the EndEffector based on positions and yaw angles.
%
% INPUT:
%   - positions: Nx3 matrix of positions [x y z] for each pose
%   - yaws_deg:  Nx1 vector of yaw angles in degrees
%
% OUTPUT:
%   - T_ge_des_dataset: 4x4xN array of homogeneous transformation matrices


    arguments
        positions (:,3) double
        yaws_deg (:,1) double
    end

    num_pose_des = size(positions, 1);
    T_ge_des_dataset = zeros(4, 4, num_pose_des);

    % Build the desired transformations
    for i = 1:num_pose_des
        t = positions(i, :)';
        yaw = deg2rad(yaws_deg(i));
        R = [cos(yaw), -sin(yaw), 0;
             sin(yaw),  cos(yaw), 0;
                  0,        0,    1];
        T = [R, t; zeros(1,3), 1];
        T_ge_des_dataset(:, :, i) = T;
    end
end