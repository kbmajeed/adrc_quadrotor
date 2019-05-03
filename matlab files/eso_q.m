function [sys,x0,str,ts] = eso_q(t,x,u,flag)
% Extended State Observer summary of this function goes here
% ESO is the disturbance observer level of the adrc
% output of the ESO is the State Estimations

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes();

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
% end csfunc

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes()

sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
x0  = [0; 0; 0];
str = [];
ts  = [0 0];

% end mdlInitializeSizes
%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%

function sys=mdlDerivatives(t,x,u)
%b0    = 2;
b0     = 0.833;
a1     = 1;
a2     = 0.5;
a3     = 0.25;
delta  = 0.001;

hg     = 0.15;
beta01 = 1;
beta02 = 1/(2*(hg^0.5));
beta03 = 2/(25*(hg^1.2));
beta01 = beta01*100;
beta02 = beta02*100;
beta03 = beta03*100;

%e      =  z(1) - y;
 e      =  u(3) - u(1);
%e      =  x(1) - u(1);

xdot1   = [x(2) - beta01*fal(e,a1,delta);          % z1->z:2
           x(3) - beta02*fal(e,a2,delta)+ b0*u(2); % z2->z:3
                - beta03*fal(e,a3,delta);          % z3->z:4
          ];

% fe  = fal(e,0.5,delta)
% fe1 = fal(e,0.25,delta)
% 
% xdot1   = [x(2) - beta01*e;            % z1->z:2
%            x(3) - beta02*fe+ b0*u(2);  % z2->z:3
%                 - beta03*fe1;          % z3->z:4
%           ];

sys = xdot1;

% end mdlDerivatives
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)
x(1); %z(1)
x(2); %z(2)
x(3); %z(3)

%e      =  z(1) - y
% ex1   =  u(3) - u(1)
% ex2   =  x(1) - u(1)
% abs(ex1 - ex2); % ex1 =~= ex2
  e     =  u(3) - u(1)
sys = [x(1); x(2); x(3); x(1)];
% end mdlOutputs
