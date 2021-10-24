## This code contains two different problems:
## numbers 1-3 covers problem for folder name "specdata",
## number 4 is the code for "hospdata"
## BUT FOR THIS CODE I PUT THE "specdata" and "outcome-of-care-measures.csv"
## on the SAME FOLDER for easy access on printing
## To run this code, first you must check the directory if 


directory <- "specdata"

# |------------------------------------------------------------------------------------------|
# | N U M B E R 1 | PRINT THE MEAN - "pollutantmean" that calculates the mean of a pollutant |
# |------------------------------------------------------------------------------------------|

  
pollutantmean <- function(directory, pollutant, id = 1:332){ 
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of  the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate"
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result
  
  means <- c()
  
  for(monitor in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
    monitor_data <- read.csv(path)
    interested_data <- monitor_data[pollutant]
    means <- c(means, interested_data[!is.na(interested_data)])
  }
  
  mean(means)
}

#---------test data for number 1----------
#---------Instruction: remove "#" before the function to test
pollutantmean("specdata", "sulfate", 1:10)
#pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)
#pollutantmean("specdata", "nitrate", 25)
#-----------------------------------------

# |------------------------------------------------------------------------------------------|
# |  N U M B E R 2 |Modify your code from item number 1                                      |
# |------------------------------------------------------------------------------------------|

complete <- function(directory, id = 1:332){
  ## 'director' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the from:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  results <- data.frame(id=numeric(0), nobs=numeric(0))
  for(monitor in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
    monitor_data <- read.csv(path)
    interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
    interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
    nobs <- nrow(interested_data)
    results <- rbind(results, data.frame(id=monitor, nobs=nobs))
  }
  results
}

#---------test data for number 2----------
#---------Instruction: remove "#" before the function to test

#complete("specdata", 1)
complete("specdata", c(2,4,8,10,12))
complete("specdata", 30:25)
#complete("specdata", 3)
#-----------------------------------------



# |------------------------------------------------------------------------------------------|
# |  N U M B E R 3 | CORRELATION
# |------------------------------------------------------------------------------------------|
corr <- function(directory, threshold = 0){
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the 
  ## number of completely observed observations (on all variables)
  ## required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## Do not round the result.
  
  
  cor_num <- numeric(0)  # create an empty numeric vector
  
  complete_cases <- complete(directory)
  complete_cases <- complete_cases[complete_cases$nobs >= threshold, ]
  if(nrow(complete_cases) > 0){
    for(monitor in complete_cases$id){
      path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
      monitor_data <- read.csv(path)
      interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
      interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
      sulfate_data <- interested_data["sulfate"]
      nitrate_data <- interested_data["nitrate"]
      cor_num <- c(cor_num, cor(sulfate_data, nitrate_data))
    }
  }
  cor_num
}

#---------test data for number 3----------
#---------Instruction: remove "#" before the function to test

cr <- corr("specdata", 150)
head(cr); summary(cr)

#cr <- corr("specdata", 400)
#head(cr); summary(cr)

#cr <- corr("specdata", 5000)
#head(cr); summary(cr);length(cr)

cr <- corr("specdata")
head(cr);summary(cr);length(cr)
#-----------------------------------------


# |------------------------------------------------------------------------------------------|
# |  N U M B E R 4 |  Prints HISTOGRAM for HEART ATTACK 30-DAY DEATH RATE
# |------------------------------------------------------------------------------------------|

outcome <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')

outcome[, 11] <- as.numeric(outcome[, 11]) ## coerce the column to numeric
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11],
     main = 'Heart Attack 30-day Death Rate',
     xlab = '30-day Death Rate')
