function CM = getCenterOfMass(T0)
% Gets Center of Mass of arm based on given cumulative Transform Matrix
% For Schunk 7 joint arm only


% CM = sum(CMi * Mi)/sum(Mi)

% Motor Weights
% M1 - M6
M = [3.6 3.6 2 2 1.2 1.2 1]; % kg

% Center of Mass of motors relative to their local frame
CM_local = [    0       0       (0.110 + 0.0821 - 0.008)    ; ...   % Frame 1
            0       0                   0               ; ...   % Frame 2
            0       0       (0.100 + 0.059 - 0.008)     ; ...   % Frame 3
            0       0                   0               ; ...   % Frame 4
            0       0       (0.080 + 0.0535 - 0.008)    ; ...   % Frame 5
            0       0                   0               ; ...   % Frame 6
            0       0           (0.050 - 0.0068)       ];       % Frame 7
%

% CoM of motors in zero (global) frame
CM_zero = zeros(4,7);
for i=1:7
    CM_zero(:,i) = T0(:,:,i) * [CM_local(i,:) 1]';
end

sumCoM_motors = [0 0 0 0]';
for i=1:7
    sumCoM_motors = sumCoM_motors + CM_zero(:,i)*M(i);
end

CM = sumCoM_motors/sum(M);

end