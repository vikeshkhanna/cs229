function conf= getConf(prediction, actual)
%GETACC Summary of this function goes here
%   Detailed explanation goes here
% CONFUSION MATRIX
conf = zeros(3,3);
for k=1:numel(prediction)
    for i=1:3
        for j=1:3
            if prediction(k)==j && actual(k)==i
                conf(i,j) = conf(i,j)+1;
            end
        end
    end
end    
    

end

