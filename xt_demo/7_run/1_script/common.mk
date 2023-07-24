
.PHONY : default help clean comp sim verdi cov gen_run run tc regr

default: help

help:
	@bash help.sh 

get_filelist:
	@bash ${GET_FILELIST}

gen_run:
	@bash ${GEN_RUN_FILE} ${CFG_ALL}

comp:
	@bash ${RUN_COMPILE_FILE}

sim:
	@bash ${RUN_SIM_FILE}

run:gen_run comp sim

wave:
	@bash ${RUN_WAVE_FILE}

regr:gen_run
	@bash ${RUN_REGR_FILE}

report:
	@bash ${RUN_REPORT_FILE}

tc:
	@find ${TB_PATH}/6_top/2_tc -name "*.sv" -o -name "*.v" > ${TC_TEST_LIST}
	@cat ${TC_TEST_LIST}

cov:
	urg -full64 -parallel -maxjobs 10 -dir ${PROJ_WORK_PATH}/cov/*.simv.vdb -report ${PROJ_WORK_PATH}/cov/urgReport -dbname ${PROJ_WORK_PATH}/cov/merge_cov/merge 

report_cov:
	firefox ${PROJ_WORK_PATH}/cov/urgReport/dashborad.html &

report_cov_dve:
	dve -full64 -dir ${PROJ_WORK_PATH}/cov*simv.vdb -logdir ${PROJ_WORK_PATH}/cov &

clean:
	@bash clean.sh ${opt}

