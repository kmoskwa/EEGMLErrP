if exist('dataSize', 'var')
    if ((filterUse > 0) && (filterUse < 10))
        %filter = designfilt('bandpassfir', 'FilterOrder', 20, ...
        %                    'CutoffFrequency1',filterLo, ...
        %                    'CutoffFrequency2',filterHi, ...
        %                    'SampleRate', samplingFreq);
        
        filterD = designfilt('bandpassiir', 'FilterOrder', 20, ...
                            'HalfPowerFrequency1',filterLo, ...
                            'HalfPowerFrequency2',filterHi, ...
                            'SampleRate', samplingFreq); 
        [b3, a3] = butter(4,[filterLo filterHi]/(samplingFreq/2.0),'bandpass');%filtr wycinajacy [5 10] hz
                        
        for electrode = electrodesArray
            dataToFilter = dataArray(:, electrode);
            if (1 == filterUse)
                dataFromFilter = filtfilt(filterD, dataToFilter);
            end
            if (2 == filterUse)
                dataFromFilter = filter(filterD, dataToFilter);
            end
            if (3 == filterUse)
                dataFromFilter = filtfilt(b3, a3, dataToFilter);
            end
            if (4 == filterUse)
                dataFromFilter = filter(b3, a3, dataToFilter);
            end

            dataArray(:, electrode) = dataFromFilter;
            clearvars dataToFilter;
            clearvars dataFromFilter;
        end
    end
end
