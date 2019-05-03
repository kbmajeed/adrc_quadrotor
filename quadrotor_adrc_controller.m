function [sys,x0,str,ts] = quadrotor_adrc_controller_finalwithzxy(t,x,u,flag)
%quadrotorsfunc An example MATLAB file S-function for defining a continuous system.  
%   Example MATLAB file S-function implementing continuous equations: 
%      x' = f(x,u)
%      y  = h(x)
%   See sfuntmpl.m for a general S-function template.
%   See also SFUNTMPL.
%   Copyright 1990-2009 The MathWorks, Inc.
switch flag,
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts] = mdlInitializeSizes;
  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);
  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  case { 2, 4, 9 },
    sys = [];
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end
% end quadrotorsfunc

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 24;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 10;
sizes.NumInputs      = 16;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
%x0  = [1; 0; 1; 0; 1; 0; 1; 0; 1; 0; 1; 0; 1; 0];
x0  = zeros(1,24);
str = [];
ts  = [0 0];
% end mdlInitializeSizes

%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
function sys=mdlDerivatives(t,x,u)
g   = 9.81;
l   = 0.45;
wr  = 10000;        
Jr  = 6e-3;      
Ixx = 0.018125; 
Iyy = 0.018125; 
Izz = 0.035;
m   = 2;

a1 = (Iyy-Izz)/Ixx;
a2 = Jr/Ixx;
a3 = (Izz-Ixx)/Iyy;
a4 = Jr/Iyy;
a5 = (Ixx-Iyy)/Izz;
b1 = l/Ixx;
b2 = l/Iyy;
b3 = l/Izz;
%bb = -1;
bb = -(cosd(x(1))*cosd(x(3)))/m;

% L1 = 100;
% L2 = 300;
% L3 = 500;

L1 = 29.5659;
L2 = 2907;
L3 = 100;

xdot    = [x(2);
           x(4)*x(6)*a1 - x(4)*wr*a2 + b1*u(2);
           x(4);
           x(2)*x(6)*a3 + x(2)*wr*a4 + b2*u(3);
           x(6);
           x(2)*x(4)*a5 + b3*u(4)
           x(8);
           g - (u(1)/m)*(cosd(x(1))*cosd(x(3)));     
           x(10)
- (u(1)/m)*(sind(x(1))*sind(x(5)) + cosd(x(1))*sind(x(3))*cosd(x(5)));
           x(12);
- (u(1)/m)*(sind(x(1))*cosd(x(5)) - cosd(x(1))*sind(x(3))*sind(x(5)));
           x(14) + L1*(x(1)-x(13));
           x(15) + L2*(x(1)-x(13))  + b1*u(2);
                   L3*(x(1)-x(13));
           x(17) + L1*(x(3)-x(16));
           x(18) + L2*(x(3)-x(16)) + b2*u(3);
                   L3*(x(3)-x(16));
           x(20) + L1*(x(5)-x(19));
           x(21) + L2*(x(5)-x(19)) + b3*u(4);
                   L3*(x(5)-x(19));
           x(23) + L1*(x(7)-x(22));
           x(24) + L2*(x(7)-x(22)) + bb*u(1);
                   L3*(x(7)-x(22))];
sys      = xdot;
% end mdlDerivatives

%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
function sys=mdlOutputs(t,x,u)
m   = 2;
l   = 0.45;
wr  = 10000;
Ixx = 0.018125; 
Iyy = 0.018125; 
Izz = 0.035;
b1 = l/Ixx;
b2 = l/Iyy;
b3 = l/Izz;
%bb = 1;
bb = -(cosd(x(1))*cosd(x(3)))/m;

%x1d = 5; x3d = 5; 
x5d = 5; x7d = 5;

% k1 = 5; k2 = 5;
% k3 = 5; k4 = 5;
% k5 = 5; k6 = 5;

k1p = u(5);  k2p = u(6);
k3t = u(7);  k4t = u(8);
k5k = u(9);  k6k = u(10);
k7z = u(11); k8z = u(12);

zeed    = x7d; zeeddot = 0; 
u01     = k7z*(zeed - x(1)) + k8z*(zeeddot - x(2));
%u01     = k7z*(x(1) - zeed) + k8z*(x(2) - zeeddot);
u1      = (u01 - x(24))/bb;

kpx = u(13); kdx = u(14);
kpy = u(15); kdy = u(16);
x10d2dot= 0; x12d2dot= 0;
x9d    = 5;  %x desired
x11d   = 5;  %y desired
phid   =  kpy*(x(11) - x11d) + kdy*(x(12) - x12d2dot);
thetad =  kpx*(x(9) - x9d)   + kdx*(x(10) - x10d2dot);
% phid   =  kpy*(x11d - x(11)) + kdy*(x12d2dot - x(12));
% thetad =  kpx*(x9d - x(9))   + kdx*(x10d2dot - x(10));
x1d    =  cosd(x(5))*phid - sind(x(5))*thetad;
x3d    =  sind(x(5))*phid + cosd(x(5))*thetad;

phid    = x1d; phiddot = 0; 
u02     = k1p*(phid - x(1)) + k2p*(phiddot - x(2));
u2      = (u02 - x(15))/b1;

thetad    = x3d; thetaddot = 0; 
u03       = k3t*(thetad - x(3)) + k4t*(thetaddot - x(4));
u3        = (u03 - x(18))/b2;

ksid    = x5d; ksiddot = 0; 
u04     = k5k*(ksid - x(5)) + k6k*(ksiddot - x(6));
u4      = (u04 - x(21))/b3;

sys = [ x(1); x(3); x(5); x(7); x(9); x(11); u1; u2; u3; u4];
% end mdlOutputs
