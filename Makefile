LATEX = pdflatex
PDFLATEXFLAGS = -halt-on-error

CHAPTER2_DIR = chapter2_combinational_logic_design
CHAPTER3_DIR= chapter3_sequential_logic_design
LAB1_DIR = lab1_basic_combinational_logic
LAB2_DIR = lab2_adders_on_an_fpga
LAB3_DIR = lab3_combinational_logic

ALL = \
		chapter2_report \
		chapter3_report \
		lab1_report \
		lab2_report \
		lab3_prelab \
		lab3_report

all: $(ALL)

chapter2_report: $(CHAPTER2_DIR)/chapter2_report.tex
	$(LATEX) $(PDFLATEXFLAGS) -output-directory $(CHAPTER2_DIR) $?

chapter3_report: $(CHAPTER3_DIR)/chapter3_report.tex
	$(LATEX) $(PDFLATEXFLAGS) -output-directory $(CHAPTER3_DIR) $?

lab1_report: $(LAB1_DIR)/lab1_report.tex
	$(LATEX) $(PDFLATEXFLAGS) -output-directory $(LAB1_DIR) $?

lab2_report: $(LAB2_DIR)/lab2_report.tex
	$(LATEX) $(PDFLATEXFLAGS) -output-directory $(LAB2_DIR) $?

lab3_prelab: $(LAB3_DIR)/lab3_prelab.tex
	$(LATEX) $(PDFLATEXFLAGS) -output-directory $(LAB3_DIR) $?

lab3_report: $(LAB3_DIR)/lab3_report.tex
	$(LATEX) $(PDFLATEXFLAGS) -output-directory $(LAB3_DIR) $?

.PHONY: clean

clean:
	find . -type f \( -name "*_report.pdf" -or -name "*_prelab.pdf" \
		-or -name "*.aux" -or -name "*.bbl" -or -name "*.blg" \
		-or -name "*.log" -or -name "*.out" -or -name "*.fdb_latexmk" \
		-or -name "*.fls" -or -name "*.synctex.gz" \) -exec rm -f {} \;
