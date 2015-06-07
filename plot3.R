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

png(file = "plot3.png")

plot(datetime, household_power_consumption$Sub_metering_1, type="l", col='black',xlab="", ylab = "Energy sub metering")
lines(datetime, household_power_consumption$Sub_metering_2, type="l", col='red')
lines(datetime, household_power_consumption$Sub_metering_3, type="l",col='blue')
legend("topright", lty=1,  cex = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

#close the connection
closeAllConnections()