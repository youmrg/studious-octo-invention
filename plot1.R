#reading the data

#Remove All Variables From Environment
rm(list = ls())
#Setup Working Directory
#Read In File
p1dat = read.table('household_power_consumption.txt', header = T,
                   sep = ';', na.strings = c('NA', '?', ''))
#Convert "Date" Column Into Date Using Lubridate
library(lubridate)
p1dat$Date = dmy(p1dat$Date)

#Filter Out Data For Only Two Days
selected_dates = ymd(c('2007-02-01', '2007-02-02'))
filtered_p1dat = p1dat[p1dat$Date %in% selected_dates, ]

#Create Date Time Field
filtered_p1dat$DateTime = with(filtered_p1dat, ymd_hms(paste(Date, Time)))

#Remove full data frame as we only need data for two days
rm(p1dat)

#plot1
#Draw Plot and Send to PNG
hist(filtered_p1dat$Global_active_power, main = "Global Active Power", 
     xlab = 'Global Active Power (kilowatts)', col = 'red')

#Copy To JPEG

dev.copy(jpeg, file = 'plot1.jpg',width=1024, height=610)
dev.off()

