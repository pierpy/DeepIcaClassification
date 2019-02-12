# DeepIcaClassification
Convolutional Neural Network (CNN) for Multichannel EEG/MEG Independent Component Classification

(EEGLAB required)
The CNN classification is performed through a pre-trained CNN (Croce et al., 2018) encapsulated in the file cnn.exe
-Clone or download the repository, cd to the downloaded folder. 
In matlab:
-Format data for classification with the function: 

[ input_name, eeg ] = formatdata( eeg ) --> this function format and save the data as input for "classification()" function.
                  
                  input: eeg --> struct with the following fields: 
            	      1. eeg.ICA.IC: independent component timecourse extracted form ICA algorithm (Number of ICs x Samples);
                                  2. eeg.ICA.A: mixing matrix extracted from the ICA algorithm ((Number of ICs x(Number of ICs );
                                  3. eeg.locsname: you can use the function use "itab_writelocs()" to generate it; 
                                  4. eeg.srate: eeg/meg sampling frequency; 
                                  5. eeg.filename: name of the saved m file;
                  
                  output: input_name --> string indicating the filename for the classification() function; 
                          eeg        --> struct with newly formatted variables.
                          
- Perform ICs classification through the matlab function:

- [ probabilities] = classification( input_name ) --> this function performs the CNN classification of the ICs,                                                          takes as input the filename previously obtained by  the function "[input_name, eeg] =formatdata( eeg )".
                                                       
                  input: input_name --> string corresponding to the filename previously obtained by the function 
                                        "[input_name, eeg] = formatdata( eeg )";
                  output: probabilities --> matrix [number of components x 2] with the probabilities for each IC of being BRAIN ( firs column ) or ARTIFACT ( second column )
                  
                  
See the file main.m with a complete example of the toolbox usage. 

If used for publications, please cite:

Croce, P.; Zappasodi, F.; Marzetti, L.; Merla, A.; Pizzela, V. & Chiarelli, A. M.
Deep Convolutional Neural Networks for feature-less automatic classification of Independent Components in multi-channel electrophysiological brain recordings 
IEEE Transactions on Biomedical Engineering, Institute of Electrical and Electronics Engineers (IEEE), 2018 , 1-1

DOI: 10.1109/tbme.2018.2889512

