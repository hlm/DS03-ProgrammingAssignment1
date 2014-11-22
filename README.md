# Coursera Data Science Specialization
## Getting and Cleaning Data
This repository holds a project that tries to fulfill the assinged objectives on the 
Coursera Data Science Specialization - Getting and Cleaning Data course from the John Hopinks University
The repo contains R scripts capable of downloading the required data files, performing the desired analysis
and testing the results against a predefined value.
The final objective of the assignment is to:
> Create a tidy data set with the average of each variable for each activity and each subject.

Here is a description of the files in this repository

|   |files             |
|:--|:-----------------|
|1  |assignment1.Rproj |
|2  |CodeBook.Rmd      |
|3  |get_data.R        |
|4  |Makefile          |
|5  |README.Rmd        |
|6  |run_analysis.R    |
|7  |test_result.R     |
|8  |variables.txt     |

## Reproducing the analysis
I have made an attempt to make it very easy to reproduce the analysis of this repo. If you have `make` at 
your choice of Operating system you should be able to run the make tasks to get everything done for you with
very little effort.

The `Makefile` in this repo has tasks to download the data files from the internet, perform the analysis and
test it against a predefine result. It also contains tasks to update the documentation, including the one you
are reading and the `CodeBook.md` file, which contains the definitions of the many variables that are part of this
analysis. 

```{shell eval=FALSE}
$ make depedencies # install the dependant packages: reshape2, knitr and digest
$ make all # executes each script in turn, `get_data.R`, `run_analysis.R`
```

After `make` is done you should be able to see the results as a text file in the working directory with a filename
of `tidydata.txt`
