function [ pX ] = GetFeatures( Xid, matchID, testdata, k )
% Returns the average performance of team Xid for k matches preceeding
% match no. matchID given the testdata matrix (3 dim. matrix)
	[~, ~, n_features]=size(testdata);
	Xrow = find(squeeze(testdata(Xid,:,n_features))==matchID);
	pX = sum(squeeze(testdata(Xid,Xrow-k:Xrow-1,1:end-2)),1);
end

