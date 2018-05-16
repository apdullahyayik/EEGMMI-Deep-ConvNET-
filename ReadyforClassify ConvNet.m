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

feature_all=tempimag(data, 64);
cd all_subjects
sendimage2folders(feature_all, label)


