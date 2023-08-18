global env
fsdbDumpfile "env(wave_name)"
fsdbDumpvars 0 "test_top.DUT"
#fsdbDumpvars 1 "test_top.DUT"
fsdbDumpMDA
fsdbDumpon
#run 10ns
#fsdbDumpoff
#run 75ns
#fsdbDumpon
