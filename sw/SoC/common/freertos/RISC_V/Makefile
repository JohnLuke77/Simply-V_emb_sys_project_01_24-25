# Author: Stefano Mercogliano <stefano.mercogliano@unina.it>
# Description:
#   The common Makefile includes the standard targets to build bare-metal code.
#	Each application will include this makefile and define the envvar related to path, dependencies and compilation flags.

SOC_SW_ROOT_DIR = $(SW_ROOT)/SoC
LIB_DIR	= $(SOC_SW_ROOT_DIR)/lib

########
# Misc #
########

OBJS = $(SRCS:%.c=$(OBJ_DIR)/%.o) $(ASMS:%.S=$(OBJ_DIR)/%.o)

RM	  = rm -rf					 # Remove recursively command
MKDIR   = @mkdir -p $(@D)			 # Creates folders if not present

##########
# MACROS #
##########

MACRO_LIST =
ifeq ($(SOC_CONFIG), embedded)
MACRO_LIST += -DIS_EMBEDDED
endif

###############################################################################

###########
# Targets #
###########

all: bin/$(PROGRAM_NAME).bin bin/$(PROGRAM_NAME).dump

$(OBJ_DIR)/%.o: %.c 
	@echo "\n[OBJ] Creating OBJs from src c files"
	$(MKDIR)
	$(CC) -o $@ $^ $(INC_DIR) $(LIB_INC_LIST) $(CPPFLAGS) $(CFLAGS) $(MACRO_LIST)

$(OBJ_DIR)/%.o: %.S 
	@echo "\n[OBJ] Creating OBJs from src assembly files"
	$(MKDIR)
	$(CC) -o $@ $^ $(INC_DIR) $(LIB_INC_LIST) $(CPPFLAGS) $(CFLAGS) $(MACRO_LIST)

bin/$(PROGRAM_NAME).elf: $(OBJS) 
	@echo "\n[ELF] Creating elf file"
	$(MKDIR)
	$(CC) -o $@ $^ $(LDFLAGS)

bin/$(PROGRAM_NAME).bin: bin/$(PROGRAM_NAME).elf
	@echo "\n[BIN] Creating bin file"
	$(OBJCOPY) -O binary bin/$(PROGRAM_NAME).elf bin/$(PROGRAM_NAME).bin
	
dump: bin/$(PROGRAM_NAME).dump
bin/$(PROGRAM_NAME).dump:
	$(OBJDUMP) -D bin/$(PROGRAM_NAME).elf > $@

clean:
	-$(RM) obj
	-$(RM) bin

.PHONY: all clean


