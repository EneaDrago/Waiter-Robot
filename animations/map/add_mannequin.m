function add_mannequin(ax, positions, urdf_file)
% ADD_MANNEQUIN adds rigid mannequins to the scene
% 
% INPUT:
%   ax         - figure axis handles (where to draw the mannequins)
%   positions  - matrix Nx4 with [x, y, z, yaw] for each mannequins
%   urdf_file  - URDF file name (optional, default: 'mannequin_dish.urdf')

    if nargin < 3
        urdf_file = 'mannequin_urdf.urdf';
    end

    N = size(positions, 1);

    for i = 1:N
        mannequin = importrobot(urdf_file);
        mannequin.DataFormat = 'row';
        mannequin.Gravity = [0 0 -9.81];

        pos = positions(i, :); % [x y z yaw]

        show(mannequin, zeros(1,0), ...
            'PreservePlot', false, ...
            'Parent', ax, ...
            'Frames', 'off', ...
            'Visuals', 'on', ...
            'Position', pos);

    end
end
