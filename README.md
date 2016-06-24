---
title: "Readme"
author: "Aude LE BRAS"
date: "24/06/2016"
output:
  html_document:
    keep_md: yes
---

##Getting and Cleaning Data Course Project Definition
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##The process
###Libraries
Install (if they're not exist) and load this libraries :
* stringr
* dplyr
* reshape
* plyr

###Download sources
If sources don't exist in work directory, dowload the zip file and unzip it.

To know your work directory, run this command "getwd()"
To change your work directory, run this command "setwd("your_path")"

###Load sources
Load the files with the command read.table() :
* activity_labels.txt
* features.txt
* subject_test.txt
* X_test.txt
* y_test.txt
* subject_train.txt
* X_train.txt
* y_train.txt

For each file, the file's name become the variable name.

###Assign columns's name
the column's name of the data frame X_test and X_train are on the data frame feature

###Merge files test and train
With the command cbind(), merge the files X_test, y_test and subject_test in a first variable.
In a second variable (same way), merge the train files.
Then with the command rbind(), merge these both variables in a third variable (data).

###Make valid column's names 
With the command make_name, verify if the column's names in data variable are correct. That going to delete all special character :
* ()
* ,
* - 
* ...

###Replace Activity level by activity name
With merge command, bring the label activity that is in data frame activity_labels.

###Extract columns Suject Activity, that contains mean1 (in original file it was mean()) and contains std1
With the command select(), extract the columns. 
With the command make_name, all special characters are transformed by ".".
To be sure, extract the columns that contains "mean()" and not just "mean" (contained in angle columns), I change "()" by "1". It's why, I search "mean1" and "std1".

At this point, the tidy_data is ready.

###Calculate average of all columns for each Subject/Activity
For the second file.

###Export the result frame in text file
If the files already exist, delete them then create the files 
tidy_data.txt and tidy_data_avg.txt in work directory.
