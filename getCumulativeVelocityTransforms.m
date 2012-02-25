function W0 = getCumulativeVelocityTransforms(W)
% Returns cumulative transforms from 0 frame
% Given T_01 T_12 T_23 ... T(n-1)(n)
% Returns T_01 T_02 T_03 ... T_0n 

n = size(W,3);

% Base to n Transform Matrices
% [T_01 T_02 T_03 T_04 T_05 T_06 T_07]
W0 = zeros(size(W));
W0(:,:,1) = W(:,:,1); % T0_(0->1) = T_0->1
for i = 2:n
    % T0_(0->i) = T0_(0->i-1) * T_(i-1->i)
    % example: To02 = To01 * T12
    W0(:,:,i) = W(:,:,i-1)+W(:,:,i);
end
end