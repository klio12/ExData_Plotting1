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

## Plot 4
par(mfrow=c(2,2))
par(cex = 0.7)
with (pc2days, {
	plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="o", pch="")
	plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="o", pch="")
	plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="o", pch="")
	lines(DateTime, Sub_metering_2, col="red")
	lines(DateTime, Sub_metering_3, col="blue")
	legend("topright", legend = names(pc2days)[grep("Sub_metering_", names(pc2days))], col = c("black", "red", "blue"), lty=1, bty="n")
	plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="o", pch="")
	})

## write png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

