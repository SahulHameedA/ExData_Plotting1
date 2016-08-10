###############################################################################
## Read the file into R
## Assumption the file is already downloaded and unzipped in working directory
###############################################################################
colCls = c("character","character",rep("numeric",7))
pwr_cnsmptn <- read.table("./household_power_consumption.txt",
					header=TRUE, sep=";", 
					colClasses = colCls,
					stringsAsFactors= FALSE,
					na.strings="?",
					comment.char = "") 

## Convert the Date and Time 'character' type to POSIXlt
pwr_cnsmptn$Time <- strptime(paste(pwr_cnsmptn$Date,pwr_cnsmptn$Time),format="%d/%m/%Y %H:%M:%S",tz="")
pwr_cnsmptn$Date <- as.Date(pwr_cnsmptn$Date,format="%d/%m/%Y")

## subset the rows for Feb 1st and Feb 2nd of year 2007
febDay1 <- as.Date("2007-02-01")
febDay2 <- as.Date("2007-02-02")

febData <- subset(pwr_cnsmptn, Date == febDay1 | Date == febDay2)

## create the plot1 in png file device
png(file="plot1.png", width=480, height=480,units="px")

with(febData,
     hist(Global_active_power,
          col="red",
          main="Global Active Power",
          xlab="Global Active Power (kilowatts)"))

dev.off()

