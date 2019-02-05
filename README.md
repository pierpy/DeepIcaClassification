# DeepIcaClassification
Convolutional Neural Netowork for Independent Component Classificaiton

(EEGLAB required)
Tool for Independent Components Classification based on Convolutional Neural Networks (CNN). 

First you must format your data with the function [input_name, eeg] = formatdata( eeg )

- [ input_name, eeg ] = formatdata( eeg ) --> this function format and save the data as input for CNN classification:
                  input: eeg --> struct with following required fields: 
                                  1. eeg.ICA.IC: independent component timecourse extracted form ICA algorithm;
                                  2. eeg.ICA.A: mixing matrix resulting from ICA algorithm;
                                  3. eeg.locsname: you can use the function use "itab_writelocs()" to generate it; 
                                  4. eeg.srate: sampling frequency; 
                                  5. eeg.filename: name to the CNN input file;
                  output: input_name --> string indicating the filename for the classification() function; 
                          eeg        --> struct as input struct with new formatted variables
                                  
- [ probabilities ] = classification( input_name ) --> this function performs the CNN classification of the ICA components, takes as input  
                                                   the filename previously obtained by the function "[input_name, eeg] = formatdata( eeg )"
                  input: input_name --> string corresponding to the filename previously obtained by the function 
                                        "[input_name, eeg] = formatdata( eeg )";
                  output: probabilities -->
