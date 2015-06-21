plot3 <- function() {
    # load required libraries
    library(ggplot2)
    library(dplyr)
    library(lubridate)
    
    # initialize
    startTime = now()
    
    # Load data
    NEI = readRDS("./data/summarySCC_PM25.rds")
    SCC = readRDS("./data/Source_Classification_Code.rds")
    
    NEI %>%
        filter(fips=="24510") %>%
        group_by(year, type) %>%
        summarize(sumEmissions=sum(Emissions)) %>%
        ggplot(aes(x=year, y=sumEmissions, group=type, color=type)) %>%
        + geom_line() %>%
        + labs(x="Year") %>%
        + labs(y="Emissions") %>%
        + labs(title="Baltimore City Emission Trend") %>%
        ggsave(file="plot3.png", width=5, height=5, units="in")
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", endTime-startTime, "seconds"))
}