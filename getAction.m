function Act = getAction(H0,J0)
% Act(:,:,i)=   |0  -Tz  Ty  Fx |
%               |Tz   0 -Tx  Fy |
%               |-Ty Tx   0  Fz |
%               |-Fx-Fy -Fz  0  |
%
for i=1:length(H0,3)
    Act(:,:,i)=H0(:,:,i)*J0(:,:,i)-J0(:,:,i)*H0(:,:,i)';
end


end