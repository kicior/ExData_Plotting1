library(data.table)
library(dplyr)
library(magrittr)
library(lubridate)
orglocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
data <- tbl_df(
  fread("household_power_consumption.txt",
    na.strings = "?",
    colClasses = "character",
    select = c("Date", "Time", "Voltage", "Global_active_power", "Global_reactive_power", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  )
data_filtered <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Voltage = as.numeric(Voltage)) %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
  mutate(datetime = dmy_hms(paste(Date, Time)))
png(filename = "plot4.png", width = 480, height = 480, type = "cairo-png", antialias = "subpixel")
par(mfcol = c(2, 2), mar = c(4, 4, 1, 1))

with(data_filtered, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

with(data_filtered, plot(datetime, Sub_metering_1, main="", xlab = "", ylab = "Energy sub metering", type = "n"))
with(data_filtered, lines(datetime, Sub_metering_1, col = "black"))
with(data_filtered, lines(datetime, Sub_metering_2, col = "red"))
with(data_filtered, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

with(data_filtered, plot(datetime, Voltage, type = "l"))

with(data_filtered, plot(datetime, Global_reactive_power, type = "l"))
dev.off()
par(mfcol = c(1, 1))
Sys.setlocale("LC_TIME", orglocale)
rm(data, data_filtered, orglocale)
