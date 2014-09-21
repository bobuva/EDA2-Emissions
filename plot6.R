#
# plot6.R
#
# Bob Uva
# Exploratory Data Analysis : John Hopkins : Coursera
# Project 2
# September, 2014
#

source("readData.R")

library(ggplot2)
library(reshape2)

# Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in 
# motor vehicle emissions?

# The Emissions Inventory (EI) Sector identifies coal combustion-related sources.
eiSector <- as.character(SCC$EI.Sector)
indices <- grep("Vehicle", eiSector, value=FALSE, fixed=TRUE)
sccNumbers <- SCC[indices, "SCC"]
eBC <- NEI[NEI$SCC %in% sccNumbers & 
                (NEI$fips == "24510"), c("year", "Emissions") ]

eLA <- NEI[NEI$SCC %in% sccNumbers & 
             (NEI$fips == "06037"), c("year", "Emissions") ]

tempeBC <- tapply(eBC$Emissions, eBC$year, sum)
tempeLA <- tapply(eLA$Emissions, eLA$year, sum)

dfBC <- data.frame(tempeBC)
dfLA <- data.frame(tempeLA)
dfBC$Year <- c("1999", "2002", "2005", "2008")
dfLA$Year <- c("1999", "2002", "2005", "2008")
colnames(dfBC) <- c("Emissions", "Year")
colnames(dfLA) <- c("Emissions", "Year")

# Get the log of Emissions and add it as a column.
dfBC$LogEmissions <- log(dfBC$Emissions)
dfLA$LogEmissions <- log(dfLA$Emissions)

# Set graphics device to PNG file.
png(file="plot6.png")

# Generate the plot and print it to the file.
g <- ggplot(dfLA, aes(Year, LogEmissions)) + geom_line(aes(color="Los Angeles", group=1)) +
  geom_line(data=dfBC, aes(color="Baltimore", group=1)) +
  labs(color="Legend") + ggtitle("Logarithm Change in Emissions - Baltimore and LA") +
  theme_bw(base_family="Times")

print(g)

# Close the graphics device
dev.off()
