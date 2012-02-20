function P = getJointPositions(T0)
% Given n 4x4 transform matrices T ~ size(4,4,n)
% Returns position of base and x joints P ~ size(4,n+1)

% Gets T_01 T_02 T_03 ... T_0n from T_01 T_12 T_23 ... T(n-1)(n)
n = size(T0,3);

% Joint Positions
P = [zeros(3,n+1); ones(1,n+1)];
for i = 1:n
    P(:,i+1) = T0(:,:,i) * P(:,i+1);
end

end