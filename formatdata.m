function [ input_name, eeg ] = formatdata( eeg )
% FORMATDATA Prepare data for automatic classification
% EEGLAB required
%   eeg: struct 
%   required fields: 
%                   1. eeg.ICA.IC: independent component extracted form ICA
%                   algorithm;
%                   2. eeg.ICA.A: mixing matrix
%                   3. eeg.locsname ( use itab_writelocs to generate it )
%                   4. eeg.srate: sampling frequency
%                   5. eeg.filename
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
    disp(['File Name: ', eeg.filename])
    if ~isfield(eeg, 'locsname')
        gchs = eeg.goodchannels;
        [  outcome, tablechannels, locsname  ] = itab_writelocs( gchs, eeg.filename );
        eeg.locsname = locsname;
        nch = length(gchs);  
        if outcome == 1 && nch == tablechannels
            eeg.chanlocs = readlocs(locsname);
        end
    end
    Fsnew = eeg.srate;
    [nIC, ~] = size(eeg.ICA.IC);

    win = 1048;
    upd = textprogressbar(nIC, 'startmsg', 'Spectrum Computation','barsymbol', '+', ...
                         'showpercentage', false,...
                         'emptybarsymbol', '-');
    for ix=1:nIC
        [pxx, F] = pwelch(eeg.ICA.IC(ix,:), win,[],[], Fsnew);
        mspettro(ix,:) = sqrt((Fsnew/win)*pxx)';
        upd(ix)
    end
    
    if size(mspettro,2)~=1025
        mspettro1=[];
        for i=1: nIC        
            mspettro1(i,:) = interp1(1:size(mspettro,2),mspettro(i,:),(1:1025)*size(mspettro,2)/1025);
        end
        mspettro=mspettro1;
    end
   
    upd = textprogressbar(nIC, 'startmsg', 'CNN Input Computation',  'barsymbol', '+', ...
                         'showpercentage', false,...
                         'emptybarsymbol', '-');
                     
    for i = 1 : nIC
        % estract IC spectrum and topography
        ss = mspettro(i,:);
        [~, imaVal, ~, xmesh, ymesh] = topoplot(eeg.ICA.A(:,i), eeg.chanlocs);
        close all
        
        % spectrum normalization
        fnew = F;
        spectrumnew = ss;
        spectrumnew = (spectrumnew/max(spectrumnew));
        spectrumnew(isnan(spectrumnew))=0;
        
        % topography resempling
        [X,Y] = meshgrid(-0.5:0.02:0.5, -0.5:0.02:0.5);
        imanew = interp2(xmesh, ymesh, imaVal, X, Y);
        imanew1 = (imanew - nanmean(imanew(:)))/nanstd(imanew(:));
        imanew1(isnan(imanew1))=0; 
        spectrum(i,:) = spectrumnew;
        maps(i,:,:) = imanew1;
        upd(i)
    end
     Total_set_topo = maps;
     eeg.ICA.maps = Total_set_topo;
     Total_set_spectrum = spectrum;
     eeg.ICA.spectrum=Total_set_spectrum;
     eeg.f = F;
     input_name = strcat(eeg.filename, '_input.mat' );
     upd = textprogressbar(1, 'startmsg', 'Saving Input File',  'barsymbol', '+', ...
                         'showpercentage', false,...
                         'emptybarsymbol', '-');
     for i=1:1
         save(input_name,'Total_set_topo','Total_set_spectrum')
         upd(1);
     end
end


