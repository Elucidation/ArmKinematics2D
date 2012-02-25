function J0 = getCumulativeIntertia(J,T0)
% Returns cumulative transforms from 0 frame
% Given T_01 T_12 T_23 ... T(n-1)(n)
% Returns T_01 T_02 T_03 ... T_0n 

n = size(J,3);

% Base to n Transform Matrices
J0 = zeros(size(J));
J0(:,:,n) = J(:,:,n); % T0_(0->1) = T_0->1
for i = 1:n-1
    J0(:,:,n-i) = J(:,:,n-i+1)+T0(:,:,n-i)*J(:,:,n-i)*T0(:,:,n-i)';
end