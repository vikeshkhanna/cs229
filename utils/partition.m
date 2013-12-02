function [ startpos, endpos ] = partition( X, slicep1, slicep2)
%PARTITION Returns 
%   Returns the indices of X that correspond to the chunk of X between
%   slicep1 and slicep2 (fractions). If either of these values is negative,
%   it is taken from the end of X (row-wise).

n = size(X,1);

p1=0;
p2=slicep2;

if(slicep1<0)
    p1=1+slicep1;
end

if(slicep2<0)
    p2 = 1+slicep2;
end

startpos = floor(n*p1)+1;
endpos = floor(n*p2);

end

