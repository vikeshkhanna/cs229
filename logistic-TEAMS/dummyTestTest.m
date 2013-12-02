load('EPL_2012_2013.csv.mat');
[n, m]= size(train);
num_of_teams = 20;
k = 6;
model= LogTrainTeam(train, 1, n, num_of_teams, k); 
[accuracy,prediction,conf]=LogTestTeams(model,train, num_of_teams, k);
