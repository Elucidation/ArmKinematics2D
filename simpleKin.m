
getR = @(th) [ cosd(th) -sind(th); sind(th) cosd(th) ];

for i = 0:90
    theta=[i 30+i];

    R = { getR(theta(1)) getR(theta(2)) };

    A = [5 0]';
    B = [3 0]';


    % Offsets
    off1 = R{1}*A;
    off2 = R{2}*R{1}*B;
    k =  off1 + off2;


    plot( [0 off1(1) k(1) ],[0 off1(2) k(2)] ,'bo-');
    axis([-10 10 -10 10]);
    pause(0.05);
end

