if exist('dataSize', 'var')
    for k = stimulationsToProcess
    %k = SA_STIM_OK;
        n = stimRef(1, k);
        if 0 == n
            continue;
        end
        if (1 == limitStimNumber)
            if n > 10
                n = 10;
            end
        end
        for electrode = electrodesArray
            clearvars frames;
            for i = 1:n
                time = stimRef(i + 1, k);
                startSample = ceil((time - windowBefore) * samplingFreq);
                endSample   = ceil((time + windowAfter ) * samplingFreq);
                if (endSample < dataSize)
                    frames(:, i) = dataArray(startSample:endSample, electrode);
                end
            end
            framesMean(:, electrode, k) = mean(frames(:,:), 2);
            % remove DC offset
            framesMean(:, electrode, k) = framesMean(:, electrode, k) - mean(framesMean(:, electrode, k));
        end   
    end
end
