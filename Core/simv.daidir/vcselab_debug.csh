#!/bin/csh -f

cd /home/nguyea9/ee478/Core

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/home/lab.apps/vlsiapps_new/vcs/current/linux64/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

