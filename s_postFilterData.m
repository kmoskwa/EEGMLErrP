if exist('dataSize', 'var')
    if (filterUse > 10)        
        %filter = designfilt('bandpassfir', 'FilterOrder', 20, ...
        %                    'CutoffFrequency1',filterLo, ...
        %                    'CutoffFrequency2',filterHi, ...
        %                    'SampleRate', samplingFreq);

        filterD = designfilt('bandpassiir', 'FilterOrder', 20, ...
                            'HalfPowerFrequency1',filterLo, ...
                            'HalfPowerFrequency2',filterHi, ...
                            'SampleRate', samplingFreq);        
        for k = stimulationsToProcess
            n = stimRef(1, k);
            if 0 == n
                % skip entries without valid stimulations
                continue;
            end
            for electrode = electrodesArray
                dataToFilter = framesMean(:, electrode, k);
                if (11 == filterUse)
                    dataFromFilter = filtfilt(filterD, dataToFilter);
                end
                if (12 == filterUse)
                    dataFromFilter = filter(filterD, dataToFilter);
                end
                framesMean(:, electrode, k) = dataFromFilter;
                clearvars dataToFilter;
                clearvars dataFromFilter;
            end
        end
    end
end
