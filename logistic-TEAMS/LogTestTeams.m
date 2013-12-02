function [accuracy,prediction,conf]=LogTestTeams(modelax,train, num_of_teams, k)
% TESTING FOR MLR WITH DIFFERENT TEAMS THETAS

%clear;clc;
%run('dummyTrainTest');
%load EPL_2012_2013.csv.mat

%load trained_parameters
%num_of_teams = size(teams,1);
num_features = 3;
%k = 6;
gen_data = gentestdata(train,num_of_teams);

[st_pos,end_pos] = partition(train,-0.3,1);

index_of_boundaries = zeros(num_of_teams,2);
for i=1:num_of_teams
    [index_of_boundaries(i,1),index_of_boundaries(i,2)]=find_index_teams(i,k,train,st_pos,end_pos);
end

count = 1;
for mat_ID=st_pos:end_pos
    Xid = train(mat_ID,1);
    Yid = train(mat_ID,num_features+2);
    
    if ((~(index_of_boundaries(Xid,1)>mat_ID))&&(~(index_of_boundaries(Yid,1)>mat_ID)))
        pX = GetFeatures(Xid,mat_ID,gen_data,k);
        pY = GetFeatures(Yid,mat_ID,gen_data,k);
        
        % PREDICTION USING TEAM X
        feature_X = [pX 1] - [pY 0];
        %feature_X = pX-pY;
        pihat_X = mnrval(squeeze(modelax(Xid,:,:)),feature_X);
        
        % PREDICTION USING TEAM Y
        feature_Y = [pY 0] - [pX 1];
        %feature_Y = pY-pX;
        pihat_Y = mnrval(squeeze(modelax(Yid,:,:)),feature_Y);
        
        [max_X,ind_X] = max(pihat_X);
        [max_Y,ind_Y] = max(pihat_Y);
        if max_X>max_Y
            prediction(count) = ind_X;
            matches_predicted(count) = mat_ID;
            count = count+1;
        else
            if ind_Y==1
                prediction(count) = 2;
            elseif ind_Y==2
                prediction(count) = 1;
            else
                prediction(count) = 3;
            end
            matches_predicted(count) = mat_ID;
            count = count+1;
        end
    end
    
end

% CHECKING THE ACCURACY

label_column_for_all_games = train(:,end);
actual_labels = label_column_for_all_games(matches_predicted);
prediction = prediction';
% 1 - Wrong pred, 0 - Correct pred
correct = actual_labels - prediction;
non_zero_ind = find(correct);
correct_binary = correct;
correct_binary(non_zero_ind) = 1;

accuracy = 1-(sum(correct_binary)/numel(correct_binary));

% CONFUSION MATRIX
conf = zeros(3,3);
for k=1:numel(correct)
    for i=1:3
        for j=1:3
            if prediction(k)==j && actual_labels(k)==i
                conf(i,j) = conf(i,j)+1;
            end
        end
    end
end

end