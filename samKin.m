n = 100;
x = linspace(0,90,n);

WORKSPACE = 1.1 * [-1 1 -1 1 -1 1];
WORKSPACE_2D = 1.1 * [-1 1 -1 1];

DRAW_2D = 0; % else 3D

trail = zeros(3,n); % Trail of end effector

% link lengths of joints from base to tip
% [ L12 L34 L56 L7 ] changed to 

% Full LWA3
%   [  L12  0  L34  0   L56  0   L7  ]
L = [ 0.250 0 0.328 0 0.2765 0 0.171 ]; % m

% Test case 3 joints, twist-shoulder rotate-elbow twist-wrist
%   [  L12  0  L34  0   L5   ]
%L = [ 0.250 0 0.328 ]; % m

for i = 1:n
    % Joint Angles
    % [ 1 2 3 4 5 6 7 ]
    % [ twist1 rotate1 twist2 rotate2 twist3 rotate3 twist4 ]
    
    % Full LWA3
    theta = [0 x(i) x(i) x(i) 0 x(i) 0]; % degrees
    
    % Test case 3 joints, twist-shoulder rotate-elbow twist-wrist
    %theta = [0 x(i) 0]; % degrees
    
    T = getTransforms(theta,L); % T01 T12 T23 ... T(n-1)(n)
    T0 = getCumulativeTransforms(T); % T01 T02 T03 ... T0n

    P = getJointPositions(T0);
    
    CM = getCenterOfMass(T0);
    
    %T = getTorques(theta);
    
    
    % Update EE trail
    trail(:,i) = P(1:3,end);

    % Graphics
    if DRAW_2D
        plot(P(1,:),P(2,:),'bo-', trail(1,1:i),trail(2,1:i),'r-', CM(1), CM(2), 'g*');
        axis equal
        axis(WORKSPACE_2D) % m
    else
        plot3(P(1,:),P(2,:),P(3,:),'bo-', trail(1,1:i),trail(2,1:i),trail(3,1:i),'r-', CM(1), CM(2), CM(3), 'g*');
        axis(WORKSPACE) % m
    end
    
    xlabel('x (meters)');
    ylabel('y (meters)');
    zlabel('z (meters)');
    
    pause(0.01);
end

if DRAW_2D
    legend('links','End-Effector trail', 'Arm Center of Mass');
end