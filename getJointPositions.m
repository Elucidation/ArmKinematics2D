function P = getJointPositions(thetas)
% Given 7 thetas
% Returns position of base and 7 joints (only 5 displacements)

% link lengths from base to tip
% [ L12 L34 L56 L7 ]
L = [0.250 0.328 0.2765 0.171]; % m

% Motor Weights
% M1 - M6
M = [3.6 3.6 2 2 1.2 1]; % kg

% Theta cos/sin's
c = cosd(thetas); %c1 c2 c3 ...
s = sind(thetas); %s1 s2 s3 ...

% Transform Matrices
% [T_01 T_12 T_23 T_34 T_45 T_56 T_67]
T = zeros(4,4,7);
% T(:,:,1) = T_01
% T(:,:,2) = T_12
% ...
for i = 1:7
    % Odds % T_01 T_23 T_45 T_67
    if (mod(i,2)~=0) 
        T(:,:,i) = [c(i)    -s(i)   0       0     ; ...
                    0       0       1       -L(ceil(i/2)) ; ...
                    -s(i)   -c(i)   0       0     ; ...
                    0       0       0       1    ];
    % Evens % T_12 T_34 T_56
    else
        T(:,:,i) = [c(i)    -s(i)   0       0     ; ...
                    0       0       -1      0     ; ...
                    s(i)	c(i)	0       0     ; ...
                    0       0       0       1    ];
    end
end

% Base to x Transform Matrices
% [T_01 T_02 T_03 T_04 T_05 T_06 T_07]
T_0x = zeros(4,4,7);
T_0x(:,:,1) = T(:,:,1);
for i = 2:7
    T_0x(:,:,i) = T_0x(:,:,i-1)*T(:,:,i);
end

% Joint Positions
P = [zeros(3,8); ones(1,8)];
for i = 1:7
    P(:,i+1) = T_0x(:,:,i) * P(:,i+1);
end

end