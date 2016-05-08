if exist('stimRawFile', 'var')
    % create column with stimulation offset where 0 = OV_STIM_LABEL0
    stimArray(:,SA_STIM) = stimArray(:, SA_OV_STIM) - OV_STIM_LABEL0;
    % create column with sample number based on time and sampling frequency
    stimArray(:,SA_SAMPLE_NO) = stimArray(:, SA_TIME) * samplingFreq;
     for k = 2:stimRawSize
         %if k == 78
         %    k = 78;
         %end
         %create column with time between previous event and current event
         temp = stimArray(k, SA_TIME) - stimArray(k - 1, SA_TIME);
         stimArray(k, SA_DURATION) = temp;
         %events with time greated than 2.1 s between previous and current
         %to be marked as ARROW APPEAR EVENT
         if stimArray(k, SA_DURATION) > thrArrowAppear
             stimArray(k, SA_STIM_APPEAR) = 1;
         end
         %arrow disappear event does not require filtration
         if stimArray(k, SA_STIM) == OV_STIM_DISAPPEAR;
             stimArray(k, SA_STIM_DISAPPEAR) = 1;
         end
         %in case of operator pressed arrow in correct direction
         if stimArray(k, SA_STIM) == OV_STIM_OK;
             %check if time between previous event is not greater than
             %defined threshold (0.45s) considered as keyboard malfunction
             if stimArray(k - 1, SA_DURATION) < thrKBMalfunc
                 %in such case mark stimulation as OK
                 stimArray(k, SA_STIM_OK) = 1;
             else
                 %cases when operator selected direction in time greater 
                 %than 0.45 sec considered as keyboard malfunction
                 stimArray(k, SA_STIM_KB_MALFUNC) = 1;
             end
         end
         %in case of operator pressed arrow in wrong direction
         if stimArray(k, SA_STIM) == OV_STIM_WRONG;
             %check if time between previous event is not greater than
             %defined threshold (0.45s) considered as keyboard malfunction
             if stimArray(k - 1, SA_DURATION) < thrKBMalfunc
                 %in such case mark stimulation as WRONG
                 stimArray(k, SA_STIM_WRONG) = 1;
             else
                 %cases when operator selected direction in more than 0.45
                 %sec considered as keyboard malfunction
                 stimArray(k, SA_STIM_KB_MALFUNC) = 1;
             end
         end
         %in case of operator pressed arrow in correct direction, but
         %application changed response simulating wrong direction
         if stimArray(k, SA_STIM) == OV_STIM_ENF_WRONG;
             %check if time between previous event is not greater than
             %defined threshold (0.45s) considered as keyboard malfunction
             if stimArray(k - 3, SA_DURATION) < thrKBMalfunc
                 stimArray(k, SA_STIM_ENF_WRONG) = 1;
                 %this stimulation alays comes as an answer to proper
                 %reaction, and proper reastion is also stored in
                 %stimulation data so needs to be removeds
                 stimArray(k - 2, SA_STIM_OK) = 0;
             else
                 %it has been already done for STIM_OK, so it's not necessary
                 %stimArray(k, SA_STIM_KB_MALFUNC) = 1;
             end
         end
   
     end
    temp2 = 0; % time or previous stimulation - used to filter double KB press
    %for each stimulation considered for processing
    for k = stimulationsToProcess
        %traverse previously created array, cound number of stimulations of
        %each type and create stimulation reference array
        %row number 1 of this array contains number of found stimulations
        %of specific type, next rows are time references within EEG data 
        for i = 1:stimRawSize
            %find rows of stimulation column which has been marked wtih '1'
            %value (&& condition, to avoid issues with initial data)
            if stimArray(i, k) == 1 && stimArray(i, SA_TIME) > thrStartTime
                %filter events when operator pressed keyboards repetitevely
                %(only first keyboard press matters)
                if stimArray(i, SA_TIME) - temp2 > thrArrowAppear
                    %increase number in first row
                    temp = stimRef(1, k) + 1;
                    stimRef(1, k) = temp;
                    %add time reference to the array
                    stimRef(temp + 1, k) = stimArray(i, SA_TIME);
                else
                    %temp = stimRef(1, SA_TEMP) + 1;
                    %stimRef(1, SA_TEMP) = temp;
                    %stimRef(temp + 1, SA_TEMP) = stimArray(i, SA_TIME);
                end
                %store previous time of event (except appear and disappear)
                %for filtering repetitive keyboard presses (for next
                %iteration)
                if k ~= SA_STIM_APPEAR && k ~= SA_STIM_DISAPPEAR
                    temp2 = stimArray(i, SA_TIME);
                end
            end
        end
    end
end