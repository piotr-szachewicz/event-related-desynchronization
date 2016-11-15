EVENT-RELATED DESYNCHRONIZATION
===============================

This repository contains an algorithm that is able to classify the four class motor imagery EEG data
from the BCI Competition IV, data set 2a (http://www.bbci.de/competition/iv/#dataset2a).

The algorithm reaches 0.46 kappa on the test set, so it would be able to reach the third place
in the competition (http://www.bbci.de/competition/iv/results/index.html#dataset2a).

It was developed as a part of my master's thesis:

    Piotr Szachewicz, "CLASSIFICATION OF MOTOR IMAGERY FOR BRAIN-COMPUTER INTERFACES",
    Poznan University of Technology, Poznan, 2013

How to install and use this code:

0. INSTALL PREREQUISITES
------------------------

All the commands below were tested on Ubuntu Linux. If you're using some other Linux distribution or MacOS,
you might have to install the necessary programs in a different way.

    sudo apt-get install octave octave-signal liboctave-dev octave-tsa octave-struct octave-specfun octave-optim octave-miscellaneous

1. CLONE REPOSITORIES
---------------------

Clone this repository and a repository containing BioSig's code
(I forked this code in order to fix some errors in it).

    cd ~
    git clone https://github.com/piotr-szachewicz/event-related-desynchronization.git
    git clone https://github.com/piotr-szachewicz/biosig.git

2. CONFIGURE
------------

In the event-related-desynchronization directory there is a settings_example.m file which contains paths
used by the code. If you download the code to your home directory (~) using the git clone commands written
above, you only need to copy the settings_example.m file to settings.m:

    cd event-related-desynchronization/code
    cp settings_example.m settings.m

2. DOWNLOAD THE EEG DATA
------------------------

Download the BCI Competition data from http://www.bbci.de/competition/iv/#datasets
and put the *.gdf files inside of the ~/event-related-desynchronization/data/2a directory.

Download the true labels for the 2a data set from http://www.bbci.de/competition/iv/results/index.html#labels.
Unpack it and put the *.mat files inside of the ~/event-related-desynchronization/data/2a/true_labels/ directory.

3. RUN EXPERIMENTS
------------------

You are ready to run your first experiment.

    cd ~/event-related-desynchronization/code/experiments
    octave lda_bp_experiment.m

This code runs the final evaluation experiment using an band power features (BP) and an LDA classifier.
The mean test kappa obtained should be around 0.46. This is the best algorithm I obtained in my
master's thesis.

Other files contain: 
 - lda_tdp_experiment - LDA classifier + TDP features
 - svm_bp_experiment - SVM classifier + BP features
 - svm_tdp_experiment - SVM classifier + TDP features
 

A. APPENDIX -- HOW TO RUN SVM CLASSIFICATION
--------------------------------------------

In order to run the experiments that use the SVM classifier you need to install some more things:

    sudo apt-get install swig

Download and unpack http://shogun-toolbox.org/archives/shogun/releases/2.1/sources/shogun-2.1.0.tar.bz2,
then go to the src/ directory and run the following commands:

    ./configure --interfaces=octave_modular
    make
    sudo make install
