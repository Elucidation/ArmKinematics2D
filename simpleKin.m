
getR = @(th) [ cosd(th) -sind(th); sind(th) cosd(th) ];

M = 100; % kg weight on EE
g = 9.81; % m/s^2
A = 5; % Shoulder to arm distance
B = 3; % arm to EE distance

n = 200;
theta_vals = linspace(0,360,n);
GRAPHICS_ON = false;


TORQUE_MAX = [20 7];

cost = @(t1,t2) abs(TORQUE_MAX(1)-t1) + 10*abs(TORQUE_MAX(2)-t2);

T1 = zeros(180,1); % N*m^2
T2 = zeros(180,1);
costs = zeros(180,1);

for i = 1:n
    theta=[theta_vals(i) theta_vals(i)*2];

    R = { getR(theta(1)) getR(theta(2)) };

    % Offsets
    off1 = R{1}*[A 0]';
    off2 = R{2}*R{1}*[B 0]';
    k =  off1 + off2;

    % Torque on Joint 2
    %T2 = M*g * B *
    
    T1(i) = M*g*B*(off1(1)+off2(1));
    T2(i) = M*g*B*off2(1);
    costs(i) = cost(T1(i),T2(i));
    
    % Graphics
    if (GRAPHICS_ON) 
        plot( [0 off1(1) k(1) ],[0 off1(2) k(2)] ,'bo-');
        hold on;
        % Torque on joint 1
        plot([ 0 0 ], [0 1e-3*T1(i)], 'r-');
        % Torque on joint 2
        plot([ off1(1) off1(1)], [off1(2) off1(2) + 1e-3*T2(i)], 'r-');
        axis([-10 10 -10 10]);
        pause(0.05);
        hold off;
    end
    
end
clf
hold off;
plot(theta_vals,abs(T1),'r',theta_vals,abs(T2),'b');
axis([min(theta_vals) max(theta_vals) 0 max(max(T1),max(T2))]);
xlabel('Theta in degrees');
ylabel('Torque (N-m^2)');
legend('Shoulder','Arm');