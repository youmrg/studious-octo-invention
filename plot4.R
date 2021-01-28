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

#plot4

#setup canvas
par(mfrow = c(2, 2))


with(filtered_p1dat,{ 
  #First Plot
  plot(DateTime, Global_active_power, 
       ylab =  'Global Active Power',
       pch = NA,
       lines(DateTime, Global_active_power))
  #Second Plot
  plot(DateTime, Voltage, 
       ylab =  'Voltage',
       xlab = 'datetime',
       pch = NA,
       lines(DateTime, Voltage))
  #Third Plot (Created a Function To Do This)
  CreatePlot3()
  #Fourth Plot
  plot(DateTime, Global_reactive_power, 
       xlab = 'datetime',
       pch = NA,
       lines(DateTime, Global_reactive_power))
})

#Copy To JPEG
dev.copy(jpeg, file = 'plot4.jpg',width=1024, height=610)
dev.off()