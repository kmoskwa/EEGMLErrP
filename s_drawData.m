if exist('dataSize', 'var')
    clf;
    xlabel('Time (sec)');
    ylabel('Potential (uV)');    
    %clearvars  preview;
    %preview = 1;
    axisMult = 1000;
    axisLeft = -windowBefore * axisMult;
    axisRight = windowAfter * axisMult;
    lspLen = 1 + (windowBefore + windowAfter) * samplingFreq;
    %time = linspace(-axisLeft, axisRight, lspLen)';
    time = linspace(axisLeft, axisRight, (windowBefore + windowAfter) * samplingFreq + 1);
    currentSubPlot = 1;
    for n = electrodesArray
        if 1 == singleImagePreview %exist('preview', 'var')
            subplot(electrodesNumber, 5, currentSubPlot);
            currentSubPlot = currentSubPlot + 1;
            set(gca,'fontsize',fontSize)
        else
            clf
            xlabel('Time [ms]');
            ylabel('Amplitude [uV]');    
        end
        axis([axisLeft axisRight -axisSize axisSize]);
        hold;
        temp = line([axisLeft axisRight], [0 0]);
        set(temp,'Color','k')
        %temp = line([samplingFreq * windowBefore samplingFreq * windowBefore], [-20 20]);
        temp = line([0 0], [-axisSize axisSize]);
        set(temp,'Color','k')
        temp = line([NeTime * axisMult NeTime * axisMult], [-axisSize/2 -axisSize]);
        %temp = line([samplingFreq * (windowBefore + 1) samplingFreq * (windowBefore + 1)], [-10 10]);
        set(temp,'Color','k')
        for k = stimulationsToProcess
            temp = stimRef(1, k);
            if 0 == temp
                continue;
            end
            temp  = framesMean(:, n, k);
            switch k
                case SA_STIM_OK
                    c = 'b';
                    tempC = temp;
                case SA_STIM_WRONG
                    c = 'r';
                    tempE = temp;
                case SA_STIM_ENF_WRONG
                    c = 'm';
                case SA_STIM_KB_MALFUNC
                    c = 'g';
                case SA_STIM_APPEAR
                    c = 'c';
                case SA_STIM_DISAPPEAR
                    c = 'y';
                otherwise
                    c = 'b';
            end
            %plot(temp, c);
            plot(time, temp, c);
        end
        if 1 == drawDifferences 
            plot(time, tempE - tempC, 'k');
        end
        title(dataHead(n));
        if 0 == singleImagePreview %exist('preview', 'var')
            saveas(gcf, char(strcat(subjectInitials, 'session', int2str(sessionNo), '_', dataHead(n), postFix, '.png')));
        end
    end
    if 1 == singleImagePreview %exist('preview', 'var')
        saveas(gcf, char(strcat(subjectInitials, 'session', int2str(sessionNo), '_', postFix, '.pdf')));
    end
end