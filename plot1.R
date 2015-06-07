
#assumes sqldf installed already;
#install.packages("sqldf")

library(sqldf)

#only select within date range 1/2/2007 - 2/2/2007 and exclude data with '?' values
household_power_consumption <-read.csv.sql("exdata-data-household_power_consumption/household_power_consumption.txt", 
                                   sql = 'select * from file where Date in ("1/2/2007", "2/2/2007") AND Global_active_power!= "?"', 
                                   header = TRUE, 
                                   sep =";",
                                   stringsAsFactors = FALSE)

#let's write directly to a PNG file rather than to the screen
png(file = "plot1.png")

#hard to tell if the colour was red or dark orange
hist(household_power_consumption$Global_active_power,col='red', 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

#close the connection
closeAllConnections()