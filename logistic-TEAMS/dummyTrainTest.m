load('EPL_2012_2013.csv.mat');
[n, m]= size(train);
model= LogTrainTeam(train, 1, n, 20, 4); 
