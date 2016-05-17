if ~exist('automation', 'var')
    clear;
    postFix           = '';
end
subjectInitials   = 'PG';
subjectInitials   = 'RZ';
sessionNo         = 3;
% 1 - to draw additional Error - Correct line (black)
drawDifferences   = 0; 
% 1 - to substract reference channel ('A') from all other channels
refSubstract      = 1;
% 0 - to disable limit, other number - set specific limit
limitStimNumber   = 10;
% initials of operator
windowBefore      = 1.0;  % s
windowAfter       = 1.0;  % s
%NeTime            = 0.2 ;  % s
NeTime            = 0.08 ;  % s
axisSize          = 20;   % uV
maxThreshold      = -1;
% 0 no filter
% 1 filter original data (bandpassiir, zero-phase)
% 2 filter original data (bandpassiir)
% 11 filter mean data (bandpassiir, zero-phase)
% 12 filter mean data (bandpassiir)
filterUse         = 1;
filterLo          = 1.0;
filterHi          = 10.0;
%electrodes        = ['F3 ';'C3 ';'P3 ';'F7 ';'T3 ';'T5 ';'Fz ';'F4 ';'C4 ';'P4 ';'Cz ';'Pz '];
electrodes        = 'all';
electrodes        = ['Fp1';'F3 ';'C3 ';'P3 ';'O1 ';'F7 ';'T3 ';'T5 ';'Fz ';'Fp2';'F4 ';'C4 ';'P4 ';'O2 ';'F8 ';'T4 ';'T6 ';'Cz ';'Pz '];
electrodes        = ['Cz ';'F3 ';'F4 '];
electrodes        = ['T4 '];
electrodes        = ['C4 '];
electrodes        = ['F4 '];
electrodes        = ['Cz '];
electrodes        = ['Fz '];
electrodes        = ['Fz ';'Cz ';'C3 ';'C4 ';'Pz '];
electrodes        = ['Cz '];
% for one EPS image with subplots - set to 1; for separate image for each electrode - set to 0
singleImagePreview= 0; 
drawIntermediate  = 0;
drawBlackAndWhite = 0;
s_init();
%stimulationsToProcess = [SA_STIM_WRONG SA_STIM_ENF_WRONG];
%stimulationsToProcess = [SA_STIM_APPEAR SA_STIM_DISAPPEAR SA_STIM_OK SA_STIM_WRONG SA_STIM_ENF_WRONG SA_STIM_KB_MALFUNC];
stimulationsToProcess = [SA_STIM_OK SA_STIM_WRONG SA_STIM_ENF_WRONG SA_STIM_KB_MALFUNC];
stimulationsToProcess = SA_STIM_ENF_WRONG;
stimulationsToProcess = [SA_STIM_OK SA_STIM_WRONG];
stimulationsToProcess = SA_STIM_OK;
stimulationsToProcess = SA_STIM_WRONG;
stimulationsToProcess = [SA_STIM_OK SA_STIM_WRONG SA_STIM_ENF_WRONG];
stimulationsToProcess = [SA_STIM_ENF_WRONG SA_STIM_WRONG];
stimulationsToProcess = [SA_STIM_ENF_WRONG SA_STIM_OK];
s_load();
s_postInit();
s_processStim();
s_filterData();
s_processData();
s_postFilterData();
s_drawData();
