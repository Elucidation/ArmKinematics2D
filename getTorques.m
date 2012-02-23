function Torques = getAbsTorques(P)
% Returns Torques on joints due to motor weights on arm

% Motor Weights
% M1 - M6
M = [3.6 3.6 2 2 1.2 1]; % kg

Torques = M.*P;

end