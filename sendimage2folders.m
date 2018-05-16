function sendimage2folders(feature, label)
% sends images to labeled folder 



mkdir('0'), mkdir('1')
for i=1:45*62
    name=sprintf('%s%d%s', 'image', i,'.png');
    switch label(i)
        case 0
            cd('/media/abd/Yeni Birim/Motor Imagery ConvNET/all_subjects/0')
            imwrite(feature.images{i}, name)
        case 1
            cd('/media/abd/Yeni Birim/Motor Imagery ConvNET/all_subjects/1')
            imwrite(feature.images{i}, name)
    end
    cd('/media/abd/Yeni Birim/Motor Imagery ConvNET')
end
