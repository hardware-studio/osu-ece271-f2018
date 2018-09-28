PDFLATEXFLAGS = -halt-on-error

CHAPTER2_DIR = chapter2_combinational_logic_design
LAB1_DIR = lab1_basic_combinational_logic

ALL = \
		chapter2_report \
		lab1_report

all: $(ALL)

chapter2_report: $(CHAPTER2_DIR)/chapter2_report.tex
	pdflatex $(PDFLATEXFLAGS) $?

lab1_report: $(LAB1_DIR)/lab1_report.tex
	pdflatex $(PDFLATEXFLAGS) $?

.PHONY: clean

clean:
	find . -type f \( -name "*.pdf" -or -name "*.aux" -or -name "*.log" -or -name "*.out" \) -exec rm -f {} \;
