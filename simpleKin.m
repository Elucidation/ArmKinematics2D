
getR = @(th) [ cosd(th) -sind(th); sind(th) cosd(th) ];

M = 100; % kg weight on EE
g = 9.81; % m/s^2
A = 5; % Shoulder to arm distance
B = 3; % arm to EE distance
T1 = zeros(180,1);
T2 = zeros(180,1);

n = 200;
theta_vals = linspace(0,360,n);
GRAPHICS_ON = false;

for i = 1:n
    theta=[theta_vals(i) 0];

    R = { getR(theta(1)) getR(theta(2)) };

    % Offsets
    off1 = R{1}*[A 0]';
    off2 = R{2}*R{1}*[B 0]';
    k =  off1 + off2;

    % Torque on Joint 2
    %T2 = M*g * B *
    
    T1(i) = 1e-3 * M*g*B*(off1(1)+off2(1));
    T2(i) = 1e-3 * M*g*B*off2(1);
    
    % Graphics
    if (GRAPHICS_ON) 
        plot( [0 off1(1) k(1) ],[0 off1(2) k(2)] ,'bo-');
        hold on;
        % Torque on joint 1
        plot([ 0 0 ], [0 1e-1*T1(i)], 'r-');
        % Torque on joint 2
        plot([ off1(1) off1(1)], [off1(2) off1(2) + 1e-1*T2(i)], 'r-');
        axis([-10 10 -10 10]);
        pause(0.05);
        hold off;
    end
    
end

plot(theta_vals,abs(T1),'r',theta_vals,abs(T2),'b');
axis([min(theta_vals) max(theta_vals) 0 max(max(T1),max(T2))]);
legend('Shoulder','Arm');