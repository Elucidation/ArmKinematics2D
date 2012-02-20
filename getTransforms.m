function T = getTransforms(thetas,L)
% Given angles thetas and link lengths L
% Returns 7 Transform matrices
% T_01 T_12 ... T_67


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
                    0       0       1       -L(i) ; ...
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
end