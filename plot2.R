plot2 <- function() {
    # load required libraries
    library(dplyr)
    library(lubridate)
    
    # initialize
    startTime = now()
    
    # Load data
    NEI = readRDS("./data/summarySCC_PM25.rds")
    SCC = readRDS("./data/Source_Classification_Code.rds")
    
    x = NEI %>%
        filter(fips=="24510") %>%
        group_by(year) %>%
        summarize(sumEmissions=sum(Emissions))
    
    png(filename="plot2.png", width=480, height=480, units="px")
    barplot(
        x$sumEmissions/(10^3)
        , xlab = 'Year'
        , ylab = expression(paste("PM", ""[2.5], "in thousands"))
        , names.arg = x$year
        , main = expression(paste("Emission of PM"[2.5], "in Baltimore City"))
    )
    dev.off()
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", round(endTime-startTime, 2), "seconds"))
}