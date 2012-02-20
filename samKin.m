L = [5 3]; % link lengths from base to tip
theta = [45 0]; % angles in degrees of joints


c = cosd((theta)); %c1 c12 c123...
s = sind((theta)); %s1 s12 s123...


% Base--joint1-->elbow--joint2-->End_Effector

% Rotation & offset of joint1
T_01 = [c(1) -s(1) 0; ...
        s(1) c(1)  0; ...
        0    0     1];

% Rotation and offset of joint 2
T_12 = [c(2) -s(2) L(1); ...
        s(2) c(2)  0; ...
        0    0     1];

% Offset to End-Effector
T_23 = [1   0   L(2); ...
        0   1   0; ...
        0	0   1];
%

T_02 = T_01*T_12;
T_03 = T_01*T_12*T_23;

base_pos = [0 0 1]';
elbow_pos = T_02 * [0 0 1]';
EE_pos = T_03 * [0 0 1]';

arm = [base_pos elbow_pos EE_pos];

plot(arm(1,:),arm(2,:),'bo-');