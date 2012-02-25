function J= getInertia(I,LocalCoM,m)
    for i=1:length(m)
        J(:,:,i)=[I,LocalCoM(:,i)'*m(i);LocalCoM(:,i)*m,m];
    end
end