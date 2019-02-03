function [ outcome, tablechannels,locsname ] = itab_writelocs( gchs, fullfilepath )
%ITAB_WRITELOCS Summary of this function goes here
%   Detailed explanation goes here
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



