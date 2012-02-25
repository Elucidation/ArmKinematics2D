function A = getJointAcc(H0,P)
% Given n 4x4 transform matrices T ~ size(4,4,n)
% Returns position of base and x joints P ~ size(4,n+1)

% Gets T_01 T_02 T_03 ... T_0n from T_01 T_12 T_23 ... T(n-1)(n)
n = size(H0,3);

% Joint Positions
A = zeros(4,n);
for i = 1:n
    A(:,i) = H0(:,:,i) * P(:,i);
end

end