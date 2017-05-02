# Getting and Cleaning Data Course Project

## Introduction

This is my submission of the [Coursera Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) final project.

The purpose of this code is to take a set of a data collected by the [Center for Machine Learning and Intelligent Systems](http://cml.ics.uci.edu/) at the [University of California, Irvine](http://uci.edu/) and perform modelling techniques learned in this course to create a tidy data set result.

## Summary
### Environment
This solution was written with [Microsoft Visual Studio 2015](https://www.visualstudio.com/) using [R Tools for Visual Studio](http://microsoft.github.io/RTVS-docs/). You can also open this project in [RStudio](https://www.rstudio.com/) by using the `CourseProject.rproj` file in the project folder listed below.

### Repository Structure
This repository is stuctured similar to most other projects I have done, the breakdown is as follows.

    src
     |- CourseProject 
        |- CourseProject.rproj
        |- CourseProject.rxproj
        |- run_analysis.R
    |- CourseProject.sln

### Execution
The resulting output is created by sourcing the `run_analysis.R` file which performs all of the required steps to produce the output file called `analysis_result.csv` that is located in a `result` folder at the root of the repository.

__*NOTE:*__ If you make any changes to the script this folder will be ignored by default during the commit.