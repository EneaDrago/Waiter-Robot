function allPoint_clouds = add_obstacle(coord,resolution)
    
% ADD_OBSTACLE adds a point cloud in the shape of a parallelepiped 
% 
% INPUT:
%   coord  - matrix Nx6 with [x1, x2, y1, y2, z1, z2] for each block
%   resolution - of the point cloud

    N = size(coord,1);

    allPoint_clouds = [];

    for i = 1:N
        [xC, yC, zC] = meshgrid(coord(i,1):resolution:coord(i,2), coord(i,3):resolution:coord(i,4), coord(i,5):resolution:coord(i,6));
        cloud = [xC(:), yC(:), zC(:)];
        allPoint_clouds = [allPoint_clouds; cloud];
    end
end

