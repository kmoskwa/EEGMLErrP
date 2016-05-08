if exist('dataSize', 'var')
    if (1 == filterUse)        
        %filter = designfilt('bandpassfir', 'FilterOrder', 20, ...
        %                    'CutoffFrequency1',filterLo, ...
        %                    'CutoffFrequency2',filterHi, ...
        %                    'SampleRate', samplingFreq);

        filter = designfilt('bandpassiir', 'FilterOrder', 20, ...
                            'HalfPowerFrequency1',filterLo, ...
                            'HalfPowerFrequency2',filterHi, ...
                            'SampleRate', samplingFreq);        
        for electrode = electrodesArray
            dataToFilter = dataArray(:, electrode);
            dataFromFilter = filtfilt(filter, dataToFilter);
            dataArray(:, electrode)= dataFromFilter;
            clearvars dataToFilter;
            clearvars dataFromFilter;
        end
    end
end
