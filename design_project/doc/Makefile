PDFTEX = pdflatex
BIBTEX = bibtex
PDFTEXFLAGS = -halt-on-error -shell-escape

REPORT = design_project_report

default: $(REPORT)

$(REPORT): $(REPORT).tex
	$(PDFTEX) $(PDFTEXFLAGS) $?
	$(PDFTEX) $(PDFTEXFLAGS) $?

.PHONY: clean

clean:
	rm -f $(REPORT).pdf *.acn *.acr *.alg *.aux *.bbl *.blg \
		*.fdb_latexmk *.fls *.glg *.glo *.gls *.idx *.ind *.ist *.lof *.log \
		*.lot *.out *.synctex.gz *.toc
