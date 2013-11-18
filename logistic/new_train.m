% TRAINING LOGISTIC - NEW WAY
clear;clc;
load ('data.mat');
[testdata]= gentestdata(performance, teams);

ind1 = 64; % Index of the first match to be TRAINED
k = 3; % The parameter "k"

[q1 q2 q3] = size(testdata);
[p1 p2] = size(performance);
n_features_tx= (p2-3)/2;

maxprob = zeros(numel(ind1:p1),1);
prediction = maxprob;
correct = maxprob;

new_train_matrix = zeros(numel(ind1:p1),p2);
for i=ind1:p1

    Xid = performance(i, 1);
    Yid = performance(i, n_features_tx+2);
    
    [~, ~, n_features]=size(testdata);

Xrow = find(squeeze(testdata(Xid,:,n_features))==i);
Yrow = find(squeeze(testdata(Yid,:,n_features))==i);

% find average performance matrices of X and Y for the last k matches
pX = sum(squeeze(testdata(Xid,Xrow-k:Xrow-1,1:end-2)),1)/k;
pY = sum(squeeze(testdata(Yid,Yrow-k:Yrow-1,1:end-2)),1)/k;

new_train_matrix(i-ind1+1,:) = [Xid pX Yid pY performance(i,end)];
end

[B_new,dev] = logist(new_train_matrix,3);
save new_trained_k_3