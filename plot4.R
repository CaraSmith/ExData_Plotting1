#assumes sqldf installed already;
#install.packages("sqldf")
#assumes lubridate is installed
#install.packages("lubridate")

library(sqldf)
library(lubridate)

#only select within date range 1/2/2007 - 2/2/2007 and exclude data with '?' values
household_power_consumption <-read.csv.sql("exdata-data-household_power_consumption/household_power_consumption.txt", 
                                           sql = 'select * from file where Date in ("1/2/2007", "2/2/2007") AND Global_active_power!= "?"', 
                                           header = TRUE, 
                                           sep =";",
                                           stringsAsFactors = FALSE)


#combine the date and time values and use lubridate to set the format
datetime <- dmy_hms(paste(household_power_consumption$Date, household_power_consumption$Time)) 

png(file = "plot4.png")

#we want a 2x2 grid
par(mfrow = c(2, 2))

#plot1
plot(datetime, household_power_consumption$Global_active_power,type="l",xlab="", ylab = "Global Active Power (kilowatts)")

#plot2
plot(datetime, household_power_consumption$Voltage,type="l", ylab = "Voltage")


#plot3 
#this time no border around the legend and scale the legend down a bit
plot(datetime, household_power_consumption$Sub_metering_1, type="l", col='black',xlab="", ylab = "Energy sub metering")
lines(datetime, household_power_consumption$Sub_metering_2, type="l", col='red')
lines(datetime, household_power_consumption$Sub_metering_3, type="l",col='blue')
legend("topright", bty = "n", lty=1,  cex = 0.9, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#plot4
plot(datetime, household_power_consumption$Global_reactive_power,type="l", ylab = "Global_reactive_power")



dev.off()

#close the connection
closeAllConnections()