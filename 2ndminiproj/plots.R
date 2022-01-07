filename<-"household_power_consumption_data.zip"
if(!file.exists(filename)){
  file<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(file,filename,method="curl")
}
if(!file.exists("household_power_consumption")){
  unzip(filename)
  
}

  data<-read.csv("household_power_consumption.txt",sep = ";",stringsAsFactors = FALSE)        # reading the csv file and marking no string as factors
  subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]                               # subsetting data to 2 particular dates
  
  datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # pasting date and time together to get the actual dates
  
  globalActivePower <- as.numeric(subSetData$Global_active_power)                             # coercing the column of subsetted data from character to numeric
  globalReactivePower <- as.numeric(subSetData$Global_reactive_power)
  voltage <- as.numeric(subSetData$Voltage)
  
  
  subMetering1 <- as.numeric(subSetData$Sub_metering_1)                                       # coercing the column of subsetted data from character to numeric
  subMetering2 <- as.numeric(subSetData$Sub_metering_2)
  subMetering3 <- as.numeric(subSetData$Sub_metering_3)
  
  #===============================================================================
  # Plot1 - Using Histogram for Global Active Power
  
  hist(globalActivePower,                                                                    # plotting a histogram   
       col="salmon",                                                                         # setting color of histogram
       main="Global Active Power",                                                           # setting main title of histogram
       xlab="Global Active Power (kilowatts)") 
  
  #===============================================================================================================================
  # Plot2 - Using Line Plot for Global Active Power 
  
  plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)") # plotting a Line Plot
  
  #===============================================================================================================================
  # Plot3 - Using Colored Line Plots for Three (3) Energy Sub-metering
  
  plot(datetime, subMetering1, type="l", col="black", ylab="Energy Submetering", xlab="")    # plotting a Line Plot for subMetering1 (default black)
  lines(datetime, subMetering2, type="l", col="red")                                         # adding a red Line Plot for subMetering2
  lines(datetime, subMetering3, type="l", col="blue")                                        # adding a blue Line Plot for subMetering3
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))  # adding a legend for colors
  
  #===============================================================================================================================
  ## Plot4 - Using Multiple Graphs in One Plot for Global Active Power, Voltage and Energy Sub-metering
  
  par(mfrow = c(2, 2))                                                                       # Calling par function for multiple graphs (2x2)
  
  plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power")           # Line Plot for Global Active Power  
  
  plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")                         # Line Plot for Voltage
  
  plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")                 # Line Plot for subMetering 1, 2, and 3
  lines(datetime, subMetering2, type="l", col="red")
  lines(datetime, subMetering3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
  
  plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power") # Line Plot for Global Reactive Power
  
  
  
  