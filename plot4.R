plot4 <- function() {
    # load required libraries
    library(ggplot2)
    library(dplyr)
    library(lubridate)
    library(grid)
    
    # initialize
    startTime = now()
    
    # Load data
    NEI = readRDS("./data/summarySCC_PM25.rds")
    SCC = readRDS("./data/Source_Classification_Code.rds")
    
    # first search SCC for the desired combustion related sources
    SCC_coal = SCC %>%
        select(SCC, Short.Name) %>%
        filter(grepl("coal", Short.Name, ignore.case=TRUE))
    
    # then use that code to filter/join the NEI data source
    NEI_coal = inner_join(NEI, SCC_coal, by = ("SCC"="SCC"))
    
    NEI_coal %>%
        group_by(year) %>%
        summarize(sumEmissions=sum(Emissions)) %>%
        ggplot(aes(x=year, y=sumEmissions)) +
        geom_line(arrow=arrow(type="closed", length=unit(0.1, "inches"))) +
        labs(x="Year") +
        labs(y="Sum of Emissions") +
        labs(title="Coal Emission Trend")
    
    ggsave(file="plot4.png", width=5, height=5, units="in")
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", round(endTime-startTime, 2), "minutes"))
}