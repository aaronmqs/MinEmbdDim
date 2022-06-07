function [x_ar,tau_ar,x_lorenz,tau_lorenz,x_duffing,tau_duffing,normal,uniform] = datasets(N)

%% Delay- Coordinate Embedding
    
    %% 2 Data Sets Used in the Analysis 
    
    %N = 6*10^4; % number of point samples for white random time series
    %N = 3*10^3;
    
    %% Purely white random time series
    % 
    uniform = normalize(rand(1,N)); % uniformly ditributed random numbers normalized
    normal = normalize(randn(1,N)); % normally distributed random numbers (normalize used only to make var exactly equal to 1)
    
    %% Stochastic data containing deterministic components
    
    % 
    % Autoregressive process: Discretized noise-driven damped oscilator
    % x[n+2] = ax[n+1] + bx[n] + u[n+1] <=> (state space) v[n+1] = Av[n] + Bu[n+1]
    % y[n] = v[n] => C = [1 0] D = 0
    z = tf('z',1); % complex variable
    tau_ar = 5; % arbitrarily chosen time delay used in delay-coordinate embedding
    omega = 2*pi/20; %frequency
    rho = [0.02 0.05 0.2 0.5]; % amount of stochasticity
    x_ar = zeros(length(rho),N); % output
    x_ar_delayed = zeros(length(rho),N-5);  % delayed output
    for i = length(rho):-1:1 % generate a time series for each value of rho
        a = 2 - omega^2 - rho(i);
        b = rho(i) - 1;
        A = [0 1;b a];
        B = [0;1];
        C = [1 0];
        G = C*((z*eye(2) - A)\B*z); % Transfer function x[n]/u[n]
        set(G,'Variable','z^-1') % in terms of z^-1
        x_ar(i,:) = lsim(G,0.8*uniform); % output for a white noise input (considered as a fraction of uniform distribution to fit the paper graphic)
        x_ar_delayed(i,:) = zeros(1,length(x_ar(i,:)) - tau_ar);
    
        for j = 1:length(x_ar_delayed(i,:))
            x_ar_delayed(i,j) = x_ar(i,j + tau_ar);
        end
        
        subplot(2,3,2+i)
        plot(x_ar(i,1:length(x_ar_delayed(i,:))),x_ar_delayed(i,:))
        title("AR("+rho(i)+")",'interpreter','latex','Fontsize',20)
        xlabel('$x_{i}$','interpreter','latex','Fontsize',20)
        ylabel("$x_{i +"+tau_ar+"}$",'interpreter','latex','Fontsize',20)
    
    end
    
    %% Lorenz Equation
    
    % 
    tau_lorenz = 8; % arbitrarily chosen time delay used in delay-coordinate embedding
    ts_lorenz = 0.02; % sample time and time step for the numerical integration
    x0_lorenz = [20;5;-5]; % initial condition
    tspan_lorenz = ts_lorenz:ts_lorenz:N*ts_lorenz; % integration interval
    options_lorenz = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,3)); % making the solutions very accurate
    [~,x] = ode45(@(t,x)lorenz(t,x),tspan_lorenz,x0_lorenz,options_lorenz); % solves the differential equation system
    x_l = x; % uncomment to plot Lorenz Attractor
    x_lorenz = x(:,2); % ouput for the Lorenz system
    x_lorenz_delayed = zeros(length(x_lorenz) - tau_lorenz,1); % delayed output
    for i = 1:length(x_lorenz_delayed)
        x_lorenz_delayed(i) = x_lorenz(i + tau_lorenz);
    end
    subplot(2,3,1)
    plot(x_lorenz(1:length(x_lorenz_delayed)),x_lorenz_delayed)
    title("Lorenz",'interpreter','latex','Fontsize',20)
    xlabel('$x_{i}$','interpreter','latex','Fontsize',20)
    ylabel("$x_{i +"+tau_lorenz+"}$",'interpreter','latex','Fontsize',20)
    
    % Additive Noise Effects
    x_lorenz_noise = zeros(length(x_lorenz),4);
    sigma_lorenz = std(x_lorenz);
    for i = 1:4
        sigma_n = 2^(i-1)*0.05*sigma_lorenz; % standard deviation of the noise according to Signal-to-Noise Ratio
        x_lorenz_noise(:,i) = x_lorenz + sigma_n*randn(N,1);
    end
    
    %% Duble-Well Duffing Equation
    
    % 
    % ddx + 0.2dx - x + x^3 = 0.33cost
    tau_duffing = 14; % arbitrarily chosen time delay used in delay-coordinate embedding
    ts_duffing = 0.1; % sample time
    x0_duffing = [0;0]; % initial condition
    tspan_duffing = ts_duffing:ts_duffing:N*ts_duffing; % integration interval
    options_duffing = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,2)); % making the solutions very accurate
    [~,x] = ode45(@(t,x)duffing(t,x),tspan_duffing,x0_duffing,options_duffing); % solves the differential equation system
    % plot3(x(:,1),x(:,2),x(:,3)); plots the space state for the duffing system
    x_duffing = x(:,1); % ouput for the duffing system
    x_duffing_delayed = zeros(length(x_duffing) - tau_duffing,1); % delayed output
    for i = 1:length(x_duffing_delayed)
        x_duffing_delayed(i) = x(i + tau_duffing);
    end
    subplot(2,3,2)
    plot(x_duffing(1:length(x_duffing_delayed)),x_duffing_delayed)
    title("duffing",'interpreter','latex','Fontsize',20)
    xlabel('$x_{i}$','interpreter','latex','Fontsize',20)
    ylabel("$x_{i +"+tau_duffing+"}$",'interpreter','latex','Fontsize',20)
    
    % Additive Noise Effects
    x_duffing_noise = zeros(length(x_duffing),4);
    sigma_duffing = std(x_duffing);
    for i = 1:4
        sigma_n = 2^(i-1)*0.05*sigma_duffing; % standard deviation of the noise according to Signal-to-Noise Ratio
        x_duffing_noise(:,i) = x_duffing + sigma_n*randn(N,1);
    end
    
    %% Calculates the autocorrelations
    %
    % Calculates the linear autocorrelations
%     for i = length(rho):-1:1
%         [acf_ar(i,:),lags_ar(i,:),~] = autocorr(x_ar(i,:),'NumLags',30);
%     end
%     [acf_lorenz,lags_lorenz,~] = autocorr(x_lorenz,'NumLags',30);
%     [acf_duffing,lags_duffing,~] = autocorr(x_duffing,'NumLags',30);
%     
%     % Calculates the Auto Mutual Informations
%     nbins = 30;
%     maxlag = 30;
%     t = 0:maxlag;
%     ami_ar(1,:) = autoMI(x_ar(1,:),nbins,maxlag);
%     ami_ar(2,:) = autoMI(x_ar(2,:),nbins,maxlag);
%     ami_ar(3,:) = autoMI(x_ar(3,:),nbins,maxlag);
%     ami_ar(4,:) = autoMI(x_ar(4,:),nbins,maxlag);
%     ami_duffing = autoMI(x_duffing,nbins,maxlag);
%     ami_lorenz = autoMI(x_lorenz,nbins,maxlag);
    
    %% Plots non linear and linear autocorrelations
    set(groot,'defaultLineMarkerSize',4);
    
    % autocorrelation
%     figure
%     subplot(1,2,1)
%     plot(lags_ar(1,:),acf_ar(1,:),'-o','Color',[0 0.4470 0.7410],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(lags_ar(2,:),acf_ar(2,:),'-s','Color',[0.8500 0.3250 0.0980],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(lags_ar(3,:),acf_ar(3,:),'-d','Color',[0.9290 0.6940 0.1250],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(lags_ar(4,:),acf_ar(4,:),'-^','Color',[0.4940 0.1840 0.5560],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(lags_duffing,acf_duffing,'-v','Color',[0.4660 0.6740 0.1880],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(lags_lorenz,acf_lorenz,'->','Color',[0,0.7,0.9],'LineWidth',1.5,'MarkerFaceColor','w')
%     axis([0 30 -1 1])
%     xticks([0 10 20 30])
%     yticks([-1 -0.5 0 0.5 1])
%     ylabel('Autocorrelation','interpreter','latex','Fontsize',20)
%     xlabel('Delay, $\tau$','interpreter','latex','Fontsize',20)
%     grid on
%     daspect([10 1 1])
%     
%     % Auto Mutual Information
%     subplot(1,2,2)
%     plot(t,ami_ar(1,:),'-o','Color',[0 0.4470 0.7410],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(t,ami_ar(2,:),'-s','Color',[0.8500 0.3250 0.0980],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(t,ami_ar(3,:),'-d','Color',[0.9290 0.6940 0.1250],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(t,ami_ar(4,:),'-^','Color',[0.4940 0.1840 0.5560],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(t,ami_duffing,'-v','Color',[0.4660 0.6740 0.1880],'LineWidth',1.5,'MarkerFaceColor','w')
%     hold on
%     plot(t,ami_lorenz,'->','Color',[0,0.7,0.9],'LineWidth',1.5,'MarkerFaceColor','w')
%     xticks([0 10 20 30])
%     yticks([0 2 4 6 8])
%     axis([0 30 0 8])
%     ylabel('AMI (bits)','interpreter','latex','Fontsize',20)
%     xlabel('Delay, $\tau$','interpreter','latex','Fontsize',20)
%     grid on
%     legend('AR(0.02)','AR(0.05)','AR(0.2)','AR(0.5)','Duffing','Lorenz','interpreter','latex','Fontsize',10)
%     daspect([10 4 1])
%     
%     sgtitle('\textbf{Fig. 1 Linear and nonlinear correlations in chaotic and correlated stochastic time series}','interpreter','latex','Fontsize',15)
    
    %%
    
    
    %% Plots phase space for the Lorenz Attractor
    
%     figure
%     
%     subplot(2,1,1)
%     plot3(x_l(:,1),x_l(:,2),x_l(:,3)); % plots the space state for the Lorenz system
%     xlabel('x(t)','interpreter','latex','Fontsize',20);
%     ylabel('y(t)','interpreter','latex','Fontsize',20);
%     zlabel('z(t)','interpreter','latex','Fontsize',20);
%     title('Lorenz Attractor','interpreter','latex','Fontsize',20);  
%     grid on
%     
%     subplot(2,1,2)
%     plot(x_l(:,2),x_l(:,1));
%     xlabel('y(t)','interpreter','latex','Fontsize',20);
%     ylabel('x(t)','interpreter','latex','Fontsize',20);
%     grid on
    
end

