if exist('dataSize', 'var')
    clearvars frames;
    clf;
    for k = stimulationsToProcess
    %k = SA_STIM_OK;
        n = stimRef(1, k);
        if (limitStimNumber > 0)
            if n > limitStimNumber
                n = limitStimNumber;
                stimRef(1, k) = n;
            end      
        end
        if 0 == n
            % skip entries without valid stimulations
            continue;
        end
        for electrode = electrodesArray
            for i = 1:n
                time = stimRef(i + 1, k);
                startSample = ceil((time - windowBefore) * samplingFreq);
                endSample   = ceil((time + windowAfter ) * samplingFreq);
                if (endSample < dataSize)
                    frames(:, i, electrode, k) = dataArray(startSample:endSample, electrode);
                    frames(:, i, electrode, k) = frames(:, i, electrode, k) - mean(frames(:, i, electrode, k));
                    if (1 == drawIntermediate)
                        plot(frames(:, i, electrode, k)); pause(0.1);
                    end
                end
            end
        end   
    end
    
    for k = stimulationsToProcess
        n = stimRef(1, k);
        if 0 == n
            % skip entries without valid stimulations
            continue;
        end
        for electrode = electrodesArray
            %second dimension needsd to be defined as 1:n cause whole array
            %has dimension of greatest number of stimulations, so without
            %such constraint, mean would be improperly calculated
            meanTemp = frames(:, 1:n, electrode, k);
            framesMean(:, electrode, k) = mean(meanTemp(:, :), 2);
            % remove DC offset
            %framesMean(:, electrode, k) = framesMean(:, electrode, k) - mean(framesMean(:, electrode, k));
            %framesMean(:, electrode, k) = filtfilt(filter, framesMean(:, electrode, k));
        end   
    end
end