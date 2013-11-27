function [prediction]= test_s(Xid, Yid, matchID, testdata, model, k)
% find row corresponding to matchID for both X and Y
<<<<<<< HEAD
%[~, ~, n_features]=size(testdata);

%Xrow = find(squeeze(testdata(Xid,:,n_features))==matchID);
%Yrow = find(squeeze(testdata(Yid,:,n_features))==matchID);

% find average performance matrices of X and Y for the last k matches
%pX = sum(squeeze(testdata(Xid,Xrow-k:Xrow-1,1:end-2)),1);
%pY = sum(squeeze(testdata(Yid,Yrow-k:Yrow-1,1:end-2)),1);

pX= GetFeatures(Xid, matchID, testdata, k);
pY= GetFeatures(Yid, matchID, testdata, k);
=======
[~, ~, n_features]=size(testdata);

Xrow = find(squeeze(testdata(Xid,:,n_features))==matchID);
Yrow = find(squeeze(testdata(Yid,:,n_features))==matchID);

% find average performance matrices of X and Y for the last k matches
pX = sum(squeeze(testdata(Xid,Xrow-k:Xrow-1,1:end-2)),1);
pY = sum(squeeze(testdata(Yid,Yrow-k:Yrow-1,1:end-2)),1);


>>>>>>> bb7715c0c0de42d3318f01ff197bb688f85c008d
% find difference between performance matrices
diff= (pX-pY)/k;

[prediction, ~, ~] = predict(1, sparse(diff), model);

end