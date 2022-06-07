clear, clc, close all;

[x_ar,tau_ar,x_lorenz,tau_lorenz,x_duffing,tau_duffing,normal,uniform] = datasets(6*10^4);
close all

minDim = 1;
maxDim = 20;
ts = x_lorenz;
Atol = 2;

Xfnn_lorenz = zeros(11,maxDim-minDim+1);
Xfnn_duffing = zeros(11,maxDim-minDim+1);
Xfnn_normal = zeros(11,maxDim-minDim+1);
Xfnn_uniform = zeros(11,maxDim-minDim+1);
Xfnn_ar = zeros(11,maxDim-minDim+1,4);

for i = 1:11
    Rtol = 2*i - 2;

    Xfnn_lorenz(i,:) = FNN_KennelFraction(minDim, maxDim, tau_lorenz, x_lorenz, Rtol,Atol);
    Xfnn_duffing(i,:) = FNN_KennelFraction(minDim, maxDim, tau_duffing, x_duffing, Rtol,Atol);
    Xfnn_normal(i,:) = FNN_KennelFraction(minDim, maxDim, 5, normal, Rtol,Atol);
    Xfnn_uniform(i,:) = FNN_KennelFraction(minDim, maxDim, 5, uniform, Rtol,Atol);
    
    for j = 1:4

        Xfnn_ar(i,:,j) = FNN_KennelFraction(minDim, maxDim, tau_ar, x_ar(j,:), Rtol,Atol);

    end

end

path_ = "C:\Users\aaron\OneDrive\Área de Trabalho\Backup do Drive\2022.1\TDA\codes\data\";
writematrix(Xfnn_lorenz,path_ + "Xfnn_lorenz");
writematrix(Xfnn_duffing,path_ + "Xfnn_duffing");
writematrix(Xfnn_ar(:,:,1),path_ + "Xfnn_ar1");
writematrix(Xfnn_ar(:,:,2),path_ + "Xfnn_ar2");
writematrix(Xfnn_ar(:,:,3),path_ + "Xfnn_ar3");
writematrix(Xfnn_ar(:,:,4),path_ + "Xfnn_ar4");
writematrix(Xfnn_normal,path_ + "Xfnn_normal");
writematrix(Xfnn_uniform,path_ + "Xfnn_uniform");