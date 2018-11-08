PDFTEX = pdflatex
PDFTEXFLAGS = -halt-on-error -shell-escape

CHAPTER2_DIR = chapter2_combinational_logic_design
CHAPTER3_DIR = chapter3_sequential_logic_design
CHAPTER5_DIR = chapter5_digital_building_blocks
LAB1_DIR = lab1_basic_combinational_logic
LAB2_DIR = lab2_adders_on_an_fpga
LAB3_DIR = lab3_combinational_logic
LAB4_DIR = lab4_system_verilog_and_complex_projects
LAB5_DIR = lab5_serial_peripheral_interface
DESIGN_PROJECT_DIR = design_project/doc

ALL = \
		chapter2_report \
		chapter3_report \
		chapter5_report \
		lab1_report \
		lab2_report \
		lab3_prelab \
		lab3_report \
		lab4_prelab \
		lab4_report \
		lab5_prelab \
		lab5_report \
		design_project

all: $(ALL)

chapter2_report: $(CHAPTER2_DIR)/chapter2_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(CHAPTER2_DIR) $?

chapter3_report: $(CHAPTER3_DIR)/chapter3_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(CHAPTER3_DIR) $?

chapter5_report: $(CHAPTER5_DIR)/chapter5_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(CHAPTER5_DIR) $?

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

lab5_prelab: $(LAB5_DIR)/lab5_prelab.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB5_DIR) $?

lab5_report: $(LAB5_DIR)/lab5_report.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(LAB5_DIR) $?

design_project: $(DESIGN_PROJECT_DIR)/design_project.tex
	$(PDFTEX) $(PDFTEXFLAGS) -output-directory $(DESIGN_PROJECT_DIR) $?

.PHONY: clean

clean:
	find . -type f \( -name "*_report.pdf" -or -name "*_prelab.pdf" \
		-or -name "*.aux" -or -name "*.bbl" -or -name "*.blg" \
		-or -name "*.log" -or -name "*.out" -or -name "*.fdb_latexmk" \
		-or -name "*.fls" -or -name "*.synctex.gz" \) -exec rm -f {} \;
