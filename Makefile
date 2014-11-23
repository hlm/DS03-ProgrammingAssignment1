all: analysis test doc

clean: clean-data clean-doc clean-result

clean-doc:
	rm -f README.md
	rm -f CodeBook.md

clean-result:
	rm -rf tidydata.txt

clean-data:
	rm -rf data
	rm -rf "UCI HAR Dataset"

README.md:
	Rscript -e "library(knitr); knit('README.Rmd')"

CodeBook.md:
	Rscript -e "library(knitr); knit('CodeBook.Rmd')"

doc: README.md CodeBook.md

download:
	Rscript get_data.R

analysis: download
	Rscript run_analysis.R

test:
	Rscript test_result.R

dependencies:
	Rscript -e "install.packages(c('reshape2', 'digest', 'knitr'), repos='http://cran.us.r-project.org')"
	