function [testdata]= gentestdata(fmat, n_teams)
% fmat is the feature matrix having f features per team- the first column is teamID for home team,
% next f columns are features for home team, next column is teamID for away team, 
% next f are features for away team, last column is the y vector 

%[n_teams, ~]= size(teams);
[n_rows, n_columns]= size(fmat);
n_features= (n_columns-3)/2;        % check if int
%matches_per_team= 2*n_rows/n_teams;        % check if int

count = zeros(n_teams, 1);
 for i=1:n_rows
        % ID of team 1
        xid = fmat(i,1);
        % ID for team 2
        yid = fmat(i, n_features +2);
        count(xid) = count(xid)+1;
        count(yid) = count(yid)+1;

matches_per_team= max(count);
    
testdata= zeros(n_teams, matches_per_team, n_features+2); 
% Extra 2 - One indicates home/away (1/0) and match ID
match_count= zeros(n_teams);

for r= 1:n_rows
        team1id= fmat(r, 1);
        match_count(team1id) = match_count(team1id) + 1;
        testdata(team1id,match_count(team1id),1:end-2) = fmat(r,2:n_features+1);
        testdata(team1id,match_count(team1id),end-1:end) = [1 r];
       
        team2id= fmat(r, n_features+2);
       
        match_count(team2id)= match_count(team2id) + 1;
        testdata(team2id,match_count(team2id),1:end-2) = fmat(r,n_features+3:2*n_features+2);
        testdata(team2id,match_count(team2id),end-1:end) = [0 r];
        
end


end