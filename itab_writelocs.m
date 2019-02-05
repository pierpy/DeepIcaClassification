function [ outcome, tablechannels,locsname ] = itab_writelocs( gchs, fullfilepath )
%ITAB_WRITELOCS Summary of this function goes here
%   Detailed explanation goes here
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
%     disp('Writing locations file...')
    load(which('tableChannelsLayout.mat'));
    vars = {'Number', 'X', 'Y', 'Z' , 'EGILabels'};
    newtable = locstable(gchs, vars);
    newnumber = [1: length(newtable{:, 'Number'})]';
    newtable.Number = newnumber;    
    [folderpath, name, ~] = fileparts(fullfilepath);
    locsname = strcat(folderpath, strcat(name,'_locs.xyz'));
    writetable(newtable, locsname , 'Delimiter', ' ', 'WriteVariableNames', 0, 'FileType' , 'text');
    tablechannels = size(newtable, 1);
    if exist(locsname, 'file') == 2
        outcome = 1;
    else
        outcome = 0;
    end
  
end



