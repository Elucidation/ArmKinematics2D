function P = getJointPositions(T)
% Given n 4x4 transform matrices T ~ size(4,4,n)
% Returns position of base and x joints P ~ size(4,n+1)

n = size(T,3);

% Base to n Transform Matrices
% [T_01 T_02 T_03 T_04 T_05 T_06 T_07]
T_0x = zeros(size(T));
T_0x(:,:,1) = T(:,:,1);
for i = 2:n
    T_0x(:,:,i) = T_0x(:,:,i-1)*T(:,:,i);
end

% Joint Positions
P = [zeros(3,n+1); ones(1,n+1)];
for i = 1:n
    P(:,i+1) = T_0x(:,:,i) * P(:,i+1);
end

end