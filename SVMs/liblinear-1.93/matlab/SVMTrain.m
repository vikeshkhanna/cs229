function model= SVMtrain(k, n_teams, traindata)


[testdata] = gentestdata(traindata, n_teams);

%ind1 = 64; % Index of the first match to be TRAINED
%k = 6; % The parameter "k"
%n_teams= size(teams);
ind1 = find_index(traindata, n_teams, k)
[q1 q2 q3] = size(testdata);
[p1 p2] = size(traindata);
n_features_tx= (p2-3)/2;

maxprob = zeros(numel(ind1:p1),1);
prediction = maxprob;
correct = maxprob;

new_train_matrix = zeros(numel(ind1:p1),n_features_tx+1);
for i=ind1:p1
    Xid = traindata(i, 1);
    Yid = traindata(i, n_features_tx+2);
    [~, ~, n_features]=size(testdata);
    Xrow = find(squeeze(testdata(Xid,:,n_features))==i);
    Yrow = find(squeeze(testdata(Yid,:,n_features))==i);
    % find average traindata matrices of X and Y for the last k matches
    pX = sum(squeeze(testdata(Xid,Xrow-k:Xrow-1,1:end-2)),1)/k;
    pY = sum(squeeze(testdata(Yid,Yrow-k:Yrow-1,1:end-2)),1)/k;
    new_train_matrix(i-ind1+1,:) = [pX-pY traindata(i,end)];
end

%[B_new,dev] = logist(new_train_matrix,3);
training_label_vector = new_train_matrix(:,end);
training_instance_matrix = sparse(new_train_matrix(:,1:end-1));
model = train(training_label_vector, training_instance_matrix);

%clearvars -except model
%save new_trained_k_6