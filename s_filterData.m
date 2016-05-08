if exist('dataSize', 'var')
    if (1 == filterUse)
        %d = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',1/4,3/8,5/8,6/8,60,1,60);
        %Hd = design(d,'equiripple');
        d = fdesign.bandpass('N,F3dB1,F3dB2',10, filterLo, filterHi, samplingFreq);
        Hd = design(d,'butter');

        for electrode = electrodesArray
            dataToFilter = dataArray(:, electrode);
            dataFromFilter = filter(Hd, dataToFilter);
            dataArray(:, electrode)= dataFromFilter;
            clearvars dataToFilter;
            clearvars dataFromFilter;
        end
    end
end
