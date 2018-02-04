# Project for the course Brain-Computer Interface Practical
This project uses a fork of: https://github.com/jadref/buffer_bci

it uses code from https://github.com/taro10h/flicker_stimulator which uses Psychtoolbox for presenting stimuli.
This repository also contains code from https://github.com/bibliolytic/MTlearning. This code has only be used for experimenting but is not used in final experiments and presented results.

By Thirza Dado, Mart van Rijthoven & Emiel Stoelinga

## Topic
An Electroencephalogram (EEG)-based Brain Computer Interface (BCI) system is implemented to play the game ‘Brain Fly’ in which 1D cursor control moves a cannon by detection and classification of steady state visual evoked potentials (SSVEPs). It is hypothesized that data pooling could overcome session-to-session variability and therefore establish calibration elimination within one subject. Results of three frequency combinations demonstrate that after data pooling the combination 10 Hz versus 15 Hz leads to the highest classifier accuracy with 10-fold cross validation (89.2%). Moreover, when a classifier is trained on pooled data from multiple sessions and tested on an independent test set, this frequency combination also gave the highest accuracy (83.3%). It is therefore concluded that this frequency combination leads to stable SSVEPs throughout sessions which makes it useful for training a universal classifier.


# Run Project
To run our project start the following:
 - bci1718/dataAcq/startJavaBuffer.sh/bat &
 - bci1718/dataAcq/startMobita.sh/bat &
 - bci1718/dataAcq/startJavaEventViewer.sh/bat &
 - bci1718/matlab/brainfly/startSigProcBufferProject.sh/bat &
 - bci1718/matlab/brainfly/runProject.sh/bat &
