# You want latexmk to *always* run, because make does not have all the info.
.PHONY: ResearchDiary.pdf

# First rule should always be the default "all" rule, so both "make all" and
# "make" will invoke it.
all: ResearchDiary.pdf

# CUSTOME VARIABLES
DATE=`date +%Y%m%d`
TIME=`date +%H%M%S`
YEAR=`date +%Y`
MONTHNAME=`date +%B`
DAY=`date +%d`

NEWFILE= ./entries/$(DATE).tex
NEWFILETIME=./entries/$(DATE)$(TIME).tex
NEWFILE_WILDCARD=$(wildcard $(NEWFILE))

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

ResearchDiary.pdf: ResearchDiary.tex
	rm entries.tex; latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" -use-make ResearchDiary.tex

# Create entries.tex file containing \input{entries/20130604.tex} for every file in the ./entries directory
entries.tex: $(wildcard entries/*.tex)
	ls entries/*.tex | awk '{printf "\\inputfile{%s}\n", $$1}' > entries.tex

# Create a new entry file from new_entry_template and substitude in todays date. Also check if it already exists and don't overwrite it if it does.
new:
	if [ -a $(NEWFILE) ] ; \
	then \
		echo "$(NEWFILE) already exists. Do not overwrite unless you know what you are doing! To create a new file on the same day run $$> make newfiletime" ; \
	else \
		sed -e "s/YEAR/$(YEAR)/" -e "s/MONTH/$(MONTHNAME)/" -e "s/DAY/$(DAY)/" < new_entry_template.tex > $(NEWFILE) ; \
		subl $(NEWFILE) ; \
	fi;

# Force create a new file. Overwrite existing one
newforce:
	sed -e "s/YEAR/$(YEAR)/" -e "s/MONTH/$(MONTHNAME)/" -e "s/DAY/$(DAY)/" < new_entry_template.tex > $(NEWFILE) ; \

# Create another file on the same day. This one has a time stamp down to seconds in the filename
newfiletime:
	sed -e "s/YEAR/$(YEAR)/" -e "s/MONTH/$(MONTHNAME)/" -e "s/DAY/$(DAY)/" < new_entry_template.tex > $(NEWFILETIME)

# Clean all files
clean:
	latexmk -CA; \
	rm -f entries.tex entries/*.aux entries/*.fls entries/*.log entries/*.fdb*; \
