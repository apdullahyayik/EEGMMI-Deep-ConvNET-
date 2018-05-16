% all subjects
clearvars
data=[]; label=[];
for i=1:62
    [data_n, label_n]=isegment(i);
    data=[data; data_n];
    label=[label; label_n];
end
% check size
% data= 64*62*15*3
% label=data/64


data=data';
for pwi=1:size(data,2)
    pwi
    [pw(:,pwi), fw]=pwelch(data(:,pwi),   hann(100), 50, 50,160);
end
save pw pw

load('pw.mat')
res_pw=1/(100/160);
alpha_pw=pw(4:11,:); % 9.6-32 Hz
dataconcat=concat(alpha_pw', 64);

% 2200 train
% 590 test
class1=find(label==1);
class0=find(label==0);
trainclass1=dataconcat(class1(1:1100),:);
trainclass0=dataconcat(class0(1:1100),:);
traindata=[trainclass1; trainclass0];
labeltrain=[ones(1,1100)'; zeros(1,1100)'];

testclass1=dataconcat(class1(1101:end),:);
testclass0=dataconcat(class0(1101:end),:);
testdata=[testclass1; testclass0];
labeltest=[ones(1,278)'; zeros(1,312)'];






