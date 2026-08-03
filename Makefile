TEX := resume.tex
PDF := resume.pdf
LOG := resume.log

.PHONY: build verify clean

build:
	latexmk -lualatex -file-line-error -halt-on-error -interaction=nonstopmode $(TEX)

verify: build
	bash scripts/verify-pdf.sh $(PDF) $(LOG)

clean:
	latexmk -C $(TEX)
	rm -f $(PDF)
