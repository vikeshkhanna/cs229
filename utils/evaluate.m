function err = evaluate(train, test, num_teams, k, algorithm)
    [m, n] = size(train)
    min_training_set = m/4;
    err = zeros(m-min_training_set + 1, 2);
    
    for i=min_training_set:m
            error = train_test(train(1:i,:), num_teams, k, test, algorithm);
            err(i,1) = i;
            err(i,2) = error;
    end
end
