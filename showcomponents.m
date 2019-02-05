





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
function showcomponents(eeg, probabilities)
    for i=1:size(eeg.ICA.IC,1)

        figure
        subplot(2,1,1)
        plot(eeg.f,eeg.ICA.spectrum(i,:))
        title({['IC n. ',  num2str(i)],['Brain Probability:', num2str(100*probabilities(i,1)) '%'],['Artifact Probability:',num2str(100*probabilities(i,2)) '%']})
        subplot(2,1,2)
        topoplot(eeg.ICA.A(:,i), eeg.chanlocs)
    %     ima = squeeze(EEG.ICA.maps(ind(i), :, :));
    %     ima(ima==0)=NaN;
    %     imagesc(ima)
        axis equal
        axis off
        disp('press a button to display next image')
        pause 
        close 
    end