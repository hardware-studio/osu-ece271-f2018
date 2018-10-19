PDFTEX = pdflatex
PDFTEXFLAGS = -halt-on-error

CHAPTER2_DIR = chapter2_combinational_logic_design
CHAPTER3_DIR = chapter3_sequential_logic_design
CHAPTER4_DIR = chapter4_hardware_description_languages
LAB1_DIR = lab1_basic_combinational_logic
LAB2_DIR = lab2_adders_on_an_fpga
LAB3_DIR = lab3_combinational_logic
LAB4_DIR = lab4_system_verilog_and_complex_projects

ALL = \
		chapter2_report \
		chapter3_report \
		chapter4_report \
		lab1_report \
		lab2_report \
		lab3_prelab \
		lab3_report \
		lab4_prelab \
		lab4_report

all: $(ALL)

chapter2_report: $(CHAPTER2_DIR)/chapter2_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(CHAPTER2_DIR) $?

chapter3_report: $(CHAPTER3_DIR)/chapter3_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(CHAPTER3_DIR) $?

chapter4_report: $(CHAPTER4_DIR)/chapter4_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(CHAPTER4_DIR) $?

lab1_report: $(LAB1_DIR)/lab1_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB1_DIR) $?

lab2_report: $(LAB2_DIR)/lab2_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB2_DIR) $?

lab3_prelab: $(LAB3_DIR)/lab3_prelab.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB3_DIR) $?

lab3_report: $(LAB3_DIR)/lab3_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB3_DIR) $?

lab4_prelab: $(LAB4_DIR)/lab4_prelab.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB4_DIR) $?

lab4_report: $(LAB4_DIR)/lab4_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB4_DIR) $?

.PHONY: clean

clean:
	find . -type f \( -name "*_report.pdf" -or -name "*_prelab.pdf" \
		-or -name "*.aux" -or -name "*.bbl" -or -name "*.blg" \
		-or -name "*.log" -or -name "*.out" -or -name "*.fdb_latexmk" \
		-or -name "*.fls" -or -name "*.synctex.gz" \) -exec rm -f {} \;
