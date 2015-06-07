#assumes sqldf installed already;
#install.packages("sqldf")
#assumes lubridate is installed
#install.packa('lubridate')

library(sqldf)
library(lubridate)

#only select within date range 1/2/2007 - 2/2/2007 and exclude data with '?' values
household_power_consumption <-read.csv.sql("exdata-data-household_power_consumption/household_power_consumption.txt", 
                                           sql = 'select * from file where Date in ("1/2/2007", "2/2/2007") AND Global_active_power!= "?"', 
                                           header = TRUE, 
                                           sep =";",
                                           stringsAsFactors = FALSE)

#let's write directly to a PNG file rather than to the screen
png(file = "plot2.png")

#combine the date and time values and use lubridate to set the format
datetime <- dmy_hms(paste(household_power_consumption$Date, household_power_consumption$Time)) 

plot(datetime, household_power_consumption$Global_active_power,type="l",xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()

#close the connection
closeAllConnections()