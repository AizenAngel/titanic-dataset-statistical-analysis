#install.packages("imputeTS")
library("imputeTS")

read_data <- function (filePath){
  data <- read.csv(filePath)
  
  return (data)
}

read_test_data <- function(dataPath, classPath){
  data <- read_data(dataPath)
  classes <- read_data(classPath)
  data$Survived <- classes$Survived
  
  return (data)
}

combine_test_train_data <- function (trainPath, testPath, classPath){
  train_data <- read_data(trainPath)
  test_data <- read_test_data(testPath, classPath)
  total_data <- rbind(train_data, test_data)
  
  return (total_data)
}

age_median_replace <- function(dataFrame){
  age_median <- median(dataFrame$Age, na.rm = T)
  dataFrame$Age <- na_replace(dataFrame$Age, age_median)
  
  return (dataFrame)
}

#####################################################################################

train_data <- read_data("train.csv")
test_data <- read_data("test.csv")
 
# R.summary() == Python.describe()
summary(train_data)

# odavde vidimo da godine imaju dosta Nan-ova u treningu, pa cemo to zameniti medijanom
sapply(train_data, function(x) sum(is.na(x)))

# odavde vidimo da godine imaju dosta nanova u test-u, pa cemo to zameniti medijanom godina
# Takodje i Fare ima 1 Nan. Posto je samo 1 u pitanju, odlucujemo se da ga izbacimo
sapply(test_data, function(x) sum(is.na(x)))

train_data <- age_median_replace(train_data)
test_data <- age_median_replace(test_data)
test_data <- na.omit(test_data)

sapply(train_data, function(x) sum(is.na(x)))
sapply(test_data, function(x) sum(is.na(x)))