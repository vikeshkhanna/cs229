load('data/EPL_2012_2013.csv.mat');
test = train;
load('data/EPL_2012_2013.csv.mat');

evaluate(train, test, size(teams,1), 6, 'svm'); 