% plots the features to check for gaussian distribution
n_teams= 20;
k= 4;
load('EPL_2013_2014.csv.mat');
% matrix train is loaded
% for every match that is win/ loss/ draw, get the team ID of winning/
% losing/ both teams and get their features
testdata= gentestdata(train, n_teams);
minIndex= find_index(train, n_teams, k);
[n_matches, n_columns]= size(train);

n_features= (n_columns-3)/2;
disp(n_features)

% now there are 2*n_draws drawed teams, and (n_matches-n_draws) winning and
% losing teams

n_winLose=0
n_draws=0
for i= minIndex:n_matches
    if train(i, n_columns)== 1
         n_winLose= n_winLose+1
    elseif train(i, n_columns)== 2
         n_winLose= n_winLose+1
    elseif train(i, n_columns)== 3
         n_draws= n_draws+1
    end
end

winMatrix= zeros(n_winLose, n_features);
loseMatrix= zeros(n_winLose, n_features);
drawMatrix= zeros(2*n_draws, n_features);
winLoseIndex=1;
drawIndex=1;
for i= minIndex:n_matches
        if train(i, n_columns)== 1  % home team wins
            winMatrix(winLoseIndex, :)= GetFeatures(train(i, 1), i, testdata, k);
            loseMatrix(winLoseIndex, :)= GetFeatures(train(i, n_features+2), i, testdata, k);
            winLoseIndex= winLoseIndex + 1;
        elseif train(i, n_columns)== 2 % away team wins
            winMatrix(winLoseIndex, :)= GetFeatures(train(i, n_features+2), i, testdata, k);
            loseMatrix(winLoseIndex, :)= GetFeatures(train(i, 1), i, testdata, k);
            winLoseIndex= winLoseIndex+1;
        elseif train(i, n_columns)== 3 % draw for both
            drawMatrix(drawIndex, :)= GetFeatures(train(i, 1), i, testdata, k);
            drawIndex= drawIndex+1;
            drawMatrix(drawIndex, :)= GetFeatures(train(i, n_features+2), i, testdata, k);
            drawIndex= drawIndex+1;
        end
end

%density(winMatrix, 1);
%density(loseMatrix, 0);
%density(drawMatrix, 2);
            