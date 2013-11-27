function density(X, heading)
%density Plot the histogram of a set of values
%   
n=30;
cols = size(X, 2);

approx = zeros(size(X));
snap = zeros(n, cols);
sz = zeros(1, cols);
sz(:) = n;

for i=1:cols
    snap(:,i) = linspace(min(X(:,i)), max(X(:,i)), n);
end

for i=1:cols
    approx(:,i) = interp1(snap(:,i), 1:numel(snap(:,i)), X(:,i), 'nearest');
end

disp(approx);
disp(sz);

Z = accumarray(approx, 1, sz);
surf(Z);

title(heading);

end


