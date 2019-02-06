# DeepIcaClassification
Convolutional Neural Netowork (CNN) for Independent Component Classificaiton

(EEGLAB required)

First you must format your data with the function: 

- [ input_name, eeg ] = formatdata( eeg ) --> this function format and save the data as input for "classification()" function.
                  
                  input: eeg --> struct with following required fields: 
                                  1. eeg.ICA.IC: independent component timecourse extracted form ICA algorithm;
                                  2. eeg.ICA.A: mixing matrix resulting from ICA algorithm;
                                  3. eeg.locsname: you can use the function use "itab_writelocs()" to generate it; 
                                  4. eeg.srate: sampling frequency; 
                                  5. eeg.filename: name to the CNN input file;
                  
                  output: input_name --> string indicating the filename for the classification() function; 
                          eeg        --> struct as input struct with new formatted variables.
                          
then you can perform the classification of the ICA components with the following function

- [ probabilities ] = classification( input_name ) --> this function performs the CNN classification of the ICA components,                                                          takes as input the filename previously obtained by 
                                                       the function "[input_name, eeg] =formatdata( eeg )".
                  input: input_name --> string corresponding to the filename previously obtained by the function 
                                        "[input_name, eeg] = formatdata( eeg )";
                  output: probabilities --> matrix [number of components x 2] with the probabilities for each IC of being                                             BRAIN ( firs column ) or ARTIFACT ( second column )
                  
See the file main.m to a complete use of the toolbox. The classification is perfomed through a pre-trained CNN (Croce et al., 2018) encapsulated in the file cnn.exe

If the present tool turn out to be usefull please cite as:

Croce, P.; Zappasodi, F.; Marzetti, L.; Merla, A.; Pizzela, V. & Chiarelli, A. M.
Deep Convolutional Neural Networks for feature-less automatic classification of Independent Components in multi-channel electrophysiological brain recordings 
IEEE Transactions on Biomedical Engineering, Institute of Electrical and Electronics Engineers (IEEE), 2018 , 1-1

DOI: 10.1109/tbme.2018.2889512
