function [maxprob,prediction]= test(Xid, Yid, matchID, testdata, B, k)
	% find row corresponding to matchID for both X and Y
	[~, ~, n_features]=size(testdata);
	Xrow = find(squeeze(testdata(Xid,:,n_features))==matchID);
	Yrow = find(squeeze(testdata(Yid,:,n_features))==matchID);
	% find average performance matrices of X and Y for the last k matches
	pX = sum(squeeze(testdata(Xid,Xrow-k:Xrow-1,1:end-2)),1);
	pY = sum(squeeze(testdata(Yid,Yrow-k:Yrow-1,1:end-2)),1);
	% find difference between performance matrices
	diff= (pX-pY)/k;
    disp(diff)
    disp(pX)
    disp(pY)
    predProb= mnrval(B, diff);
	% return the prediction with the highest probability
	[maxprob, prediction]= max(predProb);
end
