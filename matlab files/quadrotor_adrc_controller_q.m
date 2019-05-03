function [sys,x0,str,ts] = quadrotor_adrc_controller_q(t,x,u,flag)
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
sizes.NumContStates  = 12;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 10;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [1; 0; 1; 0; 1; 0; 1; 0; 1; 0; 1; 0];
str = [];
ts  = [0 0];
% end mdlInitializeSizes

%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
function sys=mdlDerivatives(t,x,u)
g    = 9.81;
l    = 0.23;
wr   = 225.7;
Ixx  = 7.5e-3;
Iyy  = 7.5e-3;
Izz  = 1.3e-2;
Jr   = 6e-5;
m    = 0.65;

% if t <= 25
% m    = 0.650;
% elseif t > 25
% m    = 2;
% end


a1 = (Iyy-Izz)/Ixx;
a2 = Jr/Ixx;
a3 = (Izz-Ixx)/Iyy;
a4 = Jr/Iyy;
a5 = (Ixx-Iyy)/Izz;
b1 = l/Ixx;
b2 = l/Iyy;
b3 = l/Izz;

xdot    = [x(2);
           x(4)*x(6)*a1 - x(4)*wr*a2 + b1*u(2);
           x(4);
           x(2)*x(6)*a3 + x(2)*wr*a4 + b2*u(3);
           x(6);
           x(2)*x(4)*a5 + b3*u(4)
           x(8);
           g - (u(1)/m)*(cosd(x(1))*cosd(x(3)));
           x(10);
           - (u(1)/m)*(sind(x(1))*sind(x(5)) + cosd(x(1))*sind(x(3))*cosd(x(5)));
           x(12);
           - (u(1)/m)*(sind(x(1))*cosd(x(5)) - cosd(x(1))*sind(x(3))*sind(x(5)));];
sys      = xdot;
% end mdlDerivatives

%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
function sys=mdlOutputs(t,x,u)
u1 = u(1);
u2 = u(2);
u3 = u(3);
u4 = u(4);


                % phi / theta / ksi / z / x / y /
sys = [ x(1); x(3); x(5); x(7); x(9); x(11); u1; u2; u3; u4];
% end mdlOutputs
