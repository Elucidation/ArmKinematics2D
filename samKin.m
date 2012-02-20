n = 100;
x = linspace(0,90,n);

WORKSPACE = 1.1 * [-1 1 -1 1 -1 1];

trail = zeros(3,n); % Trail of end effector

% link lengths of joints from base to tip
% [ L12 L34 L56 L7 ] changed to 
%   [  L12  0  L34  0   L56  0   L7  ]
L = [ 0.250 0 0.328 0 0.2765 0 0.171 ]; % m

for i = 1:n
    % Joint Angles
    % [ 1 2 3 4 5 6 7 ]
    % [ twist1 rotate1 twist2 rotate2 twist3 rotate3 twist4 ]
    theta = [0 x(i) 0 x(i) 0 x(i) 0]; % degrees
    
    T = getTransforms(theta,L);

    P = getJointPositions(T);
    
    
    %T = getTorques(theta);
    
    
    % Update EE trail
    trail(:,i) = P(1:3,end);

    % Graphics
    plot3(P(1,:),P(2,:),P(3,:),'bo-', trail(1,1:i),trail(2,1:i),trail(3,1:i),'r-');
    xlabel('x (meters)');
    ylabel('y (meters)');
    zlabel('z (meters)');

    axis(WORKSPACE) % m
    pause(0.01);
end