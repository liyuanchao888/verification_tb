#!/usr/bin/bash
WAVE_OPT="${WAVE_VIEW} \
	-full64 \
    -elab ${PROJ_WORK_PATH}/output/simv.daidir/kdb* \
	-nologo \
	-ssf ${PROJ_WORK_PATH}/${tc}/${tc}_${seed}.fsdb \
	-guiConf ${PROJ_WORK_PATH}/novas.conf \
	-rcFile ~/novas.rc \
    "
#------- option from command line ---------

WAVE_OPT="${WAVE_OPT} -l ${PROJ_WORK_PATH}/${tc}/${tc}_${seed}.${WAVE_VIEW}.log & "
echo -e "wave review command is :\n ${WAVE_OPT}"
eval ${WAVE_OPT}

