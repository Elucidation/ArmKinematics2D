function CM = getCenterOfMass(T0)
% Gets Center of Mass of arm based on given cumulative Transform Matrix
% For Schunk 7 joint arm only


% CM = sum(CMi * Mi)/sum(Mi)
%% Motor Weights & Center of Mass
% M1 - M7
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


%% Connector Weights & Center of Mass
% M01 M12 ... M67
Mcon = [0.635 0.635 0.576 0.471 0.420 0.302 0.273]; % kg

% Center of Mass of motors relative to their local frame
CMcon_local = ...
       [    0       -(0.09375 - 0.05022)    -(0.110 -0.05272)   ; ...   % Frame 0
            0       -0.05022                (0.110 -0.05272)    ; ...   % Frame 1
            0       -(0.110 -0.05655)       -0.05313            ; ...   % Frame 2
            0       -0.04463                (0.100-0.04963)     ; ...   % Frame 3
            0       -(0.100 - 0.05329)      -0.04740            ; ...   % Frame 4
            0       -0.03815                (0.080-0.03957)     ; ...   % Frame 5
            0       -(0.080-0.04152)        -0.03913           ];       % Frame 6
%

% CoM of motors in zero (global) frame
CMcon_zero = zeros(4,7);
CMcon_zero(:,1) = [CMcon_local(1,:) 1]';
for i=2:7
    CMcon_zero(:,i) = T0(:,:,i-1) * [CMcon_local(i,:) 1]';
end


%% Calculate Total Center of Mass
% Motors
sumCoM_motors = [0 0 0 0]';
for i=1:7
    sumCoM_motors = sumCoM_motors + CM_zero(:,i)*M(i);
end
% Connectors
sumCoM_con = [0 0 0 0]';
for i=1:7
    sumCoM_con = sumCoM_con + CMcon_zero(:,i)*Mcon(i);
end

CM = (sumCoM_motors+sumCoM_con)/(sum(M)+sum(Mcon));

end