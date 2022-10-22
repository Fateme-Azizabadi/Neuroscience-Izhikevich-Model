% Simulation of Cortical Spiking Neurons
% Step 1: Clean workspace
close all ; % close open figures
clc ; % clear command window
clear % clear workspace
% Step 2: Input parameters
flagS = 1; % select 1 of 20 spike train patterns
N = 5000; % number of grid points
tMax = 100; % max time [ms]
% Step 3: Define model parameters [a b c d I] 1x5 matrix for each one of 5
% patterns
% a, b, c, and d simulate the neuron
% I simulates the current injection
% Note :
% current injection = voltage response
% voltage injection = current response
coeffM = zeros (5 ,5); % pre - allocate 5 x5 matrix of zeros
coeffM (1 ,:) = [0.02   0.2     -65     2       15  ]; % tonic spiking
coeffM (2 ,:) = [0.02   0.25    -65     6       1   ]; % phasic spiking
coeffM (3 ,:) = [0.02   0.20    -50     2       15  ]; % tonic bursting
coeffM (4 ,:) = [0.02   0.25    -55     0.05    0.6 ]; % phasic bursting
coeffM (5 ,:) = [0.02   0.20    -55     4       10  ]; % mixed mode

% Step 4: Use input parameters to simulate patterns
for i = 1:5
    flagS=i
    a = coeffM (flagS ,1);
    b = coeffM (flagS ,2);
    c = coeffM (flagS ,3);
    d = coeffM (flagS ,4);
    I = coeffM (flagS ,5);
    % Step 5: Define all plot titles
    tm = [ ' 1: Tonic Spiking   ';...
       ' 2: Phasic Spiking  '; ...
       ' 3: Tonic Bursting  '; ...
       ' 4: Phasic Bursting '; ...
       ' 5: Mixed Mode      ';];
    % Step 6: Solve Equations
    % define c1 , c2 , c3:
    cc (1) = 0.04; % [mv ]/[ ms]
    cc (2) = 5; % [1]/[ ms]
    cc (3) = 140; % [mV ]/[ ms]
    % pre - allocation
    t = linspace (0, tMax , N); % time steps [ms]
    v = zeros (N ,1); vM = zeros (N ,1); % membrane potential [mV]
    u = zeros (N ,1); uM = zeros (N ,1); % recovery variable [mV]
    Iext = zeros (N ,1);
    Iext (N /10: end) = I; % define size of I ( initialization )
    dt = t(2) -t(1) ; % one time step
    % initialize values
    v(1) = -65;
    vM (1) = -65;
    u(1) = b * v(1);
    uM (1) = u(1);
    % begin loop
    for n = 1:N -1
        v(n+1) = v(n) + dt *( cc (1)*v(n)^2 + cc (2)*v(n) + cc (3) -u(n) + Iext (n) );
        u(n+1) = u(n) + dt*a*( b*v(n) - u(n));
        if v(n+1) > 30
            vM(n +1) = 30;
            v(n+1) = c;
            u(n+1) = u(n+1) + d;
        else
            vM(n +1) = v(n+1) ;
            uM(n +1) = u(n+1) ;
        end
    end
    % plot figure
    figure (i); % 2 plots in one figure
    set (gcf , 'units', 'normalized', 'Position', [0.3 0.32 0.32 0.38]) ;
    % gcf is current plot open ( grab current figure )
    % [x1 x2 y1 y2] provides range of x- and y- values to zoom in on
    set (gca , 'fontsize', 12);
    % gca is current plot open ( grab current axes )
    hSubplot = subplot (2 ,1 ,1);
    % subplot is used to put >1 plot in one figure that is 2x1
    % h = handle in hSubplot ( important in graphical user interfaces (GUI) )
    set ( hSubplot , 'position', [0.13 0.46 0.78 0.45]) ;
    xP = t; % x- axis is time
    yP = vM; % y- axis is voltage
    plot (xP , yP , 'b','Linewidth' ,2);
    ylabel ('v_M [mV]');
    title (tm(flagS ,:)); % choose title from matrix of 20 entries
    % plot voltage change based on current injection
    grid on
    set (gca ,'fontsize' ,12);
    hSubplot = subplot (2 ,1 ,2);
    set ( hSubplot ,'position', [0.13 0.15 0.78 0.20]) ;
    xP = t;
    yP = Iext ; % external injection
    plot (xP ,yP ,'r','Linewidth' ,2);
    xlabel ('time t [ms]');
    ylabel ('c_5 I_{ ext} [mV]');
    axis ([0 tMax 0 1.2* max( Iext )]);
    grid on
    set (gca , 'fontsize', 12);
end 

%%

flagS=2
a = coeffM (flagS ,1);
b = coeffM (flagS ,2);
c = coeffM (flagS ,3);
d = coeffM (flagS ,4);
I = coeffM (flagS ,5);
% Step 5: Define all plot titles
tm = [ ' 1: Tonic Spiking   ';...
       ' 2: Phasic Spiking  '; ...
       ' 3: Tonic Bursting  '; ...
       ' 4: Phasic Bursting '; ...
       ' 5: Mixed Mode      ';];
% Step 6: Solve Equations
% define c1 , c2 , c3:
cc (1) = 0.04; % [mv ]/[ ms]
cc (2) = 5; % [1]/[ ms]
cc (3) = 140; % [mV ]/[ ms]
% pre - allocation
t = linspace (0, tMax , N); % time steps [ms]
v = zeros (N ,1); vM = zeros (N ,1); % membrane potential [mV]
u = zeros (N ,1); uM = zeros (N ,1); % recovery variable [mV]
Iext = zeros (N ,1);
Iext (N /10: end) = I; % define size of I ( initialization )
dt = t(2) -t(1) ; % one time step
% initialize values
v(1) = -65;
vM (1) = -65;
u(1) = b * v(1);
uM (1) = u(1);
% begin loop
for n = 1:N -1
    v(n+1) = v(n) + dt *( cc (1)*v(n)^2 + cc (2)*v(n) + cc (3) -u(n) + Iext (n) );
    u(n+1) = u(n) + dt*a*( b*v(n) - u(n));
    if v(n+1) > 30
        vM(n +1) = 30;
        v(n+1) = c;
        u(n+1) = u(n+1) + d;
    else
        vM(n +1) = v(n+1) ;
        uM(n +1) = u(n+1) ;
    end
end
figure('Name', 'Phasic Spiking Pattern (v-u)')
plot(v,u, 'LineWidth', 2)
xlabel('v (mV)')
ylabel('u (mV)')
title('Phasic Spiking')
grid on

