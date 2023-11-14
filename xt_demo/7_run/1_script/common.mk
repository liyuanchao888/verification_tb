
.PHONY : default help clean comp sim verdi cov gen_run run tc regr report

default: help

help:
	@bash help.sh 

get_dut:record
	@bash ${GET_FILELIST}

gen_run:record
	@bash ${GEN_RUN_FILE} ${CFG_ALL}

comp:record
	@bash ${RUN_COMPILE_FILE}

sim:record
	@bash ${RUN_SIM_FILE}

ifeq (${gcs},s)
run:sim
else ifeq (${gcs},cs)
run:comp sim
else 
run:gen_run comp sim
endif

wave:record
	@bash ${RUN_WAVE_FILE}

regr:gen_run
	@bash ${RUN_REGR_FILE} ${opt}

report:record
	@bash ${RUN_REPORT_FILE}

cov:record
	@bash coverage.sh ${opt} ${report}

clean:
	@bash clean.sh ${opt}

tc:
	@find ${TB_PATH}/6_top/2_tc -name "*.sv" -o -name "*.v"

ifneq (${MAKECMDGOALS},)#no null
ifeq ($(filter tc clean help,${MAKECMDGOALS}),)#no tc clean,help 
record:
	@echo "make ${MAKECMDGOALS} ${MAKEFLAGS}" >rerun
	chmod +x rerun
endif
endif
