#
# plot2.R
#
# Bob Uva
# Exploratory Data Analysis : John Hopkins : Coursera
# Project 2
# September, 2014
#

source("readData.R")

# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question.
NEI <- NEI[NEI$fips == "24510",]

yearTotals <- tapply(NEI$Emissions, NEI$year, sum)
df <- data.frame(Year=c(1999, 2002, 2005, 2008), 
                 Total=yearTotals)

# Set graphics device to PNG file.
png(file="plot2.png")

plot(df$Year, df$Total, type="l", col="red", main="Total Emissions by Year In Baltimore", xlab="Year", ylab="Total Emissions")

# Close the graphics device
dev.off()
