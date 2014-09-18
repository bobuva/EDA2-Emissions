#
# plot3.R
#
# Bob Uva
# Exploratory Data Analysis : John Hopkins : Coursera
# Project 2
# September, 2014
#

source("readData.R")

library(ggplot2)
library(reshape2)

# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have 
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting 
# system to make a plot answer this question.

# Generate a matrix that contains the sum of emissions by year and type,
emissionsMatrix <- tapply(NEI$Emissions, list(NEI$year, NEI$type), sum)

# Convert matrix to a data.frame since a matrix cannot be used with ggplot2
df <- data.frame(emissionsMatrix)
df$Year <- c("1999", "2002", "2005", "2008")

# Transform the data set to make it easy to plot.
melteddf <- melt(df, id=c("Year"))
colnames(melteddf) <- c("Year", "Type", "Emissions")

# Set graphics device to PNG file.
png(file="plot3.png")

g <- ggplot(melteddf, aes(Year, Emissions))
gprint <- g + geom_point() + geom_smooth(aes(group=1)) + facet_grid(. ~ Type)
print(gprint)

# Close the graphics device
dev.off()
