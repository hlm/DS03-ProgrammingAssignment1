# Coursera Data Science Specialization
## Getting and Cleaning Data
> WARNING: If the file you are seeing has the .Rmd extension you should go to [README.md](https://github.com/hlm/DS03-ProgrammingAssignment1/blob/master/README.md)


> NOTE: This repo does not contain the raw data, it has a script that downloads and unzips the data into the current working directory

This repository holds a project that tries to fulfill the assinged objectives on the 
Coursera Data Science Specialization - Getting and Cleaning Data course from the John Hopinks University
The repo contains R scripts capable of downloading the required data files, performing the desired analysis
and testing the results against a predefined value.
The final objective of the assignment is to:
> Create a tidy data set with the average of each variable for each activity and each subject.

Here is a description table of the main files in this repository from which you can reproduce all others.

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
very little effort. RStudio is capable of running make tasks directly from the GUI under the Build 
tab (close to the Environment tab where all the variables are shown).

The `Makefile` in this repo has tasks to download the data files from the internet, perform the analysis and
test it against a predefined result. It also contains tasks to clean up your local clone of the repo, 
update the documentation, including the one you are reading and the [`CodeBook.md`](https://github.com/hlm/DS03-ProgrammingAssignment1/blob/master/CodeBook.md) file, which contains the definitions of the many variables that are part of this analysis. 

To run make on the command line, make sure you are in the correct directory and then you can invoke the command along 
side the task name you want to execute, like so:

```{shell eval=FALSE}
$ make depedencies # install the dependant packages: reshape2, knitr and digest
$ make all # executes each script in turn, `get_data.R`, `run_analysis.R`
```

If you are using `make` from RStudio, it is even easier: just click on the **Build All** button on the **Build** tab. Similarly,
you may clean your local repo, deleting the raw data, the result data and the generated documentation by, at the same tab in
RStudio, clicking on **More -> Clean All**. Its very common practice to **Clean and Rebuild**, so there is also
a choice for that in the RStudio.

After `make` is done you should be able to see the results as a text file in the working directory with a filename
of `tidydata.txt`

Please, note that the repository does not contain the raw data, but it does contain a script that downloads that for you. Also
worth noting is that some files are generated dynamically, this includes the `README.md` you are reading and `CodeBook.md`.

You can also run tasks individually, such as `make download` or `make analysis`, which are pretty self explanatory.

Note that the downloaded zip file will be stored in a data subdirectory in the current project directory. The directory will
be created if it does not exist. The expanded data files are going to be unzip in the current working directory, this behaviour
can be changed by defining the `extractDir` variable in the `get_data.R` and `run_analysis.R` files. The download is around 60MB
so depending on your internet connection speed, you may need to be patient with it.

## Running it manually
In case you do not want or can't use make, here is how you can run everything manually. Note that you will have to install
at least the `reshape2` package, you can do that whithin R with `install.packages("reshape2")`

1. Open an R shell or RStudio
2. Make sure your current working directory is this repo
3. Source the `get_data.R` file to download and unzip the required data files
  + `source("get_data.R")`
4. Source the `run_analysis.R` file to run the analysis. The result file named `tidydata.txt` should be created in the working directory
  + `source("run_analysis.R")`
5. Optionally compare the content of the generated `tidydata.txt` with the expected content by sourcing `test_result.R`
  + `source("test_result.R")`


```r
source("get_data.R")
source("run_analysis.R")
source("test_result.R")
```

```
## [1] "Test PASSED 8161c06dbe59f0131a5840917d275feb"
```
