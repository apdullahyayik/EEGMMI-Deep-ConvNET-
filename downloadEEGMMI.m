function downloadEEGMMI(subject, task)
%DOWNLOADEEGMMI    Downloads and saves EEGMMI dataset  with corresponding events event
%
%                X .................vector includes subject ids to be downloaded (1-109)
%                n..................tasks to be downloaded (1-14)
%
%USAGE
%                subject=1:15
%		 task=[2,5,7]
%                downloadEEGMMI(subject, task)
%FILES
%		 S001R08.mat.......data file id:1, task: 8
%	         ann_S001R08.mat...event file id:1, task: 8
%
% 
%                                  Authored by , Apdullah Yayık 2018






for i=1:length(subject) %109
    for j=1:length(task) %14%14
        if subject(i)<10 && task(j)<10
            filename=sprintf('%s%d%s%d%s%d%s', 'eegmmidb/S00',subject(i), '/S00', subject(i), 'R0', task(j), '.edf');
        elseif subject(i)<10 && task(j)>10
            filename=sprintf('%s%d%s%d%s%d%s', 'eegmmidb/S00',subject(i), '/S00', subject(i), 'R', task(j), '.edf');
        elseif subject(i)<100 && task(j)<10
            filename=sprintf('%s%d%s%d%s%d%s', 'eegmmidb/S0',subject(i), '/S0', subject(i), 'R0', task(j), '.edf');
        elseif subject(i)<100 && task(j)>10
            filename=sprintf('%s%d%s%d%s%d%s', 'eegmmidb/S0',subject(i), '/S0', subject(i), 'R', task(j), '.edf');
        elseif subject(i)>=100 && task(j)<10
            filename=sprintf('%s%d%s%d%s%d%s', 'eegmmidb/S',subject(i), '/S', subject(i), 'R0', task(j), '.edf');
        elseif subject(i)>=100 && task(j)>10
            filename=sprintf('%s%d%s%d%s%d%s', 'eegmmidb/S',subject(i), '/S', subject(i), 'R', task(j), '.edf');
        end
        
        disp(filename)
        [record,~,~]=rdsamp(filename); % 120.4 sec
        signalname=sprintf('%s%s', filename(15:22), 'mat');
        save ( signalname, 'record')
        clear record
        clear signalname
        
        [~,~,~,~,~,ann]=rdann('eegmmidb/S002/S002R03', 'edf.event');
        annotation =extractann(ann);
        clear ann
        annotationname=sprintf('%s%s%s', 'ann_',filename(15:22), 'mat');
        save (annotationname, 'annotation')
        clear annotation
        clear annotationname
        
    end
end
end


function annotation =extractann(ann)
% Extracts given ann (T1-->0 and T2-->1)



annotation=[];
for i=1:length(ann)
    switch  str2double(ann{i}(2))
        case 1
            annotation=[annotation, 0];
        case 2
            annotation=[annotation, 1];
    end
end
end

