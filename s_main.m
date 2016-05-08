clear;
% load processed file from OpenVibe or comment to load RAW file
%dataOVPFile       = 'RZ_DataOVPAllSessions_2-49Hz.mat';
filterUse          = 1;
filterLo           = 1.0;
filterHi           = 10;
% initials of operator
subjectInitials   = 'RZ';
sessionNo         = 2;
windowBefore      = 1.0;  % s
windowAfter       = 1.0;  % s
singleImagePreview= 0; % for one EPS image with subplots - set to 1; for separate image for each electrode - set to 0
%electrodes        = 'all';
%electrodes        = ['F3 ';'C3 ';'P3 ';'F7 ';'T3 ';'T5 ';'Fz ';'F4 ';'C4 ';'P4 ';'Cz ';'Pz '];
electrodes        = ['Fp1';'F3 ';'C3 ';'P3 ';'O1 ';'F7 ';'T3 ';'T5 ';'Fz ';'Fp2';'F4 ';'C4 ';'P4 ';'O2 ';'F8 ';'T4 ';'T6 ';'Cz ';'Pz '];
electrodes        = ['Fz ';'Cz ';'C3 ';'C4 ';'Pz '];
electrodes        = ['Cz '];
s_init();
%stimulationsToProcess = [SA_STIM_WRONG SA_STIM_ENF_WRONG];
stimulationsToProcess = [SA_STIM_OK SA_STIM_WRONG SA_STIM_ENF_WRONG SA_STIM_KB_MALFUNC];
stimulationsToProcess = SA_STIM_WRONG;
stimulationsToProcess = SA_STIM_OK;
stimulationsToProcess = [SA_STIM_OK SA_STIM_WRONG];
stimulationsToProcess = SA_STIM_ENF_WRONG;
stimulationsToProcess = [SA_STIM_ENF_WRONG SA_STIM_WRONG];
stimulationsToProcess = [SA_STIM_OK SA_STIM_WRONG SA_STIM_ENF_WRONG];
drawDifferences   = 0; % to draw additional Error - Correct line (black) - set to 1
%stimulationsToProcess = [SA_STIM_APPEAR SA_STIM_DISAPPEAR SA_STIM_OK SA_STIM_WRONG SA_STIM_ENF_WRONG SA_STIM_KB_MALFUNC];
s_load();
s_postInit();
s_processStim();
s_filterData();
s_processData();
s_drawData();
