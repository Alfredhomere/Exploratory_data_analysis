# Exploratory Data Analysis - week4 - Project 2 Assignment #
# Alfred Homere, April 22, 2016

# Loading datasets - loading from local computer
NEI <- readRDS("~/exploratory_data_analysis/summarySCC_PM25.rds")
SCC <- readRDS("~/exploratory_data_analysis/Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles #
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name #
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame #
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# Ploting the graph
png("plot6.png",width=480,height=480,units="px",bg="transparent")
library(ggplot2)
ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

dev.off()
