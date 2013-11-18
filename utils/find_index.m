function ind = find_index(train, num_teams, k)
    [m, n] = size(train);
    count = zeros(num_teams, 1);
    
    num_features = (n-3)/2;
    
    for i=1:m
        % ID of team 1
        xid = train(i,1);
        % ID for team 2
        yid = train(i, num_features +2);
        
        count(xid) = count(xid)+1;
        count(yid) = count(yid)+1;
        
        % When every time has played at least k matches, return that index
        if(min(count)>=k)
                ind=i;
                break;
        end
    end
end
