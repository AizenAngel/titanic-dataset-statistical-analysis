library("imputeTS")
library(ggplot2)
library(kableExtra)
library(MASS)
library(mice)
library(caret)

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
  dataFrame$Survived =as.integer(dataFrame$Survived)
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

deal_with_Age_NA <- function(dataFrame) {
  mice_dataframe <- subset(dataFrame, select = c("Survived", "Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")) 
  mice_impute <- mice(mice_dataframe, method = "rf")
  micecomplete<- complete(mice_impute)
  
  #summary(dataFrame$Age)
  #summary(micecomplete$Age)
  dataFrame$Age <- micecomplete$Age
  #mice.impute.
  return (dataFrame)
}

deal_with_Embarked_NA <- function(dataFrame){
  #print("Embarked NA: ")
  print(dataFrame[(is.na(dataFrame$Embarked)),])
  #unique(dataFrame$Embarked)
  #print(median(dataFrame[(which(dataFrame$Embarked == "S" & dataFrame$Pclass==1 & dataFrame$Sex=="female" & dataFrame$Survived == 1)),]$Fare, na.rm = T))
  #print(median(dataFrame[(which(dataFrame$Embarked == "C" & dataFrame$Pclass==1 & dataFrame$Sex=="female" & dataFrame$Survived == 1)),]$Fare, na.rm = T))
  #print(median(dataFrame[(which(dataFrame$Embarked == "Q" & dataFrame$Pclass==1 & dataFrame$Sex=="female" & dataFrame$Survived == 1)),]$Fare, na.rm = T))
  
  #dataFrame$Embarked <- na_replace(dataFrame$Embarked, 'S')
  dataFrame$Embarked <- ifelse(is.na(dataFrame$Embarked), 
                               'S', dataFrame$Embarked)
  
  return (dataFrame)
}

deal_with_Cabin_NA <- function(dataFrame) {
  dataFrame = within(dataFrame, rm("Cabin"))
  
  return(dataFrame)  
}

deal_with_Fare_NA <- function(dataFrame) {
  print(dataFrame[(which(is.na(dataFrame$Fare))),])
  m1 <- mean(dataFrame[(which(dataFrame$Embarked == "S" & dataFrame$Sex == "male" & dataFrame$Pclass == 3 & dataFrame$Survived == 0)),]$Fare, na.rm=T)
  dataFrame$Fare <- na_replace(dataFrame$Fare, m1)
  
  return (dataFrame)
}

deal_with_NA_values <- function(dataFrame){
  sapply(dataFrame, function(x) sum(is.na(x)))
  #dataFrame <- deal_with_Cabin_NA(dataFrame)
  dataFrame <- deal_with_Embarked_NA(dataFrame)
  dataFrame <- deal_with_Fare_NA(dataFrame)
  dataFrame <- deal_with_Age_NA(dataFrame)
  sapply(dataFrame, function(x) sum(is.na(x)))
  
  return (dataFrame)
}

plot_female_vs_male_survival_frequency <- function(dataFrame){
  png(file='img/plot_female_vs_male_survival_frequency.png')
  barplot(table(dataFrame$Sex,dataFrame$Survived),col=c("red","orange"), names.arg = c("male", "female")) 
  legend("topright",text.col=c("red","orange"),legend=c("Survived","Not Survived"), cex = 0.6) 
  dev.off()
}

plot_sibsp_vs_survived <- function(dataFrame) {
  
  all_sibsp <- c(0:8)
  survival_percentage <- vector()
  
  for (i in all_sibsp) {
    all_passengers_for_current_sibsp <- subset(dataFrame, SibSp == i)
    number_of_survivals = sum(all_passengers_for_current_sibsp$Survived)
    number_of_all_passengers = length(all_passengers_for_current_sibsp$Survived)
    
    
    if (number_of_survivals == 0) {
      survival_percentage <- append(survival_percentage, 0)
    } else {
      percentage <- number_of_survivals / number_of_all_passengers
      survival_percentage <- append(survival_percentage, percentage)
    }
  }
  
  
  #png(file='img/plot_sibsp_vs_survived.png')
  barplot(survival_percentage, names.arg=all_sibsp, xlab="SibSp", ylab="Survival Percentage", ylim=c(0, 1),col="blue",
          main="Survival Percentage vs SibSp")
  
  #dev.off()
}

plot_name_vs_survived <- function(dataFrame, min_num_of_people_with_the_name) {
  unique_names = unique(dataFrame$Name)
  
  
  names_with_min_num_of_people <- vector()
  for (name in unique_names) {
    number_of_people_with_the_name <- nrow(subset(dataFrame, Name == name))
    if (number_of_people_with_the_name >= min_num_of_people_with_the_name) {
      names_with_min_num_of_people <- append(names_with_min_num_of_people, name)
    }
  }
  
  survival_percentage <- vector()
  for(name in names_with_min_num_of_people) {
    all_passengers_for_current_name <- subset(dataFrame, Name == name)
    number_of_survivals = sum(all_passengers_for_current_name$Survived)
    number_of_all_passengers = length(all_passengers_for_current_name$Survived)
    
    
    if (number_of_survivals == 0) {
      survival_percentage <- append(survival_percentage, 0)
    } else {
      percentage <- 100 * number_of_survivals / number_of_all_passengers
      survival_percentage <- append(survival_percentage, percentage)
    }
  }
  png(file='img/plot_name_vs_survived.png')
  barplot(survival_percentage, names.arg=names_with_min_num_of_people, xlab="Names", ylab="Survival Percentage", ylim=c(0, 100),col="blue",
          main="Survival Percentage vs Names", las=2, cex.names = 0.75)
  dev.off()
}

plot_embarked_vs_fare <- function(dataFrame) {
  embark_places <- c('S', 'C', 'Q')
  colors <- c('red', 'green', 'blue')
  names(colors) <- embark_places
  
  fares_s <- subset(dataFrame, Embarked == 'S')$Fare
  fares_c <- subset(dataFrame, Embarked == 'C')$Fare
  fares_q <- subset(dataFrame, Embarked == 'Q')$Fare
  
  
  fares_list = list("S"=fares_s[fares_s < 300], "C"=fares_c[fares_c < 300], "Q"=fares_q[fares_q < 300])
  png(file='img/plot_embarked_vs_fare.png')
  stripchart(
    fares_list,
    main="Comparison between fares in different embark places",
    xlab="Fare price",
    ylab="Embark places",
    method="jitter",
    col=colors,
    pch=16
  );
  dev.off()
}

dependency_test <- function(dataFrame, alpha){
  n <- length(dataFrame$Survived)
  dataTable <- table(dataFrame)
  print(dataTable)
  
  p_rows <- apply(dataTable, FUN = sum, MARGIN = 1) / n
  p_columns <- apply(dataTable, FUN = sum, MARGIN = 2) / n
  
  expected_data <- c(dataTable)
  
  values <- expand.grid(p_rows, p_columns)
  values <- values[1] * values[2]
  values <- matrix(values[[1]], ncol = length(expected_data)/2) * n
  
  test_statistics = sum((expected_data - values)^2 / values)
  c = qchisq(1-alpha, ncol(dataTable)-1)
  print("Test statistics")
  print(test_statistics)
  print("Critical section constant")
  print(c)
  
  return (test_statistics > c)
}

test_survived_dependant_on_embarked <- function(dataFrame, alpha){
  survived_embarked_subset <- subset(dataFrame, select = c("Survived", "Embarked")) 
  
  return (dependency_test(survived_embarked_subset, alpha))
}

test_survived_dependant_on_pclass <- function(dataFrame, alpha){
  survived_fare_subset <- subset(dataFrame, select = c("Survived", "Pclass"))
  
  return (dependency_test(survived_fare_subset, alpha))
}

plot_sex_vs_age_survival <- function(dataset){
  ggplot(dataFrame, aes(Age, fill = factor(Survived))) + 
    geom_histogram() + 
    facet_grid(.~Sex) 
  #ggsave(
  #  "img/plot_sex_vs_age_survived.png",
  #  plot = last_plot())
}

test_survived_dependant_on_age <- function(dataFrame, alpha){
  # early childhood, middle childhood and late childhood, adolescence, earlay adulthood, midlife, mature adulthood, late adulthood
  #age_breaks = c(4, 12, 21, 35, 50, 80)
  dataFrame$AgeGroup[dataFrame$Age < 4] <- 1
  dataFrame$AgeGroup[4<=dataFrame$Age & dataFrame$Age < 12] <- 2
  dataFrame$AgeGroup[12<=dataFrame$Age & dataFrame$Age < 21] <- 3
  dataFrame$AgeGroup[21<=dataFrame$Age & dataFrame$Age < 35] <- 4
  dataFrame$AgeGroup[35<=dataFrame$Age & dataFrame$Age < 50] <- 5
  dataFrame$AgeGroup[50<=dataFrame$Age & dataFrame$Age < 80] <- 6
  dataFrame$AgeGroup[dataFrame$Age >= 80] <- 7 
    
  survived_age_subset <- subset(dataFrame, select = c("Survived", "AgeGroup"))
  survived_age_subset <- na.omit(survived_age_subset)
  
  
  return(dependency_test(survived_age_subset, alpha))
}

test_survived_dependant_on_cabin <- function(dataFrame, alpha){
  survived_cabin_subset <- subset(dataFrame, select = c("Survived", "Cabin"))
  survived_cabin_subset <- na.omit(survived_cabin_subset)
  
  survived_cabin_subset$Cabin <- substr(survived_cabin_subset$Cabin, 1, 1)
  #table(survived_cabin_subset) 

  return (dependency_test(survived_cabin_subset, alpha))  
}


regresion_for_survived <- function(dataFrame) {
  
  trainData <- dataFrame[1:1000, ]
  testData <- dataFrame[1001:1309, ]
  
  print("num of rows train: ")
  print(nrow(trainData))
  
  print("num of rows test: ")
  print(nrow(testData))
  
  print('Comparing Survived vs. Age')
  modelSurvivedVsAge = glm(Survived~Age, data = trainData, family='binomial')
  print(summary(modelSurvivedVsAge))
  predicted <- predict(modelSurvivedVsAge, newdata = testData, type = "response")
  predicted <- predicted[!is.na(predicted)]
  predicted <- ifelse(predicted > 0.5, "Survived", "Didn't survive")
  
  print(table(predicted))
  
  modelSurvivedVsAge = glm(Survived~Age*Pclass, data = trainData, family='binomial')
  print(summary(modelSurvivedVsAge))
  predicted <- predict(modelSurvivedVsAge, newdata = testData, type = "response")
  predicted <- predicted[!is.na(predicted)]
  predicted <- ifelse(predicted > 0.5, "Survived", "Didn't survive")
  
  print(table(predicted))
  
  print('Comparing Survived vs. Pclass')
  modelSurvivedVsAge = glm(Survived~Pclass, data = trainData, family='binomial')
  print(summary(modelSurvivedVsAge))
  predicted <- predict(modelSurvivedVsAge, newdata = testData, type = "response")
  predicted <- predicted[!is.na(predicted)]
  predicted <- ifelse(predicted > 0.5, "Survived", "Didn't survive")
  
  print(table(predicted))
  print(length(predicted))
  
  testSurvived <- testData$Survived
  testSurvived <- ifelse(testSurvived == 1, "Survived", "Didn't survive")
  print(table(testSurvived, predicted))
  
}

main <- function(){
  print('main started')
  dataFrame <- read_data("./Titanic/extracted_train.csv", "./Titanic/extracted_test.csv", "./Titanic/classes.csv")  
  print('dataFrame loaded')
  
  dataFrame <- deal_with_NA_values(dataFrame)
  print('Dealt with NA vals')
  
  summary(dataFrame$Age)
  
  plot_sibsp_vs_survived(dataFrame)
  plot_name_vs_survived(dataFrame, min_num_of_people_with_the_name = 5)
  plot_embarked_vs_fare(dataFrame)
  plot_female_vs_male_survival_frequency(dataFrame)
  plot_sex_vs_age_survival(dataFrame)
  
  test_survived_dependant_on_embarked(dataFrame, 0.01)
  test_survived_dependant_on_pclass(dataFrame, 0.01)
  test_survived_dependant_on_age(dataFrame, 0.01)
  test_survived_dependant_on_cabin(dataFrame, 0.01)
   
  regresion_for_survived(dataFrame)
}

main()