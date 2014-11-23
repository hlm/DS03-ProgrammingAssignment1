# Coursera Data Science Specialization
## Getting and Cleaning Data
This repository holds a project that tries to fulfill the assinged objectives on the 
Coursera Data Science Specialization - Getting and Cleaning Data course from the John Hopinks University
The repo contains R scripts capable of downloading the required data files, performing the desired analysis
and testing the results against a predefined value.
The final objective of the assignment is to:
> Create a tidy data set with the average of each variable for each activity and each subject.

Here is a description of the main files in this repository from which you can reproduce all others.

|   |File              |Description                                                                     |
|:--|:-----------------|:-------------------------------------------------------------------------------|
|1  |assignment1.Rproj |RStudio project file                                                            |
|2  |CodeBook.Rmd      |The source that generates the CodeBook.md file                                  |
|3  |get_data.R        |R script that downloads the necessary data files                                |
|4  |Makefile          |Defines the several tasks that can be executed to reproduce the analysis        |
|5  |README.Rmd        |The source that generates this README.md file                                   |
|6  |run_analysis.R    |The actual analysis script                                                      |
|7  |test_result.R     |A script that tests the output file from the analysis against an expected value |
|8  |variables.txt     |A file listing all the variables present in the resulting analysis output       |

## Reproducing the analysis
I have made an attempt to make it very easy to reproduce the analysis of this repo. If you have `make` at 
your choice of Operating system you should be able to run the make tasks to get everything done for you with
very little effort.

The `Makefile` in this repo has tasks to download the data files from the internet, perform the analysis and
test it against a predefine result and a few others. It also contains tasks to update the documentation, including the one you
are reading and the `CodeBook.md` file, which contains the definitions of the many variables that are part of this
analysis. 

```{shell eval=FALSE}
$ make depedencies # install the dependant packages: reshape2, knitr and digest
$ make all # executes each script in turn, `get_data.R`, `run_analysis.R`
```

After `make` is done you should be able to see the results as a text file in the working directory with a filename
of `tidydata.txt`

Please, note that the repository does not contain the raw data, but it does contain a script that downloads that for you. Also
worth noting is that some files are generated dynamically, this includes the README.md you are reading and CodeBook.md.

You can also run tasks individually, such as `make download` or `make analysis`, which are pretty self explanatory.

Note that the downloaded zip file will be stored in a data subdirectory in the current project directory. The directory will
be created if it does not exist. The expanded data files are going to be unzip in the current working directory, this behaviour
can be changing by defining the `extractDir` variable in the `get_data.R` and `run_analysis.R` files.

## Running it manually
In case you do not want or can't use make, here is how you can run everything manually

1. Open an R shell or RStudio
2. Make sure your current working directory is this repo
3. Source the `get_data.R` file to download and unzip the required data files
  + `source("get_data.R")`
4. Source the `run_analysis.R` file to run the analysis. The result file named `tidydata.txt` should be created in the working directory
  + `source("run_analysis")`
5. Optionally compare the content of the generatede `tidydata.txt` with the expected content by sourcing `test_result.R`
  + `source("test_result.R")`
