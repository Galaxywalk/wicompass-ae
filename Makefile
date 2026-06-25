LATEXMK ?= latexmk
PDFLATEX ?= pdflatex

all: ae.pdf

ae.pdf: ae.tex
	$(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error ae.tex

pdflatex:
	$(PDFLATEX) -interaction=nonstopmode -halt-on-error ae.tex

clean:
	$(LATEXMK) -C ae.tex || true
	rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.synctex.gz
