%% Initialize ADRC-PD Complete Backstepping controller
% 
% %% ADRC gains
% L1phi = 1000;
% L2phi = 5000;
% L3phi = 10000;
% 
% L1tht = 1000;
% L2tht = 5000;
% L3tht = 10000;
% 
% L1ksi = 30;
% L2ksi = 3000;
% L3ksi = 100;
% 
% L1zee = 30;
% L2zee = 3000;
% L3zee = 100;
% 
% %% PD Controller Gains
% kpphi = 113;
% kdphi = 51;
% 
% kptht = 113;
% kdtht = 51;
% 
% kpksi = 113;
% kdksi = 31;
% 
% kpzee = 113;
% kdzee = 31;
% 
% kpx = 31;
% kdx = 13;
% 
% kpy = 31;
% kdy = 13;
% 
% k11 = 1; k12 = 1; k21 = 1; k22 = 1; k13 = 1; k23 = 1; k14 = 1; k24 = 1;



%%

% L1 = 29.5659;
% L2 = 2907;
% L3 = 100;
% 
% k1p = 23.7113;
% k2p = 16.6121;
% 
% k1t = 9.1905;
% k2t = 8.9002;
% 
% k1k = 2.6977;
% k2k = 2.3848;

%%
% L1 = 29.5659;
% L2 = 2907;
% L3 = 100;
% 
% k1p = 90.3979;
% k2p = 19.6321;
% 
% k1t = 79.3794;
% k2t = 21.1666;
% 
% k1k = 69.8457;
% k2k = 16.8096;
% 
% k1z = 50;
% k2z = 10;
% 
% kpx = 25;
% kdx = 5;
% 
% kpy = 25;
% kdy = 5;

%%
%L1 = 29.5659;
%L2 = 2907;
%L3 = 3000;
%wr = 0.1

%%%%% THIS ONE %%%%%%%
% k1p = 90.3979;
% k2p = 19.6321;
% k1t = 79.3794;
% k2t = 21.1666;
% k1k = 69.8457;
% k2k = 16.8096;
% k1z = 10.5246;
% k2z =  9.5557;
% % k1x =  3.9; 
% % k2x =  7.3;
% % k1y =  3.9;
% % k2y =  8.3;
% k1x =  4.3; 
% k2x =  8.3;
% k1y =  4.3;
% k2y =  8.3;


%%
% L1 = 29.5659;
% L2 = 2907;
% L3 = 100;
% 
% k1p = 90.3979;
% k2p = 19.6321;
% 
% k1t = 79.3794;
% k2t = 21.1666;
% 
% k1k = 69.8457;
% k2k = 16.8096;
% 
% k1z = 50;
% k2z = 10;
% 
% % kpx = 25;
% % kdx = 5;
% % 
% % kpy = 25;
% % kdy = 5;

% close all
% E = 0.12*eye(3); figure(101); plot_ellipse(E,'r');
% title('Barret Arm Ellipse \zeta','interpreter','Tex')
% grid on; set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[])

%%
% final2xyDisturbed
k1p = 100;
k2p = 80.4975;
k1t = 100;
k2t = 21.5361;
k1k = 69.8457;
k2k = 16.8096;
k1z = 10.5246;
k2z = 9.5557;
k1x =  3.9; 
k2x =  7.3;
k1y =  3.9;
k2y =  8.3;
lambda = 1;
