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
png(filename="plot2.png",width=480,height=480)

## Plot2 is created for days vs Global Active Power
plot(
  my_data$Date,
  my_data$Global_active_power,
  type="n",
  ylab="Global Active Power (kilowatts)",
  xlab="",
  xaxt="n"
)
lines(my_data$Date,my_data$Global_active_power)
axis(
  side=1,
  at=c(1170268200,1170354660,1170441060),
  labels=c("Thu","Fri","Sat")
)

dev.off()

