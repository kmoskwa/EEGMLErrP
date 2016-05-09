if exist('dataSize', 'var')
    if (1 == postFilterUse)        
        %filter = designfilt('bandpassfir', 'FilterOrder', 20, ...
        %                    'CutoffFrequency1',filterLo, ...
        %                    'CutoffFrequency2',filterHi, ...
        %                    'SampleRate', samplingFreq);

        filter = designfilt('bandpassiir', 'FilterOrder', 20, ...
                            'HalfPowerFrequency1',filterLo, ...
                            'HalfPowerFrequency2',filterHi, ...
                            'SampleRate', samplingFreq);        
        for k = stimulationsToProcess
            for electrode = electrodesArray
                dataToFilter = framesMean(:, electrode, k);
                dataFromFilter = filtfilt(filter, dataToFilter);
                framesMean(:, electrode, k) = dataFromFilter;
                clearvars dataToFilter;
                clearvars dataFromFilter;
            end
        end
    end
end
