function probabilities = classification(file_name)

   script_string = ['cnn.exe ' file_name];
   
   upd = textprogressbar(1, 'barlength', 20, ...
                         'updatestep', 20, ...
                         'startmsg', 'Performing CNN Inference: Brain vs. Artifact (few seconds) ...',...
                         'endmsg', ' Done.', ...
                         'showbar', false, ...
                         'showremtime', false, ...
                         'showactualnum', false, ...
                         'barsymbol', '+', ...
                         'showpercentage', false,...
                         'emptybarsymbol', '-');
    for i = 1:1
         [status,result] = system(script_string);
         upd(i)
    end
      
    if status == 0
        cell_status = strsplit(result);
        temp = str2double(cell_status);
        temp(isnan(temp))=[];
        probabilities = [];
        probabilities(:, 1) = temp(1:2:end);
        probabilities(:, 2) = temp(2:2:end);
    else
        error('error with CNN executable')
    end
    
    