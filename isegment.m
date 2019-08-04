function [data, label]=isegment(id)
%ISEGMENT        SEGMENTS DATA FOR ANY SUBJECT
%
%                id ..............subject number (choices: 1-62)
%                data.............EEG data
%                label............label related to data(with considering
%                                 annotation)
%                requires ann.mat file that includes annotations and
%                segment function
%
%
%USAGE
%                [data2, label2]=isegment(2)
%
%
%                Authored by , Apdullah Yayık 2019


l=load('ann.mat'); % 0 left fist, 1 right fist
if (id<10)
    filename4=sprintf('%s%d%s', 'S00', id, 'R04');
    filename8=sprintf('%s%d%s', 'S00', id, 'R08');
    filename12=sprintf('%s%d%s', 'S00', id, 'R12');
elseif(id<100)
    filename4=sprintf('%s%d%s', 'S0', id, 'R04');
    filename8=sprintf('%s%d%s', 'S0', id, 'R08');
    filename12=sprintf('%s%d%s', 'S0', id, 'R12');
    
elseif(id<=109)
    filename4=sprintf('%s%d%s', 'S', id, 'R04');
    filename8=sprintf('%s%d%s', 'S', id, 'R08');
    filename12=sprintf('%s%d%s', 'S', id, 'R12');
end

[label4,   imag4]  = segmentdata(filename4,  l.ann(   (((id-1)*3))  + 1, :) );
[label8,   imag8]  = segmentdata(filename8,  l.ann(   (((id-1)*3))  + 2, :) );
[label12,  imag12] = segmentdata(filename12, l.ann(   (((id-1)*3))  + 3, :) );
data  =[imag4;  imag8;  imag12];
label =[label4; label8; label12];

end

function  [label, leftright] =segmentdata(subjectFile, annonation)
% Retrieves left and right labelled data


load(subjectFile);
record(:,end)=[];
record=record';
% load data
% channelRange=[9,  11,  13, 30, 32, 34, 36, 38, 49, 51, 53]; % C3-C4-Cz
% channelRange=[9, 11,13]; % C3-C4-Cz
channelRange=1:64;
channelNumber=length(channelRange);
leftFistRealS001R03=zeros(channelNumber*15, 656); % initilize
rightFistRealS001R03=zeros(channelNumber*15, 656);
for ti=1:15 % trial number
    switch annonation(ti)
        case 0
            leftFistRealS001R03((ti-1)*channelNumber+1: ti*channelNumber,:)=record(channelRange,(ti*656)+(ti-1)*656+1: (ti*656)+(ti-1)*656+656);
        case 1
            rightFistRealS001R03((ti-1)*channelNumber+1: ti*channelNumber,:)=record(channelRange,(ti*656)+(ti-1)*656+1: (ti*656)+(ti-1)*656+656);
    end
end
%clear rows that have all zero value
leftFistRealS001R03( ~any(leftFistRealS001R03,2), : ) = [];
rightFistRealS001R03( ~any(rightFistRealS001R03,2), : ) = [];
% return
lengthleft=size(leftFistRealS001R03, 1)/channelNumber;
lengthright=size(rightFistRealS001R03, 1)/channelNumber;
label=[zeros(1, lengthleft)' ; ones(1, lengthright)'];
leftright=[leftFistRealS001R03; rightFistRealS001R03];
end
