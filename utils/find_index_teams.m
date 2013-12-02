function [i1, i2 ] = find_index_teams( teamID, k, train, startpos, endpos)
%FIND_INDEX_TEAMS 
%   Returns the start and end indices for a team so that the start index
%   skips at least k matches for this team and end is the last index of
%   that match. i1 and i2 lie between start and end. 

rows = size(train, 1);
cols = size(train, 2);
i1 = -1;

num_features = (cols-1)/2-1;

cnt = 0;

for i=1:rows
    id1 = train(i, 1);
    id2 = train(i, num_features + 2);
    
    if(id1==teamID || id2==teamID)
        cnt = cnt+1;
    end
    
    if(cnt==k)
        i1=i;
        break;
    end
end

reset = false;

if(i1==-1)  
reset = true;
end

for i=startpos:endpos
    id1 = train(i, 1);
    id2 = train(i, num_features + 2);

    if(id1==teamID || id2==teamID)
        if(~reset)
            reset = true;
            i1=max(i, i1);
        end
        
        i2=i;   
    end
end;

end

