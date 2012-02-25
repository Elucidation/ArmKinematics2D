function H0 = getCumulativeAccTransforms(H,W)
% Returns cumulative transforms from 0 frame
% Given T_01 T_12 T_23 ... T(n-1)(n)
% Returns T_01 T_02 T_03 ... T_0n 

n = size(H,3);

% Base to n Transform Matrices
% [T_01 T_02 T_03 T_04 T_05 T_06 T_07]
H0 = zeros(size(H));
H0(:,:,1) = H(:,:,1); % T0_(0->1) = T_0->1
for i = 2:n
    % T0_(0->i) = T0_(0->i-1) * T_(i-1->i)
    % example: To02 = To01 * T12
    H0(:,:,i) = H(:,:,i-1)+H(:,:,i)+2*W(:,:,i-1)*W(:,:,i-1);%need to check if .* or *
end
end