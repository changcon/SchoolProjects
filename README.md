---
title: "README"
author: "Connie Chang"
date: "July 6, 2018"
output: html_document
---

==================================================================================

Getting and Cleaning Data Final Project 

Using Data from the Human Activity Recognition Using Smartphones Dataset

by Connie Chang

==================================================================================

Data obtained from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

==================================================================================

Script run_analysis.R takes a training data frame ("train_set.txt", 2947 x 561) and 
test dataset ("test_set.txt", 7352 x 561) and adds the variable names ("features.txt") 
to their columns.

Append two additional columns ("subject_test.txt", "test_labels.txt") to each set to
specify the Volunteer ID and Activity ID.

Append the test_set and train_set together and name the combined dataset TrainTestData.

Pick out the columns that include "mean()" or "std" in the colnames.

Add activity labels using the information in "activity_labels.txt" using recode from 
the dplyr package.

Create a second dataset with the average of each variable by unique activity/subject
combination using group_by and summarize_if. Name this dataset TrainTestMeans.

Save final tidy dataset 
(180 x 68 = (30 volunteers * 6 activities) x (66 mean/std variables + 2 ID variables))
into a .csv file named "TrainTestMeans.txt" 

