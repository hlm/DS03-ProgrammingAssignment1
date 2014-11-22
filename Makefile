all: dependencies

clean:
	rm -rf data
	rm -f README.md
	rm -rf "UCI HAR Dataset"
	rm -rf tidydata.txt

README.md:
	Rscript -e "library(knitr); knit('README.Rmd')"

download:
	Rscript get_data.R

analysis: download
	Rscript run_analysis.R

test: 
	Rscript test_result.R

dependencies:
	Rscript -e "install.packages(c('reshape2', 'digest'), repos='http://cran.us.r-project.org')"
	