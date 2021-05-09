% 
% clc
% clear all

% MDP with 10 states and 2 actions.

T1m = [.90 .05 .05 .00 .00 .00 .00 .00 .00 .00;
     .00 .80 .15 .05 .00 .00 .00 .00 .00 .00;
     .00 .00 .85 .10 .05 .00 .00 .00 .00 .00;
     .00 .00 .00 .80 .10 .05 .05 .00 .00 .00;
     .00 .00 .00 .00 .75 .15 .05 .05 .00 .00;
     .00 .00 .00 .00 .00 .75 .15 .05 .05 .00;
     .00 .00 .00 .00 .00 .00 .70 .20 .05 .05;
     .00 .00 .00 .00 .00 .00 .00 .80 .10 .10;
     .00 .00 .00 .00 .00 .00 .00 .00 .90 .10;
     .00 .00 .00 .00 .00 .00 .00 .00 .00 1.0]; %Transition probabilities for do nothing
 
 T2m = [1.0 .00 .00 .00 .00 .00 .00 .00 .00 .00;
      1.0 .00 .00 .00 .00 .00 .00 .00 .00 .00;
      .95 .05 .00 .00 .00 .00 .00 .00 .00 .00;
      .80 .15 .05 .00 .00 .00 .00 .00 .00 .00;
      .00 .75 .15 .05 .05 .00 .00 .00  .00 .00;
      .00 .00 .75 .15 .05 .05 .00 .00 .00  .00;
      .00 .00 .00 .70 .20 .05 .05 .00 .00 .00 ;
      .00 .00 .00 .00 .70 .20 .05 .05 .00 .00 ;
      .00 .00 .00 .00 .00 .70 .20 .05 .05 .00 ;
      .00 .00 .00 .00 .00 .00 .70 .20 .05 .05]; %Transition probabilities for imperfect repair
 

gamma = .95; % discount factor  
c_s= [0 1 2 5 10 20 30 60 100 150]; % state cost
c_a= [0 75]; % action cost
horizon=45;  % total steps

% value iteration (based on Q-values)
V = zeros(10,horizon+1);
for i = horizon:-1:1
    for st = 1:10
        Q1 = c_s(st) + c_a(1) + gamma*T1m(st,:)*V(:,i+1); % Q value of action 1
        Q2 = c_s(st) + c_a(2) + gamma*T2m(st,:)*V(:,i+1); % Q value of action 2
        [V(st,i),policy(st,i)] = min([Q1;Q2]); % minQ 
    end
end


%Realization
s(1) = 3; %initial state

rng(1) % set random seed to reproduce simulation/plots

for t=2:horizon
    a(t-1) = policy(s(t-1),t-1);
   % a(t-1) = 1; %uncontrolled
    if a(t-1)==1
        s(t)=randsample(1:10,1,true,T1m(s(t-1),:));
    else
        s(t)=randsample(1:10,1,true,T2m(s(t-1),:));
    end
end

figure (1)       
plot(a,'-o')
title('Action history - One realization')
xlabel('time')
ylabel('action')

figure(2)
plot(s,'-o')
title('State history - One realization')
xlabel('time')
ylabel('state')

% figure(3)
% heatmap(policy)
% colorbar
% title('Optimum Policy')
% xlabel('time')
% ylabel('states')

% figure(4)
% heatmap(V)
% colorbar
% title('Value Function')
% xlabel('time')
% ylabel('states')


