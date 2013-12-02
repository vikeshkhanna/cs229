function correct= LogTest(testmatrix, model, k, n_teams)
% Testing the Logistic Regression
%load data2.mat;
%load new_trained_k_5.mat;
%[B,dev] = logist(performance,3);
%save trained_param

A = gentestdata(testmatrix, n_teams);
%ind1 = 60; % Index of the first match to be tested
%k = 5; % The parameter "k"
ind1= find_index(testmatrix, n_teams, k)

[q1 q2 q3] = size(A);
[p1 p2] = size(testmatrix);
n_features= (p2-3)/2;

maxprob = zeros(numel(ind1:p1),1);
prediction = maxprob;
correct = maxprob;

for i=ind1:p1

    Xid = testmatrix(i, 1);
    Yid = testmatrix(i, n_features+2);
    [maxprob(i-ind1+1),prediction(i-ind1+1)]= test(Xid, Yid, i, A, model, k);
    
    if prediction(i-ind1+1) == testmatrix(i,end)
        correct(i-ind1+1) = 1;
    end

end