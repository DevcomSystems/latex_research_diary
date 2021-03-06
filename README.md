latex_research_diary
====================

This is the template for a LaTeX based reasearch diary or digital log book.

## Usage ##
N.B.: The Makefile currently only works on *nix based systems.

To create a new entry for today use:
```bash
  $> make new
```
This this will create a new file in the entries directory with a yyyymmdd.tex filename. It will also open it immediately with sublime.

To compile all your entries use:
```bash
  $> make
```
This creates the ResearchDiary.pdf file with all your entries inside.

## Other options ##
Labels are created for each page in the form \label{01January2013}. Use the \pageref command to reference them:
```latex
  \pageref{01January2013}
```
To force create a new entry for the day, overwriting the current day (if it exists) use:
```bash
  $> make newforce
```
To create multiple entrys for a day use:
```bash
  $> make newfiletime
```
This creates a new entry file with the format yyyymmddHHMMSS.tex

And of course, to clean up the mess:
```bash
  $> make clean
```

## TODO ##
* Create title page
* Create table of contents page
* Create bibliography (bibtex)
* Fix referencing for newfiletime pages (the labels need to include timestamp)
