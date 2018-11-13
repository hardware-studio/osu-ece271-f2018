PDFTEX = pdflatex
BIBTEX = bibtex
PDFTEXFLAGS = -halt-on-error -shell-escape

PRELAB = lab3_prelab
REPORT = lab3_report

default: $(PRELAB) $(REPORT)

$(PRELAB): $(PRELAB).tex
	$(PDFTEX) $(PDFTEXFLAGS) $?
	$(PDFTEX) $(PDFTEXFLAGS) $?

$(REPORT): $(REPORT).tex
	$(PDFTEX) $(PDFTEXFLAGS) $?
	$(BIBTEX) $@
	$(PDFTEX) $(PDFTEXFLAGS) $?
	$(PDFTEX) $(PDFTEXFLAGS) $?

.PHONY: clean

clean:
	rm -f $(PRELAB).pdf $(REPORT).pdf *.acn *.acr *.alg *.aux *.bbl *.blg \
		*.fdb_latexmk *.fls *.glg *.glo *.gls *.idx *.ind *.ist *.lof *.log \
		*.lot *.out *.synctex.gz *.toc
