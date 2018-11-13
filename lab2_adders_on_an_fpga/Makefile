PDFTEX = pdflatex
BIBTEX = bibtex
PDFTEXFLAGS = -halt-on-error -shell-escape

REPORT = lab2_report

default: $(REPORT)

$(REPORT): $(REPORT).tex
	$(PDFTEX) $(PDFTEXFLAGS) $?
	$(PDFTEX) $(PDFTEXFLAGS) $?

.PHONY: clean

clean:
	rm -f *_report.pdf *.acn *.acr *.alg *.aux *.bbl *.blg *.fdb_latexmk *.fls \
		*.glg *.glo *.gls *.idx *.ind *.ist *.lof *.log *.lot *.out \
		*.synctex.gz *.toc
