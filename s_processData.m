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
            e = 1;
            for i = 1:n
                time = stimRef(i + 1, k);
                startSample = ceil((time - windowBefore) * samplingFreq);
                endSample   = ceil((time + windowAfter ) * samplingFreq);
                if (endSample < dataSize)
                    frameTemp = dataArray(startSample:endSample, electrode);
                    % remove DC offset
                    frameTemp = frameTemp - mean(frameTemp);
                    minTemp = min(frameTemp);
                    maxTemp = max(frameTemp);
                    if (maxThreshold < 0 || (maxThreshold >= abs(minTemp) && maxThreshold >= abs(maxTemp)))
                        frames(:, e, electrode, k) = frameTemp;
                        if (1 == drawIntermediate)
                            %plot(frames(:, e, electrode, k)); pause(0.1);
                            figure();
                            plot(frameTemp); pause(0.1);
                        end
                        e = e + 1;
                    else
                        stimRef(1, k) = stimRef(1, k) - 1;
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
            averageTemp = frames(:, 1:n, electrode, k);
            framesMean(:, electrode, k) = mean(averageTemp(:, :), 2);
            %framesMean(:, electrode, k) = filtfilt(filter, framesMean(:, electrode, k));
        end   
    end
end
clearvars averageTemp;
clearvars meanTemp;
clearvars maxTemp;
clearvars minTemp;