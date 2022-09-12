

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

##open a png device and set to perscribed dimensions
png(file="plot2.png", width = 480, height = 480, units = "px",)

##plot the line graph like the example
plot(data3,data2$Global_active_power, type="l", ylab = 
             "Global Active Power (kilowatts)", xlab="")

## turn off png in order to create the file
dev.off()