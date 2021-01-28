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

#plot3

#Since there is so much code involved with creating Plot 3
#I made a function so I can call it later for other plots
CreatePlot3 = function(){
  #Add first line and baseline structure
  with(filtered_p1dat, {
    plot(DateTime, Sub_metering_1, 
         ylab =  'Energy sub metering',
         xlab = '',
         pch = NA,
         lines(DateTime, Sub_metering_1)) 
    #Add Second Line
    lines(DateTime, Sub_metering_2, 
          col = 'red')
    #Add Third Line
    lines(DateTime, Sub_metering_3, 
          col = 'blue')
    #Add Legend
    legend('topright', lty = 1, lwd = 2, col = c('black', 'red', 'blue'),
           legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
    )
  })
}

#Copy To JPEG
CreatePlot3()
dev.copy(jpeg, file = 'varunplot3.jpg',width=1024, height=610)
dev.off()