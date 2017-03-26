#################################
## unzip original file (must be in working directory)
unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir=".")

## read entir file into a data frame
pc<-read.table("household_power_consumption.txt", sep=";", header=T)

## select only the records falling on Feb 1, 2007 and Feb 2, 2007
pc2days<-pc[pc$Date %in% c("1/2/2007", "2/2/2007"),]

## adjust data in all columns:
## "Date" and "Time" into a POSIXct object
pc2days<-cbind(DateTime=strptime(paste(pc2days[,1], pc2days[,2]), format="%d/%m/%Y %H:%M:%S"), pc2days[,3:9])

## all other columns into 'numeric'
i=2; while(i<= ncol(pc2days)){pc2days[,i]<-as.numeric(as.character(pc2days[,i])); i=i+1}

#################################

## Plot 2
plot(pc2days$DateTime, pc2days$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n")
lines(pc2days$DateTime, pc2days$Global_active_power)

## write png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
