
getR = @(th) [ cosd(th) -sind(th); sind(th) cosd(th) ];

M = 100; % kg weight on EE
g = 9.81; % m/s^2
A = 5; % Shoulder to arm distance m
B = 3; % arm to EE distance m

n = 200;
theta_vals = linspace(-180,0,n);
GRAPHICS_ON = true;

TORQUE_MAX = [-1 2500];

cost = @(t1,t2) abs(TORQUE_MAX(1)-t1) + 10*abs(TORQUE_MAX(2)-t2);

T1 = zeros(n,1); % N*m^2
T2 = zeros(n,1);
costs = zeros(n,1);
theta=[90 theta_vals(1)];

% Tmax = Mgcos(theta from horizontal)B
% theta from horizontal needed = acos(Tmax/MgB)
stage2startangle = acosd(TORQUE_MAX(2)/(M*g*B))

for i = 1:n
    theta(2) = theta_vals(i);
    off2temp = getR(theta(2))*getR(90)*[B 0]';
    torqtemp = M*g*off2temp(1); % x
    if (torqtemp > TORQUE_MAX(2))
        theta(1) = 90 + acosd(TORQUE_MAX(2)/torqtemp);
    end
    
    R = { getR(theta(1)) getR(theta(2)) };

    % Offsets
    off1 = R{1}*[A 0]';
    off2 = R{2}*R{1}*[B 0]';
    k =  off1 + off2;

    % Torque on Joint 2
    %T2 = M*g * B *
    
    T1(i) = M*g*(off1(1)+off2(1));
    T2(i) = M*g*off2(1);
    %costs(i) = cost(T1(i),T2(i));
    
    % Graphics
    if (GRAPHICS_ON) 
        subplot(2,1,1), plot( [0 off1(1) k(1) ],[0 off1(2) k(2)] ,'bo-');
        hold on;
        % Torque on joint 1
        %plot([ 0 0 ], [0 1e-3*T1(i)], 'r-');
        % Torque on joint 2
        plot([ off1(1) off1(1)], [off1(2) off1(2) + 1e-3*T2(i)], 'r-');
        axis equal
        axis([-10 10 -10 10]);
        hold off
        
        subplot(2,1,2), plot(theta_vals,abs(T1),'r',theta_vals,abs(T2),'b');
        %axis([min(theta_vals) max(theta_vals) 0 max(max(T1),max(T2))]);
        xlabel('Theta in degrees');
        ylabel('Torque (N-m^2)');
        
        pause(0.05);
        hold off;
    end
    
end
% clf
% hold off;
% plot(theta_vals,abs(T1),'r',theta_vals,abs(T2),'b');
% axis([min(theta_vals) max(theta_vals) 0 max(max(T1),max(T2))]);
% xlabel('Theta in degrees');
% ylabel('Torque (N-m^2)');
legend('Shoulder','Arm');