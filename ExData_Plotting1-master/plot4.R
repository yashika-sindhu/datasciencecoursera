## Download the dataset
download.file(
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  destfile="Electric_Power_dataset.zip"
)
## Unzip the data
unzip("Electric_Power_dataset.zip")

## Read the relevant data into R
install.packages("sqldf")
library(sqldf)
my_data<-read.csv.sql(
  "household_power_consumption.txt",
  sql="select * from file where Date='1/2/2007' or Date='2/2/2007'",
  sep=";"
)

## Convert Date and Time column to Date/Time class POSIXct
my_data$Date<-as.POSIXct(paste(as.Date(my_data$Date,"%d/%m/%Y"),my_data$Time))
my_data$Time<-NULL
## Convert the Datetime to numeric value to plot it on the graph
my_data$Date<-as.numeric(my_data$Date)

## PNG file is opened
png(filename="plot4.png",width=480,height=480)

## Plot4 is created with the multiple plots
par(mfrow=c(2,2),cex=0.70)

## Plot 1 of the 4 plots Days vs Active Power
plot(
  my_data$Date,
  my_data$Global_active_power,
  type="n",
  ylab="Global Active Power",
  xlab="",
  xaxt="n"
)
lines(my_data$Date,my_data$Global_active_power)
axis(
  side=1,
  at=c(1170268200,1170354660,1170441060),
  labels=c("Thu","Fri","Sat")
)

## Plot 2 of the 4 Plots Days vs Voltage
plot(
  my_data$Date,
  my_data$Voltage,
  type="n",
  ylab="Voltage",
  xlab="datetime",
  xaxt="n"
)
lines(my_data$Date,my_data$Voltage)
axis(
  side=1,
  at=c(1170268200,1170354660,1170441060),
  labels=c("Thu","Fri","Sat")
)

## Plot3 of the 4 plots Day vs Metering
plot(
  my_data$Date,
  my_data$Sub_metering_1,
  type="n",
  ylab="Energy sub metering",
  xlab="",
  xaxt="n"
)
axis(
  side=1,
  at=c(1170268200,1170354660,1170441060),
  labels=c("Thu","Fri","Sat")
)
lines(my_data$Date,my_data$Sub_metering_1,col="black")
lines(my_data$Date,my_data$Sub_metering_2,col="red")
lines(my_data$Date,my_data$Sub_metering_3,col="blue")
legend(
  "topright",
  inset=0.015,
  legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
  col=c("black","red","blue"),
  lty=1,
  box.lty=0
)

## Plot 4 of the 4 plots Day vs Reactive Power
plot(
  my_data$Date,
  my_data$Global_reactive_power,
  type="n",
  ylab="Global_reactive_power",
  xlab="datetime",
  xaxt="n"
)
lines(my_data$Date,my_data$Global_reactive_power)
axis(
  side=1,
  at=c(1170268200,1170354660,1170441060),
  labels=c("Thu","Fri","Sat")
)

## Close the PNG connection
dev.off()

