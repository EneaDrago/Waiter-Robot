%-----------------------%
% CREATE A 3D OCCUPANCY MAP 
%-----------------------%

shop = occupancyMap3D(20); 

resolution = 0.009;

%% Add a row for each block. The order is [x1 x2 y1 y2 z1 z2]
coord = [1.75 2.25 0.25 0.75 0 1;
         2.25 2.75 0.25 0.75 0 1;
         1.25 1.75 1.25 1.75 0 1;
         3.25 3.75 1.25 1.75 0 1;
         0.75 1.25 1.75 2.25 0 1;
         0.25 0.75 3.25 3.75 0 1;
         2.75 3.25 3.25 3.75 0 1;
         3.75 4.25 3.25 3.75 0 1;
         1.25 1.75 3.75 4.25 0 1;
         1.25 1.75 4.75 5.25 0 1;
         3.75 4.25 4.75 5.25 0 1;
         4.75 5.25 4.75 5.25 0 1;
         3.75 4.25 5.75 6.15 0 1;
         ];

allPoint_clouds = add_obstacle(coord, resolution);

%% Insert the point cloud into the map
insertPointCloud(shop, [0 0 0 1 0 0 0], allPoint_clouds, 1000); 

% Show the map
figure;
grid on
show(shop);
title("3D MAP");

% Save on file
save("shop.mat", "shop");
