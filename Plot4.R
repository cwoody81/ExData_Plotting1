

##download data from project1 data site
link<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(link,"./data.zip", method="curl")

## decompress the file
unzip("data.zip")

##read the file to a table and store in variable data
data<-read.table("household_power_consumption.txt", 
                 sep = ";",header=T,na.strings="?" )

## subset out the correct date window for the data according to directions
data2<-data[data$Date %in% c("2/2/2007","1/2/2007"),]

## Convert dates from character to Date class
datatime<-paste(data2$Date,data2$Time)
data3<-strptime(datatime,format = "%d/%m/%Y %H:%M:%S")

## combine into new data frame with date
rest<-data2[,3:9]
data4<-data.frame(data3,rest)


##open a png device and set to prescribed dimensions
png(file="plot4.png", width = 480, height = 480, units = "px",)

##plot the line graph like the example
par(mfrow = c(2, 2))
with(data4, {
        plot(data3,Global_active_power, type="l", ylab = 
                     "Global Active Power (kilowatts)", xlab="")
        plot(data3, Voltage, type="l", ylab="Voltage", xlab="datetime")
        
plot(data3,Sub_metering_1,type="n", ylab = 
             "Energy sub metering", xlab="")

lines(data3,data4$Sub_metering_1, col="black")
lines(data3,data4$Sub_metering_2, col="red")
lines(data3,data4$Sub_metering_3, col="blue")

legend("topright", lty=1, bty="n", col=c("black","red","blue"),legend = 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


plot(data3,Global_reactive_power, type="l", xlab="datetime")
})
## turn off png in order to create the file
dev.off()