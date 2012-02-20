n = 100;
x = linspace(0,90,n);


trail = zeros(3,n); % Trail of end effector

for i = 1:n
    % Joint Angles
    % [ 1 2 3 4 5 6 7 ]
    % [ twist1 rotate1 twist2 rotate2 twist3 rotate3 twist4 ]
    theta = [0 0 x(i) x(i) 0 0 0]; % degrees

    % Get Joint Positions
    P = getJointPositions(theta);
    trail(:,i) = P(1:3,end);

    % Graphics
    plot3(P(1,:),P(2,:),P(3,:),'bo-', trail(1,1:i),trail(2,1:i),trail(3,1:i),'r-');
    xlabel('x (meters)');
    ylabel('y (meters)');
    zlabel('z (meters)');

    axis([-2 2 -2 2 -2 2]) % m
    pause(0.01);
end