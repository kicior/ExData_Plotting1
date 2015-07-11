library(data.table)
library(dplyr)
library(magrittr)
library(lubridate)
data <- tbl_df(
  fread("household_power_consumption.txt",
  na.strings = "?",
  colClasses = "character",
  select = c("Date", "Global_active_power"))
  )
data_filtered <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Global_active_power = as.numeric(Global_active_power))
png(filename = "plot1.png", width = 480, height = 480, type = "cairo-png", antialias = "subpixel")
par(mfcol = c(1, 1), mar = c(4, 4, 2, 0))
hist(data_filtered$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
rm(data, data_filtered)
