load('data/EPL_2013_2014.csv.mat');
test = train;
load('data/EPL_2012_2013.csv.mat');

err= evaluate(train, test, size(teams,1), 4, 'svm'); 