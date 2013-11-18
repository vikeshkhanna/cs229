function correct= SVMtest(testmatrix, model, k, n_teams) 
%load data2.mat;
%load new_trained_k_6.mat;
%[B,dev] = logist(performance,3);
%save trained_param

testdata = gentestdata(testmatrix, n_teams);
%ind1= find_index(testmatrix, k);
ind1 = 64; % Index of the first match to be tested
%k = 6; % The parameter "k"

[q1 q2 q3] = size(testdata);
[p1 p2] = size(testmatrix);
n_features= (p2-3)/2;

maxprob = zeros(numel(ind1:p1),1);
prediction = maxprob;
correct = maxprob;

for i=ind1:p1
    Xid = testmatrix(i, 1);
    Yid = testmatrix(i, n_features+2);
    prediction(i-ind1+1) = test(Xid, Yid, i, testdata, model, k);
    if prediction(i-ind1+1) == testmatrix(i,end)
        correct(i-ind1+1) = 1;
    end

end