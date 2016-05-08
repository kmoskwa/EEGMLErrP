if exist('dataSize', 'var')
    clf;
    %clearvars  preview;
    %preview = 1;
    lspLen = 1 + (windowBefore + windowAfter) * samplingFreq;
    time = linspace(-windowBefore, windowAfter, lspLen)';
    currentSubPlot = 1;
    for n = electrodesArray
        if 1 == singleImagePreview %exist('preview', 'var')
            subplot(electrodesNumber, 5, currentSubPlot);
            currentSubPlot = currentSubPlot + 1;
            set(gca,'fontsize',fontSize)
        else
            clf
        end
        %axis([0 (windowBefore + windowAfter) * samplingFreq -10 10]);
        hold;
        temp = line([0 samplingFreq * (windowBefore + windowAfter)], [0 0]);
        set(temp,'Color','k')
        temp = line([samplingFreq * windowBefore samplingFreq * windowBefore], [-20 20]);
        set(temp,'Color','k')
        temp = line([samplingFreq * (windowBefore + 1) samplingFreq * (windowBefore + 1)], [-10 10]);
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
            %time = linspace(0, 10, 300);
            %temp = temp / samplingFreq;
            %plot((0:length(temp)-1)/256, temp);
            plot(temp, c);
        end
        if 1 == drawDifferences 
            plot(tempE - tempC, 'k');
        end
        title(dataHead(n));
        if 0 == singleImagePreview %exist('preview', 'var')
            saveas(gcf, char(strcat('session', int2str(sessionNo), '_', dataHead(n), '.png')));
        end
    end
    if 1 == singleImagePreview %exist('preview', 'var')
        saveas(gcf, char(strcat('session', int2str(sessionNo), '_', '.pdf')));
    end
end