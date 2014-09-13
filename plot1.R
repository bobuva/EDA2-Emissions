#
# plot1.R
#
# Bob Uva
# Exploratory Data Analysis : John Hopkins : Coursera
# Project 2
# September, 2014
#

source("readData.R")

# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot 
# showing the total PM2.5 emission from all sources for each of 
# the years 1999, 2002, 2005, and 2008.
yearTotals <- tapply(NEI$Emissions, NEI$year, sum)
df <- data.frame(Year=c(1999, 2002, 2005, 2008), 
                 Total=yearTotals)


# Set graphics device to PNG file.
png(file="plot1.png")

plot(df$Year, df$Total, type="l", col="red", main="Total Emissions by Year", xlab="Year", ylab="Total Emissions")

# Close the graphics device
dev.off()
