
.PHONY : default help clean comp sim verdi cov gen_run run tc regr report

default: help

help:
	@bash help.sh 

get_dut:
	@bash ${GET_FILELIST}

gen_run:
	@bash ${GEN_RUN_FILE} ${CFG_ALL}

comp:
	@bash ${RUN_COMPILE_FILE}

sim:
	@bash ${RUN_SIM_FILE}

ifeq (${gcs},s)
run:sim
else ifeq (${gcs},cs)
run:comp sim
else 
run:gen_run comp sim
endif

wave:
	@bash ${RUN_WAVE_FILE}

regr:gen_run
	@bash ${RUN_REGR_FILE} ${opt}

report:
	@bash ${RUN_REPORT_FILE}

cov:
	@bash coverage.sh ${opt} ${report}

clean:
	@bash clean.sh ${opt}

tc:
	@find ${TB_PATH}/6_top/2_tc -name "*.sv" -o -name "*.v"

