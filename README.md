# ocs-bio-containers-scaffold

This repository provides the beginning scaffold for the [ocs-bio-containers open case study](https://www.opencasestudies.org/ocs-bio-containers/) so that learners can use this template to create and clone repositories while interacting with the case study, or download the files from this repository as a directory that can be mounted as a volume when running an image to create a container.

## Directory structure

* `analysis_scripts` contains the analysis scripts for the Data Handling / Container Application steps of the case study. 

| Section of Case Study | Relevant Script(s) |
|:--------------------- | :-----------------:|
| Data Import           | `01_extract_data.R`|
| Data Wrangling        | `02_wrangle.R`     |
| Data Visualization    | `03a_visualization.R` <br> `03b_visualization_patchwork.R` |
| Data Analysis         | `04_analysis_metric.R <br> `run_analysis.sh` |

* `continued_learning_scripts` contains the scripts for the Continued Learning sections of the case study.
    * The `refinement` sub-directory contains an alternate visualization script as well as an alternative version of the script to run the whole analysis. These are meant for the Reinforcement Exercises section.
    * The `beginner` sub-directory contains another alternate visualization script as well as another alternative version of the script to run the whole analysis. These are meant for the Beginner Exercise within the Advancement Exercises section.

## Ways to use this Template repository

As [described within the case study](https://www.opencasestudies.org/ocs-bio-containers/#step-3a-downloading-version-controlled-analysis-files), this repository can be used to 

1. *Option A* Download the analysis scripts in a `.zip` file, extract them, and use the directory/scripts.
2. *Option B* Set up a new GitHub respoitory from this template, and clone your new repository locally.