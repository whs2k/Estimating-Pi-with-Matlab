% QFA
% Topic 3: Monte Carlo & Options Pricing
% updated on 02/11/2013


function MC_estimatePi_withError
%Estimate pi using Monte Carlo to simulate dart shooting

clc;
clear;
format short g;

% This code will execute the Monte Carlo simulation just once
N = 1000;
score = shootingDart(N);
estimated_pi = 4*mean(score);
std_error = std(4*score)/sqrt(N);

disp('         Pi     Pi estimate     SEM')
disp([pi, estimated_pi, std_error]);

%now display a confidence interval
z_confidence = norminv(.975); %2-sided 95% interval; 
                              %note: if you use .025 instead of .975, this 
                              %will be negative
                              
min_of_interval = estimated_pi - z_confidence*std_error;
max_of_interval = estimated_pi + z_confidence*std_error;
disp('95% Confidence Interval:');
fprintf('[%g, %g]',min_of_interval,max_of_interval); 
disp(' ');
disp(' ');


%This code executes the Monte Carlo simulation multiple times with 
% increasing values for N, showing convergence
power = 1:6;
N = 10.^power;
estimated_pi = zeros( length(N), 1);
std_error = zeros( length(N),1);

for k = 1:length(N)
    current_N = N(k);
    score = shootingDart( current_N );
    estimated_pi(k) = 4*mean(score);
    std_error(k) = std(4*score)/sqrt(current_N);
end

format shortg
disp('             N   Pi estimate   SEM');
disp( [N', estimated_pi, std_error]);

%You could also use fprintf to display your results
disp(' ');
disp(' ');
disp(' ');
disp('Same results using fprintf()');
fprintf('%10s %15s %10s\n','N','Pi Estimate','SEM');
fprintf('%10d %15g %10g\n', [N; estimated_pi'; std_error']);

%This is a nested function. Note that we can only use nested functions in a
%function file (i.e., we cannot create a nested function in a script file. 
function score = shootingDart(n)
% generate random number I to estimate pie

%%%%%%%%%%%%%%%%%%%%%
% Vectorized Version%
%%%%%%%%%%%%%%%%%%%%%
x1 = rand(n,1);
x2 = rand(n,1);
sum_of_x_squares = x1.^2 + x2.^2;
score = (sum_of_x_squares <= 1);

% % non-vectorized version
% score = zeros(n,1);
% for i = 1:n
%     x1 = rand; 
%     x2 = rand;
%     sum_of_x_squares = x1*x1 + x2*x2;
%     if sum_of_x_squares <= 1
%         score(i) = 1;
%     end
% end


