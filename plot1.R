# Exploratory Data Analysis - Week4 - Project2-Assignment#
# Alfred Homere, April 22, 2016

# Loading provided datasets - loading from local machine
NEI <- readRDS("~/exploratory_data_analysis/summarySCC_PM25.rds")
SCC <- readRDS("~/exploratory_data_analysis/Source_Classification_Code.rds")

# Sampling
NEI_sampling <- NEI[sample(nrow(NEI), size=2000, replace=F), ]

# Aggregate
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# Generate the graph in the same directory as the source code
png(filename='~/exploratory_data_analysis/plot1.png')
barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()
