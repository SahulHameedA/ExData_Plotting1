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

## create the plots to png file 
png(file="plot4.png", width=480, height=480,units="px")

par(mfrow=c(2,2))

## create plot 1
with(febData,
     plot(Time,Global_active_power,
          type="n",
          xlab="",
          ylab="Global Active Power (kilowatts)"))
with(febData,lines(Time,Global_active_power))

##create plot2
with(febData,
     plot(Time,Voltage,type="n",xlab="datetime",ylab="Voltage"))
with(febData,lines(Time,Voltage,col="black"))
          
## create plot 3
with(febData,
     plot(Time,Sub_metering_1,
          type="n",
          xlab="",
          ylab="Energy sub metering"))

with(febData,lines(Time,Sub_metering_1,col="black"))
with(febData,lines(Time,Sub_metering_2,col="red"))
with(febData,lines(Time,Sub_metering_3,col="blue"))
legend("topright",
       pch=c("-","-","-"),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n")

##create plot4
with(febData,
     plot(Time,Global_reactive_power,type="n",xlab="datetime"))
with(febData,lines(Time,Global_reactive_power,col="black"))

dev.off()

