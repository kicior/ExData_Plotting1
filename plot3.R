#Reading used libraries
require(data.table)
require(dplyr)
require(magrittr)
require(lubridate)
#Setting new locale
orglocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
#Reading data from file using data.table
data <- tbl_df(
  fread("household_power_consumption.txt",
    na.strings = "?",
    colClasses = "character",
    select = c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  )
#Filtering data
data_filtered <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
  mutate(datetime = dmy_hms(paste(Date, Time)))
#Opening png device
png(filename = "plot3.png", width = 480, height = 480, type = "cairo-png", antialias = "subpixel")
#Setting parameters and plotting
par(mfcol = c(1, 1), mar = c(3, 4, 1, 1))
with(data_filtered, plot(datetime, Sub_metering_1, main="", xlab = "", ylab = "Energy sub metering", type = "n"))
with(data_filtered, lines(datetime, Sub_metering_1, col = "black"))
with(data_filtered, lines(datetime, Sub_metering_2, col = "red"))
with(data_filtered, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Closing device
dev.off()
#Setting old locale
Sys.setlocale("LC_TIME", orglocale)
#Cleaning
rm(data, data_filtered, orglocale)
