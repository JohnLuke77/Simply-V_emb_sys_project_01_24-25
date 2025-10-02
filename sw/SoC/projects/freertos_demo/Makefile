# Author: Stefano Mercogliano <stefano.mercogliano@unina.it>
# Description:
#   This Makefile defines the project name and paths for the common Makefile.
#   Optionally, a user can define additional targets here.

################
# Program Name #
################

# Get program name from directory name
PROGRAM_NAME = $(shell basename $$PWD)


#####################
# Paths and Folders #
#####################

FREERTOS_PORT ?= RISC_V
SOC_SW_ROOT_DIR = $(SW_ROOT)/SoC


FREERTOS_SRC_DIR := src/freertos
FREERTOS_PORT_ROOT += \
  $(FREERTOS_SRC_DIR)/portable/GCC/$(FREERTOS_PORT)
FREERTOS_INC_DIR += \
  -I inc/freertos \
  -I inc/freertos/common \
  -I inc/freertos/Minimal \
  -I $(FREERTOS_PORT_ROOT)
DEMO_SRC_DIR        = src/demo
OBJ_DIR        = obj
INC_DIR += \
  -I inc/demo \
  $(FREERTOS_INC_DIR)
STARTUP_DIR = $(SOC_SW_ROOT_DIR)/common/freertos/$(FREERTOS_PORT)

FREERTOS_SRCS += \
  $(FREERTOS_SRC_DIR)/tasks.c \
  $(FREERTOS_SRC_DIR)/queue.c \
  $(FREERTOS_SRC_DIR)/list.c \
  $(FREERTOS_SRC_DIR)/timers.c \
  $(FREERTOS_PORT_ROOT)/port.c \
  $(FREERTOS_SRC_DIR)/portable/MemMang/heap_1.c  
SRCS += \
  $(DEMO_SRC_DIR)/main.c \
  $(FREERTOS_SRCS) 
ASMS = $(STARTUP_DIR)/startup.S\
	   $(FREERTOS_PORT_ROOT)/portASM.S


LD_SCRIPT     = ld/user.ld

#############
# Libraries #
#############

LIB_OBJ_LIST     =
LIB_INC_LIST     = 

#############
# Toolchain #
#############

RV_PREFIX     = riscv32-unknown-elf-
CC             = $(RV_PREFIX)gcc
LD             = $(RV_PREFIX)ld
OBJDUMP     = $(RV_PREFIX)objdump
OBJCOPY     = $(RV_PREFIX)objcopy

CPPFLAGS = \
	-I $(FREERTOS_PORT_ROOT)/chip_specific_extensions/RISCV_no_extensions
CFLAGS      = -march=rv32imd_zicsr_zifencei -O0 -c 
LDFLAGS     = $(LIB_OBJ_LIST) -nostdlib -T$(LD_SCRIPT) -lgcc -lc

include $(SW_ROOT)/SoC/common/freertos/$(FREERTOS_PORT)/Makefile

