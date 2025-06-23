function chassis_pose = get_chassis_pose_from_endeffector(T_ge, T_ce)
% Returns the chassis pose with respect to the global frame.
%
% INPUT:
%   - T_ge: 4x4 transformation matrix of the EndEffector w.r.t. the global frame
%   - T_ce: 4x4 transformation matrix of the EndEffector w.r.t. the chassis
%
% OUTPUT:
%   - chassis_pose: pose as [x, y, z, qw, qx, qy, qz] (position + orientation in quaternion)


    T_ec = inv(T_ce);
    T_gc = T_ge * T_ec;
    t_gc = T_gc(1:3, 4)';
    R_gc = T_gc(1:3, 1:3);
    q = rotm2quat(R_gc);  % [qw qx qy qz]
    chassis_pose = [t_gc, q];
end
