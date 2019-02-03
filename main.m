clear

close all

load('sample_eeg_struct.mat')

[input_name, eeg] = formatdata( eeg );
probabilities = classification(input_name);
showcomponents(eeg, probabilities)