close all

figure
% subplot(4,2,1)
    plot(1:20,Xfnn_lorenz/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Lorenz")

figure    
% subplot(4,2,2)
    plot(1:20,Xfnn_duffing/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Duffing")

figure
% subplot(4,2,3)
    plot(1:20,Xfnn_normal/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Normal")

figure    
% subplot(4,2,4)
    plot(1:20,Xfnn_uniform/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Uniform")

figure    
% subplot(4,2,5)
    plot(1:20,Xfnn_ar(:,:,1)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.02)")

figure    
% subplot(4,2,6)
    plot(1:20,Xfnn_ar(:,:,2)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.05)")

figure    
% subplot(4,2,7)
    plot(1:20,Xfnn_ar(:,:,3)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.2)")

figure    
% subplot(4,2,8)
    plot(1:20,Xfnn_ar(:,:,4)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.5)")
    
figure
subplot(4,2,1)
    plot(1:20,Xfnn_lorenz/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Lorenz")

% figure    
subplot(4,2,2)
    plot(1:20,Xfnn_duffing/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Duffing")

% figure
subplot(4,2,3)
    plot(1:20,Xfnn_normal/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Normal")

% figure    
subplot(4,2,4)
    plot(1:20,Xfnn_uniform/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for Uniform")

% figure    
subplot(4,2,5)
    plot(1:20,Xfnn_ar(:,:,1)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.02)")

% figure    
subplot(4,2,6)
    plot(1:20,Xfnn_ar(:,:,2)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.05)")

% figure    
subplot(4,2,7)
    plot(1:20,Xfnn_ar(:,:,3)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.2)")

% figure    
subplot(4,2,8)
    plot(1:20,Xfnn_ar(:,:,4)/100,'b-X','LineWidth',1);
    xticks(0:5:20);
    yticks(0:0.2:1)
    axis([0 20 0 1])
    ylabel("$\hat{f}_{nn}(d;r)$","Interpreter","latex")
    xlabel("d","Interpreter","latex")
    title("Kennel Fraction on FNN for AR(0.5)")
        