---
title: "README"
author: "Songju Kim"
date: '2020 6 1 '
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Course Project

To make a tidy set for this course project

First of all, I read activity.txt for labeling each activities of subject

Second, I read features for naming column train,test set

Third, by Column binding and Row biding, I can get a whole data set

Fourth, I labeld activity as a factor

Fifth, I extracted column names with mean() and std() using regular expression.

Finally, I can get tidy set using group by mean based on subject_id, activity_nm

You can run scripts under which files [activity.txt features.txt]  are located in working directory and
 sub directry "test","train" are so


