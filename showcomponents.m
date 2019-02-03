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