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

#plot2
with(filtered_p1dat, 
     plot(DateTime, Global_active_power, 
          ylab =  'Global Active Power (kilowatts)',
          pch = NA,
          lines(DateTime, Global_active_power,)
     )
)

#Copy To JPEG

dev.copy(jpeg, file = 'plot2.jpg',width=1024, height=610)
dev.off()