clear
clc
close all

% ================================================
% CHOOSE THE PREFERRED PARAMETERS
% ================================================
% simulation_choice = ...
%     1 <--- Holding tray in place
%     2 <--- Waiter robot in action

simulation_choice = 2;

% Do you want to run the animation?
run_animation = true;

% ================================================
% Launch setup
% ================================================
setup;

% ================================================
% Animation 
% ================================================
if run_animation && simulation_choice == 1
    animation_hold_in_place;
end

if run_animation && simulation_choice == 2
    animation_restaurant;
end