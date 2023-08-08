#!/bin/csh -f

cd /tools/proj/verification_platform/ut_noc/7_run/1_script

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/tools/synopsys/vcs-R-2020.12-SP1/linux64/bin/vcselab $* \
    -o \
    /tools/proj/verification_platform/ut_noc/7_run/2_work/output/simv \
    -nobanner \
    +vcs+lic+wait \

cd -

