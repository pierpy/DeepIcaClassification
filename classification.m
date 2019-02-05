% Authors:
% Pierpaolo Croce, pierpaolo.croce@unich.it
% Università Degli Studi G.D'Annunzio, Institute for Advanced Biomedical Technologies (ITAB).
%
% Antonio Maria Chiarelli, antonio.chiarelli@unich.it
% Università Degli Studi G.D'Annunzio, Institute for Advanced Biomedical Technologies (ITAB). 
%
% February 2019.
%
% See also: eeglab

% Copyright (C) 2019  Pierpaolo Croce, pierpaolo.croce@unich.it
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


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
    
    