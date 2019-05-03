function [ fal ] = fal_q(e,a,delta)
% fal Summary of this function goes here
% fal is the nonlinear control combination function 
% at the extended state observer level (delta->h)

if abs(e) > delta;
    fal = ((abs(e))^a) * sign(e);
else
    fal = e/(delta^(1-a));
end

end

