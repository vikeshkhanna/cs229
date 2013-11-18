function err = train_test(train, num_teams, k, test, algorithm)
%TRAIN_TEST Summary of this function goes here
%   Runs a given algoroithm and reports the error

        if(strcmp(algorithm, 'svm'))
            model = SVMTrain(train, k, num_teams);
            correct = SVMTest(test, model, k, num_teams);
        elseif(strcmp(algorithm, 'log'))
            correct = 0;
        else
            printf('This algorithm is not supported');
            return;
        end
        
        err = sum(correct)/numel(correct);
end

