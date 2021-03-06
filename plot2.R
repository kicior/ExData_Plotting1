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
    select = c("Date", "Time", "Global_active_power"))
  )
#Filtering data
data_filtered <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(datetime = dmy_hms(paste(Date, Time)))
#Opening png device
png(filename = "plot2.png", width = 480, height = 480, type = "cairo-png", antialias = "subpixel")
#Setting parameters and plotting
par(mfcol = c(1, 1), mar = c(3, 4, 1, 1))
with(data_filtered, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
#Closing device
dev.off()
#Setting old locale
Sys.setlocale("LC_TIME", orglocale)
#Cleaning
rm(data, data_filtered, orglocale)
