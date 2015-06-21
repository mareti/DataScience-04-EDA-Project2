plot5 <- function() {
    # load required libraries
    library(ggplot2)
    library(dplyr)
    library(lubridate)
    
    # initialize
    startTime = now()
    
    # Load data
    #NEI = readRDS("./data/summarySCC_PM25.rds")
    #SCC = readRDS("./data/Source_Classification_Code.rds")
    
    NEI %>%
        filter(fips=="24510" & type=="ON-ROAD") %>% 
        group_by(year, type) %>%
        summarize(sumEmissions=sum(Emissions)) %>%
        ggplot(aes(x=factor(year), y=sumEmissions)) +
        geom_bar(stat="identity") +
        geom_text(aes(label=round(sumEmissions, 0)), size=3, vjust=-0.5) +
        labs(x="Year") +
        labs(y="Sum of Emissions") +
        labs(title="Motor Vehicle Emissions in Baltimore City")

    ggsave(file="plot5.png", width=5, height=5, units="in")
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", endTime-startTime, "seconds"))
}