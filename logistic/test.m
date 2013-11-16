function prediction= test(Xid, Yid, matchID, testdata, B, k)
% find row corresponding to matchID for both X and Y
[n_players, n_matches, n_features]=size(testdata);
for match= 1:n_matches
	if testdata(Xid, match, 1)==matchID
		Xrow= match;
	end
	if testdata(Yid, match, 1)==matchID
		Yrow= match;
	end
endfor
% find average performance matrices of X and Y for the last k matches
pX= zeros(1, n_features);
pY= zeros(1, n_features);

for xr= Xrow-k:Xrow
	pX+= testdata(Xid, xr, :);
for yr= Yrow-k:Yrow
	pY+= testdata(Yid, yr, :);
% find difference between performance matrices
diff= pX-pY;
predProb= mnrval(B, diff);
% return the prediction with the highest probability
[maxprob, prediction]= max(predProb);

