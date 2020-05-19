#install.packages("imputeTS")
library("imputeTS")
library(ggplot2)


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


deal_with_Embarked_NA <- function(dataFrame){
  #print("Embarked NA: ")
  #print(dataFrame[(is.na(dataFrame$Embarked)),])
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
  # print(dataFrame[(which(is.na(dataFrame$Fare))),])
  m1 <- mean(dataFrame[(which(dataFrame$Embarked == "S" & dataFrame$Sex == "male" & dataFrame$Pclass == 3)),]$Fare, na.rm=T)
  dataFrame$Fare <- na_replace(dataFrame$Fare, m1)
  
  return (dataFrame)
}

deal_with_NA_values <- function(dataFrame){
  sapply(dataFrame, function(x) sum(is.na(x)))
  
  #dataFrame <- deal_with_Cabin_NA(dataFrame)
  dataFrame <- deal_with_Embarked_NA(dataFrame)
  dataFrame <- deal_with_Fare_NA(dataFrame)
  
  sapply(dataFrame, function(x) sum(is.na(x)))
  
  return (dataFrame)
}

plot_gender_frequency <- function(dataFrame){
  ggplot(dataFrame, aes(x = Sex, fill = Survived)) + theme_bw() + geom_bar() + labs(y = "Number of Passengers\n", title = "Gender Frequency\n") + geom_bar(fill = c("red", "blue"))
}

plot_female_vs_male_survival_frequency <- function(dataFrame){
  barplot(table(dataFrame$Sex,dataFrame$Survived),col=c("red","orange"), names.arg = c("male", "female")) 
  legend("topright",text.col=c("red","orange"),legend=c("Survived","Not Survived"), cex = 0.6) 
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
      percentage <- 100 * number_of_survivals / number_of_all_passengers
      survival_percentage <- append(survival_percentage, percentage)
    }
  }
  
  print(survival_percentage)
  
  #? Pitati za ovo, jer ne znam alfa i beta potrebnu da probamo da aproksimiramo gamma, ovo javlja nekakvu eksponencijalnu
  #? Druga stvar koja mi nije jasna je da li je uopste moguce uraditi sa samo 8 tacaka (sumnjam)
  library(gamlss)
  library(gamlss.dist)
  library(gamlss.add)
  
  fit <- fitDist(survival_percentage, k = 2, type = "realplus", trace = FALSE, try.gamlss = TRUE)
  summary(fit)
  
  
  barplot(survival_percentage, names.arg=all_sibsp, xlab="SibSp", ylab="Survival Percentage", ylim=c(0, 100),col="blue",
          main="Survival Percentage vs SibSp")
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
  
  barplot(survival_percentage, names.arg=names_with_min_num_of_people, xlab="Names", ylab="Survival Percentage", ylim=c(0, 100),col="blue",
          main="Survival Percentage vs Names", las=2, cex.names = 0.75)
}

plot_embarked_vs_fare <- function(dataFrame) {
  embark_places <- c('S', 'C', 'Q')
  colors <- c('red', 'green', 'blue')
  names(colors) <- embark_places
  
  fares_s <- subset(dataFrame, Embarked == 'S')$Fare
  fares_c <- subset(dataFrame, Embarked == 'C')$Fare
  fares_q <- subset(dataFrame, Embarked == 'Q')$Fare
 
  
  fares_list = list("S"=fares_s[fares_s < 300], "C"=fares_c[fares_c < 300], "Q"=fares_q[fares_q < 300])
  stripchart(
    fares_list,
    main="Comparison between fares in different embark places",
    xlab="Fare price",
    ylab="Embark places",
    method="jitter",
    col=colors,
    pch=16
  );
}
                                 

#####################################################################################
main <- function(){
  print('main started')
  dataFrame <- read_data("./Titanic/extracted_train.csv", "./Titanic/extracted_test.csv", "./Titanic/classes.csv")  
  print('dataFrame loaded')
  dataFrame <- deal_with_NA_values(dataFrame)
  
  print('Dealt with NA vals')
  
  #survived(dataFrame)
  
  # prop.table(table(dataFrame$Survived))
  # plot_gender_frequency(dataFrame)
  # plot_female_vs_male_survival_frequency(dataFrame)
  #plot_sibsp_vs_survived(dataFrame)
  # plot_name_vs_survived(dataFrame, min_num_of_people_with_the_name = 5)
  # head(dataFrame)
  plot_embarked_vs_fare(dataFrame)
}

main()
  