% LOGISTIC REGRESSION FOR EPL

function [B, dev] = logist(train,num_features)

[~, n] = size(train);
train_last = train(:,n);

%ind0 = find(train_l==0);
%ind1 = find(train_l==1);
%ind2 = find(train_l==2);

x1 = train(:,2:num_features+1);
x2 = train(:,num_features+3:end-1);

X = x1-x2;
Y = train_last;

% X contains the difference of perf attributes
% Y contains the labels (1/2/3)
[B, dev] = mnrfit(X,Y);

end