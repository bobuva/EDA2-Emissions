#
# plot4.R
#
# Bob Uva
# Exploratory Data Analysis : John Hopkins : Coursera
# Project 2
# September, 2014
#

source("readData.R")

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# The Emissions Inventory (EI) Sector identifies coal combustion-related sources.
eiSector <- as.character(SCC$EI.Sector)
indices <- grep("Coal", eiSector, value=FALSE, fixed=TRUE)
sccNumbers <- SCC[indices, "SCC"]
emissions <- NEI[NEI$SCC %in% sccNumbers, c("year", "Emissions") ]

tempE <- tapply(emissions$Emissions, emissions$year, sum)
emissionsDF <- data.frame(tempE)
emissionsDF$Year <- c("1999", "2002", "2005", "2008")
colnames(emissionsDF) <- c("Emissions", "Year")

# Set graphics device to PNG file.
png(file="plot4.png")

g <- ggplot(emissionsDF, aes(Year, Emissions))
gprint <- g + geom_point() + geom_smooth(aes(group=1)) +
  ggtitle("Total Emissions from Coal-combustion related sources") +
  theme_bw(base_family="Times")
print(gprint)

# Close the graphics device
dev.off()
