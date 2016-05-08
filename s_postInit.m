if exist('stimRawFile', 'var')
    %stimRawName        = PG_S1_StimRaw;
    eval(sprintf('stimRaw = %s_S%i_StimRaw;', subjectInitials, sessionNo));
    [stimRawSize, temp]=size(stimRaw);
    %[stimRawSize, temp]=size(PG_S1_StimRaw);
    clearvars stimArray;
    clearvars stimRef;
    stimArray = zeros(stimRawSize, SA_SIZEOF);
    stimArray(:,SA_TIME:SA_OV_STIM) = table2array(stimRaw(:,SA_TIME:SA_OV_STIM));
    stimRef = zeros(1, SA_SIZEOF);
    clearvars stimRaw;
end

if exist('dataRawFile', 'var')
    eval(sprintf('dataRaw = %s_S%i_DataRaw;', subjectInitials, sessionNo));
    %eval(sprintf('dataRawHead = %s_S%i_DataRawHead;', subjectInitials, sessionNo));
    %[dataSize, dataColumns]=size(dataRaw);
    %[dataSize, dataColumns]=size(PG_S1_DataRaw);
    dataArray = table2array(dataRaw(:, 1:width(dataRaw) - 1));
    %dataHead  = dataRawHead;
    dataHead = dataRaw.Properties.VariableNames;
    [dataSize, dataColumns]=size(dataArray);
    clearvars dataRaw;
    %clearvars dataRawHead;
end

if exist('dataOVPFile', 'var')
    eval(sprintf('dataOVP = %s_S%i_DataOVP;', subjectInitials, sessionNo));
    %eval(sprintf('dataOVPHead = %s_S%i_DataOVPHead;', subjectInitials, sessionNo));
    %[dataSize, dataColumns]=size(dataOVP);
    %dataArray = dataOVP;
    %dataHead  = dataOVPHead;
    dataArray = table2array(dataOVP(:, 1:width(dataOVP) - 1));
    dataHead = dataOVP.Properties.VariableNames;
    [dataSize, dataColumns]=size(dataArray);
    clearvars dataOVP;
    %clearvars dataOVPHead;
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