load 'data.mat';
testdata= gentestdata(performance, teams);
%disp(testdata)
%display data of team 3
disp(testdata(3, :, :))
