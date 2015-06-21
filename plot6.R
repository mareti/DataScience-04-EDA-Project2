plot6 <- function() {
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
        filter((fips=="24510"|fips=="06037") & type=="ON-ROAD") %>% 
        group_by(fips, year, type) %>%
        summarize(sumEmissions=sum(Emissions)) %>%
        ggplot(aes(x=factor(year), y=sumEmissions, group=fips)) +
        geom_line(aes(colour=fips)) +
        geom_point(aes(colour=fips)) +
        geom_text(aes(label=round(sumEmissions, 0)), size=3, vjust=-0.5) +
        labs(x="Year") +
        labs(y="Sum of Emissions") +
        ggtitle(expression(
            atop("Motor Vehicle Emissions"
            , atop("Baltimore City (24510) vs. Los Angeles (06037)"))))
    
    ggsave(file="plot6.png", width=5, height=5, units="in")
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", round(endTime-startTime, 2), "seconds"))
}