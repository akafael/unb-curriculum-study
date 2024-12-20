##
# Makefile for Python
#
# @author akafael
##

###############################################################################
# Variables
###############################################################################

PYTHON:= python3

# Get Makefile directory as project root
PROJECT_ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

MAIN_SRC:= ${PROJECT_ROOT_DIR}/sample/main.py
TEST_SRC:= ${PROJECT_ROOT_DIR}/test/test_main.py
SETUP_FILE_PATH:= ${PROJECT_ROOT_DIR}/setup.py

VIRTUALENV_DIR := .venv

###############################################################################
# Rules
###############################################################################

# Print help for Makefile commands
.PHONY: help
help:
	@echo "Use: make -f ${PROJECT_ROOT_DIR}/Makefile [OPTION]"
	@echo "\nOPTIONS"
	@sed Makefile -n -e "N;s/^# \(.*\)\n.PHONY:\(.*\)/ \2:\1/p;D" | column -ts:
	@echo ""

# Python Enviroment Preparation Rules ------------------------------------------

${VIRTUALENV_DIR}: 
	virtualenv ${VIRTUALENV_DIR}

# Create Virtualenv
.PHONY: virtualenv
virtualenv:	${VIRTUALENV_DIR} ${VIRTUALENV_DIR}/bin/activate

# Install Module
.PHONY: install 
install: ${SETUP_FILE_PATH} ${MAIN_SRC} virtualenv
	. "${VIRTUALENV_DIR}/bin/activate" && \
	${PYTHON} ${SETUP_FILE_PATH} install

# Python Rules -----------------------------------------------------------------

# Run Program
.PHONY: run
run: ${MAIN_SRC} virtuaenv
	. "${VIRTUALENV_DIR}/bin/activate" && \
	${PYTHON} $<

# Run unit tests
.PHONY: test
test: ${TEST_SRC} ${MAIN_SRC} install
	. "${VIRTUALENV_DIR}/bin/activate" && \
	${PYTHON} $<


