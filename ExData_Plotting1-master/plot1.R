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

## PNG file is opened
png(filename="plot1.png",width=480,height=480)

## Plot 1 is created for Global Active Power vs Frequency
hist(
  my_data$Global_active_power,
  col="red",
  breaks=seq(0,60,by=0.5),
  xlim=c(0,6),
  xaxt="n",
  xlab="Global Active Power (kilowatts)",
  ylab="Frequency",
  main="Global Active Power"
)
axis(side=1,at=c(0,2,4,6))
dev.off()

