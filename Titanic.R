#install.packages("imputeTS")
library("imputeTS")

# mean(train_data$Age, na.rm = T)   = 29.69912
# median(train_data$Age, na.rm = T) = 28
# mean(test_data$Age, na.rm = T)    = 30.27259
# median(test_data$Age, na.rm = T)  = 27

read_data <- function (trainPath, testPath, testClassPath){
  train_data <- read_train_data(trainPath)
  test_data <- read_test_data(testPath, testClassPath)
  
  total_data <- rbind(train_data, test_data)
  
  return (total_data)
}

convert_to_numeric <- function(dataFrame){
  dataFrame$PassengerId = as.double(dataFrame$PassengerId)
  dataFrame$Survived = as.double(dataFrame$Survived)
  dataFrame$Pclass = as.double(dataFrame$Pclass)
  dataFrame$Age = as.double(dataFrame$Age)
  dataFrame$SibSp = as.double(dataFrame$SibSp)
  dataFrame$Fare = as.double(dataFrame$Fare)
  
  return (dataFrame)
}

read_train_data <- function(dataPath){
  train_data <- read.csv(dataPath, na.strings = "", colClasses = "character")
  
  return (convert_to_numeric(train_data))
}

read_test_data <- function(dataPath, classPath){
  data <- read.csv(dataPath, na.strings = "", colClasses = "character")
  classes <- read.csv(classPath, na.strings = "", colClasses = "character")
  data$Survived <- classes$Survived
  
  return (convert_to_numeric(data))
}


deal_with_Embarked_NA <- function(dataFrame){
  #dataFrame[(is.na(dataFrame$Embarked)),]
  #unique(dataFrame$Embarked)
  #print(mean(dataFrame[(which(dataFrame$Embarked == "S")),]$Fare, na.rm = T))
  #print(mean(dataFrame[(which(dataFrame$Embarked == "C")),]$Fare, na.rm = T))
  #print(mean(dataFrame[(which(dataFrame$Embarked == "Q")),]$Fare, na.rm = T))
  
  #dataFrame$Embarked <- na_replace(dataFrame$Embarked, 'C')
  dataFrame$Embarked <- ifelse(is.na(dataFrame$Embarked), 
                               'C', dataFrame$Embarked)
  
  return (dataFrame)
}

deal_with_Cabin_NA <- function(dataFrame) {
  dataFrame = within(dataFrame, rm("Cabin"))

  return(dataFrame)  
}

deal_with_Fare_NA <- function(dataFrame) {
  #print(dataFrame[(which(is.na(dataFrame$Fare))),])
  m1 <- mean(dataFrame[(which(dataFrame$Embarked == "S" & dataFrame$Sex == "male" & dataFrame$Pclass == 3)),]$Fare, na.rm=T)
  dataFrame$Fare <- na_replace(dataFrame$Fare, m1)
  
  return (dataFrame)
}

deal_with_NA_values <- function(dataFrame){
  sapply(dataFrame, function(x) sum(is.na(x)))
  
  dataFrame <- deal_with_Cabin_NA(dataFrame)
  dataFrame <- deal_with_Embarked_NA(dataFrame)
  dataFrame <- deal_with_Fare_NA(dataFrame)
  
  sapply(dataFrame, function(x) sum(is.na(x)))
  
  return (dataFrame)
}

#####################################################################################

main <- function(){
  
  dataFrame <- read_data("Titanic/train.csv", "Titanic/test.csv", "Titanic/classes.csv")  
  dataFrame <- deal_with_NA_values(dataFrame)
  
  head(dataFrame)
}

main()