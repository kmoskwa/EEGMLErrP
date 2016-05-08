samplingFreq      = 256;  % Hz
thrKBMalfunc      = 0.45; % s
thrArrowAppear    = 2.1;  % s
thrStartTime      = 5.0;  % s
fontSize          = 8; 
refElectrode       = 'A2';
eval(sprintf('stimRawFile = ''%s_StimRawAllSessions'';', subjectInitials));
eval(sprintf('dataRawFile = ''%s_DataRawAllSessions'';', subjectInitials));

%Open Vibe stimulations4
%defines general offset of the stimulations from OpenVibe (Label0)
OV_STIM_LABEL0      = 33024;
%stimulation - when arrow disappears from the screen
OV_STIM_DISAPPEAR   = 2;
%stimulation - when operator selected proper direction
OV_STIM_OK          = 3;
%stimulation - when operator selected improper direction
OV_STIM_WRONG       = 4;
%stimulation - when opeartor selected proper direaction, and application
%changed it
OV_STIM_ENF_WRONG   = 5;

%stimulation arrra (stimArray) columns definition
SA_TIME             = 1;
SA_OV_STIM          = 2;
SA_DURATION         = 3;
SA_SAMPLE_NO        = 4;
SA_STIM             = 5;
SA_STIM_APPEAR      = 6;
SA_STIM_DISAPPEAR   = 7;
SA_STIM_OK          = 8;
SA_STIM_WRONG       = 9;
SA_STIM_ENF_WRONG   = 10;
%stimulation column - case when keyboard malfunciton was discovered
SA_STIM_KB_MALFUNC  = 11;
SA_TEMP             = 12;
SA_SIZEOF           = SA_TEMP;
SA_STIM_FIRST       = SA_STIM_APPEAR;
SA_STIM_LAST        = SA_STIM_KB_MALFUNC;