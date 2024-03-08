# Makefile for creating a Python virtual environment and installing requirements

VENV_NAME = venv
PYTHON = python3
REQUIREMENTS = requirements.txt

.PHONY: all

all: venv install

venv:
	@echo "Creating virtual environment..."
	@$(PYTHON) -m venv $(VENV_NAME)

install:
	@echo "Installing requirements..."
	@$(VENV_NAME)/bin/pip install -r $(REQUIREMENTS)
