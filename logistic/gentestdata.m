function testdata= gentestdata(fmat, teams)
% fmat is the feature matrix having f features per team- the first column is teamID for home team, next f columns are features for home team, next column is teamID for away team, next f are features for away team, last column is the y vector 
[n_teams, char]= size(teams);
[n_rows, n_columns]= size(fmat);
n_features= (n_columns-3)/2;	% check if int
matches_per_team= n_rows/n_teams;	% check if int
testdata= zeros(n_teams, matches_per_team, n_features);
match_count= zeros(n_teams);

for r= 1:n_rows
	team1id= fmat(r, 1);
	match_count(team1id)+= 1;
	for f= 2:n_features+1
		%printf("match no, team no, feature no.= %d %d %d \n", team1id, match_count(team1id), f)
		testdata(team1id, match_count(team1id), f)= fmat(r, f);
	endfor
	team2id= fmat(r, n_features+2);
	%printf("r= %d, n_features+1= %d, team2id= %d \n", r, n_features+1, team2id)
	match_count(team2id)+= 1;
	for f= n_features+3:2*n_features+2
		testdata(team2id, match_count(team2id), f)= fmat(r, f);
	endfor
endfor
		
	  
	

