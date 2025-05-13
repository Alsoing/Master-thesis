# Target *.tex file without the extension
TARGET    ?= thesis
BUILD_DIR ?= build

TARGET_FILES = $(wildcard *.tex) \
               $(wildcard *.sty) \
               $(wildcard *.bib) \
			   $(wildcard chapters/*.tex) \
			   $(wildcard cover/*.pdf) \
			   $(wildcard figs/*.tex) \
			   $(wildcard figs/*.svg) \
			   $(wildcard figs/*.png) \
			   $(wildcard figs/*.jpg) \
			   $(wildcard figs/*.pdf)

$(TARGET).pdf: $(TARGET_FILES)
	@mkdir -p $(BUILD_DIR)
	@printf '\def\\builddir{$(BUILD_DIR)}' >builddir.def
	pdflatex -interaction nonstopmode -shell-escape -output-directory $(BUILD_DIR) $(TARGET).tex
	makeglossaries -d $(BUILD_DIR) $(TARGET)
	biber --output-directory=$(BUILD_DIR) $(TARGET)
	pdflatex -shell-escape -output-directory $(BUILD_DIR) $(TARGET).tex
	@mv $(BUILD_DIR)/$(TARGET).pdf .

.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)
	@rm -rf builddir.def
.PHONY: clean-all
clean-all: clean
	@rm -f $(TARGET).pdf
