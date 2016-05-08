if exist('stimRawFile', 'var')
    eval(sprintf('stimRaw = %s_S%i_StimRaw;', subjectInitials, sessionNo));
    [stimRawSize, temp]=size(stimRaw);
    clearvars stimArray;
    clearvars stimRef;
    stimArray = zeros(stimRawSize, SA_SIZEOF);
    stimArray(:,SA_TIME:SA_OV_STIM) = table2array(stimRaw(:,SA_TIME:SA_OV_STIM));
    stimRef = zeros(1, SA_SIZEOF);
    clearvars stimRaw;
end

if exist('dataRawFile', 'var')
    eval(sprintf('dataRaw = %s_S%i_DataRaw;', subjectInitials, sessionNo));
    dataArray = table2array(dataRaw(:, 1:width(dataRaw) - 1));
    dataHead = dataRaw.Properties.VariableNames;
    [dataSize, dataColumns] = size(dataArray);
    if (1 == refSubstract)
        refArray = table2array(dataRaw(:, refElectrode));
        dataArray(:, 2:dataColumns) = dataArray(:, 2:dataColumns) - refArray(:, ones(1, dataColumns - 1));
    end
    clearvars refArray;
    clearvars dataRaw;
end

electrodesArray = [];
electrodesNumber = 0;
if strcmp('all', electrodes)
    electrodesArray = 2:dataColumns;
else
    temp = size(electrodes);
    for i = 1:temp
        temp2 = electrodes(i,:);
        temp2 = find(ismember(dataHead, temp2, 'legacy'));
        electrodesArray = [electrodesArray temp2];
        electrodesNumber = electrodesNumber + 1;
    end
end