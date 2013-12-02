function model = LogTrainTeam(performance, startpos, endpos, n_teams, k)
%LOGTRAINTEAM Summary of this function goes here
%   Detailed explanation goes here
testdata= gentestdata(performance, n_teams);
% get starting and ending indices for each team
indices= zeros(n_teams, 2);
for team= 1:n_teams
    [indices(team, 1), indices(team, 2)]= find_index_teams(team, k, performance, startpos, endpos);       
end
%disp(indices)
[~, n_features]= size(performance);
n_features= (n_features-3)/2;
new_n_features= n_features;   % one extra feature for home/ away
model= zeros(n_teams, new_n_features+1, 2);    % one extra theta for constant term
% now iterate over all teams and find their feature matrices
for team= 1:n_teams
    % find index in testdata corresponding to indices(team, 1)- starting
    % matchID, and indices(team, 2)- ending matchID
    test_start_pos= find(squeeze(testdata(team, :, n_features+2))==indices(team, 1));
    test_end_pos= find(squeeze(testdata(team, :, n_features+2))==indices(team, 2));

    % find number of features (matches) for team
    n_matches_team= test_end_pos- test_start_pos+1;
    %features= zeros(n_matches_team, new_n_features);
    %Y= zeros(n_matches_team, 1);
    %disp(team)
    %disp(test_start_pos)
    %disp(test_end_pos)
    continued_count=0;
    for testdata_row= test_start_pos:test_end_pos
        % get match ID
        matchID= testdata(team, testdata_row, n_features+2);
        % find opposing team ID, check if it's performance vector can be
        % calculated
        oppID= performance(matchID, n_features+2);
        if(indices(oppID, 1) > matchID)
            disp('to be continued')
            continued_count= continued_count+1;
            continue;
        end
        % find feature for team
        %fprintf('teamID= %d\n', team);
        %fprintf('matchID= %d\n', matchID);
        %fprintf('oppID= %d\n', oppID);
        %fprintf('k= %d\n', k);
        %fprintf('start index for opp= %d\n', indices(oppID, 1));
        %disp(squeeze(testdata(team, , :)))
        %disp(squeeze(testdata(oppID, matchID, :)))
        match_feature= GetFeatures(team, matchID, testdata, k) - GetFeatures(oppID, matchID, testdata, k);
        % append home/ away feature
%         
%         if(performance(matchID, 1)==team)
%             match_feature= [match_feature, 1];
%         else
%             match_feature= [match_feature, -1];
%         end
         index= testdata_row- test_start_pos + 1- continued_count;
        
        %fprintf('testdata_row= %d', testdata_row);
        %fprintf('index= %d\n', index);
        for f= 1:new_n_features
            features(index, f)= match_feature(f);
        end
        
        % also, store result in Y
        if(performance(matchID, 2*n_features+3)==1)   % home won
            if(performance(matchID, 1)==team) % team is home
                Y(index)= 1;
            else
                Y(index)= 2;
            end
        elseif(performance(matchID, 2*n_features+3)==2)   % home lost
            if(performance(matchID, 1)==team) % team is home
                Y(index)= 2;
            else
                Y(index)= 1;
            end
        else   % draw
            Y(index)= 3;
        end
            
    end
    % now we have the features matrix for team. Run the training algorithm
    % and find the theta values for team.
    mmm= mnrfit(features, Y);
    model(team, :, 1)= mmm(:, 1);
    model(team, :, 2)= mmm(:, 2);
end

