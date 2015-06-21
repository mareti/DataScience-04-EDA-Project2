# load required libraries
library(ggplot2)
library(dplyr)
library(lubridate)

plot1 <- function() {
    # initialize
    startTime = now()
    
    # Load data
    NEI = readRDS("./data/summarySCC_PM25.rds")
    SCC = readRDS("./data/Source_Classification_Code.rds")
    
    x = NEI %>%
        group_by(year) %>%
        summarize(sumEmissions=sum(Emissions))
    
    png(filename="plot1.png", width=480, height=480, units="px")
    barplot(
        x$sumEmissions/(10^3)
        , xlab = 'Year'
        , ylab = expression(paste("PM", ""[2.5], "in thousands"))
        , names.arg = x$year
        , main = expression(paste("Total Emission of PM"[2.5]))
        )
    dev.off()
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", endTime-startTime, "seconds"))
}

