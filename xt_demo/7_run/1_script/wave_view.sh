#!/usr/bin/bash
WAVE_OPT="${WAVE_VIEW} \
	#{WAVE_CMD_REPLACE_TAG} \
    "
#------- option from command line ---------

WAVE_OPT="${WAVE_OPT} -l ${PROJ_WORK_PATH}/${TC_NAME}/${TC_NAME}_${TC_SEED}.${WAVE_VIEW}.log "
echo -e "wave review command is :\n ${WAVE_OPT}"
eval ${WAVE_OPT}

