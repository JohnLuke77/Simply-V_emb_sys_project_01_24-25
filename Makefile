# Environment check
ifndef ROOT_DIR
$(error Setup script settings.sh has not been sourced, aborting)
endif

all: hw sw

config:
	${MAKE} -C ${CONFIG_ROOT}

hw: xilinx

# Limit the number of parallel Vivado instances
MAX_VIVADO_INSTANCES ?= 2 # 4 could be the value for 12-cores CPU(better try first 2 or 3,it shouldn't take much time)-for 16 cores the defualt value could be 6
xilinx: units config
	${MAKE} -C ${XILINX_ROOT} -j ${MAX_VIVADO_INSTANCES}

units:
	${MAKE} -C ${HW_UNITS_ROOT} -j ${MAX_VIVADO_INSTANCES}

sw: config
	${MAKE} -C ${SW_ROOT}

clean:
	${MAKE} -C ${XILINX_ROOT} clean clean_ips
	${MAKE} -C ${HW_UNITS_ROOT} clean
	${MAKE} -C ${SW_ROOT} clean

.PHONY: config hw sw xilinx units
