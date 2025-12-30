# Makefile for jemdoc website generation

# Python interpreter
PYTHON = python3

# jemdoc script
JEMDOC = $(PYTHON) jemdoc.py

# Configuration file
CONFIG = mysite.conf

# Source files (all .jemdoc files)
SOURCES = index.jemdoc education.jemdoc publications.jemdoc teaching.jemdoc \
          services.jemdoc students.jemdoc awards.jemdoc

# Target files (corresponding .html files)
TARGETS = $(SOURCES:.jemdoc=.html)

# Default target: build all HTML files
.PHONY: all
all: $(TARGETS)

# Rule to build .html from .jemdoc
%.html: %.jemdoc $(CONFIG) MENU jemdoc.css
	@echo "Building $@ from $<"
	@$(JEMDOC) -c $(CONFIG) -o $@ $<

# Clean generated HTML files
.PHONY: clean
clean:
	@echo "Removing generated HTML files..."
	@rm -f $(TARGETS)
	@echo "Clean complete."

# Rebuild everything from scratch
.PHONY: rebuild
rebuild: clean all

# Show help
.PHONY: help
help:
	@echo "jemdoc Website Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  all      - Build all HTML files from .jemdoc sources (default)"
	@echo "  clean    - Remove all generated HTML files"
	@echo "  rebuild  - Clean and rebuild all files"
	@echo "  help     - Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  make           - Build all pages"
	@echo "  make clean     - Remove generated files"
	@echo "  make rebuild   - Clean and rebuild everything"

# Individual file targets (for quick rebuilds)
.PHONY: index
index: index.html

.PHONY: education
education: education.html

.PHONY: publications
publications: publications.html

.PHONY: teaching
teaching: teaching.html

.PHONY: services
services: services.html

.PHONY: students
students: students.html

.PHONY: awards
awards: awards.html
