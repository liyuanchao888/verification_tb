#!/usr/bin/bash

coverage_file=../2_work/coverage
help:
	@echo ""
	@echo "usage:"
	@echo "    make [opt]                                                                            "
	@echo ""
	@echo "[opt]:"
	@echo "    help       -- default,display some info about how to use the srcipt                     "
	@echo "    all        -- comp ,sim                                                                 "
	@echo "    comp       -- compile                                                                   "
	@echo "    sim        -- testcase simulation                                                       "
	@echo "    regr       -- run regression                                                            "
	@echo "    report     -- report all testcase html report                                           "
	@echo "    clean      -- clear all comp & sim file(../2_work/*)                                    "
	@echo "    cv_merge   -- merge file of coverage info                                               "
	@echo "    cv_view    -- review the ucdb file of coverage info on questasim                        "
	@echo "    cv_report  -- review coverage report                                                    "
	@echo "    cv_clean   -- clear coverage file(ucdb)                                                 "
	@echo ""
	@echo "example:"
	@echo "    if want to compile & simulation,please enter 'make all tc=../tc_path' in terminal     "
	@echo "    if want to compile the file,please enter 'make comp' in terminal                      "
	@echo "    if want to run testcase simulation,please enter 'make sim tc=../tc_path' in terminal  "
	@echo ""

all: comp sim

comp:
	./run.sh C
#	vsim -c -do "do ./1_compile.tcl;quit"
sim:
	@echo "tc is $(tc)"
	./run.sh $(tc) S
#   vsim -c -do "do ./2_sim.tcl $(tc)" -c -do "quit"
regr:
	sh run_regression.sh
report:
	./run_report.sh
clean:
	rm -rf ../2_work/* 
cv_merge:
	rm -rf $(coverage_file)/merge_all.ucdb $(coverage_file)/covhtmlreport
	vcover merge $(coverage_file)/*.ucdb -out $(coverage_file)/merge_all.ucdb -l  $(coverage_file)/vcover.log 
	vcover report -html $(coverage_file)/merge_all.ucdb  -summary -htmldir $(coverage_file)/covhtmlreport 
cv_view:
	vsim -coverage $(coverage_file)/merge_all.ucdb
cv_report:
	firefox $(coverage_file)/covhtmlreport/covsummary.html
cv_clean:
	rm -rf $(coverage_file)
