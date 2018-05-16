function feature=tempimag(data, channelnumber)
%TEMPIMAG    CONTRUCTS TEMPORAL IMAGES
%
%                data ..............EEG data (each row corresponds to a channel X trials)
%                channelnumber......Number of channles 
%                feature............Images related to each trial with
%                                   struct  data type
%
%USAGE
%                data=randn(2880, 656);
%                feature=tempimag(data, 64);
%                figure, imshow(feature.images{1})
%
%
%
%              Authored by , Apdullah Yayık 2018

trialnumber=size(data,1)/channelnumber;
for p=1:trialnumber
    trial=data((p-1)*channelnumber+1:p*channelnumber,:);
    feature.images{p}=trial;
end
end
