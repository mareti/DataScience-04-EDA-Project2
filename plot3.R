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
    
    dt = NEI %>%
        filter(fips=="24510") %>%
        group_by(year, type) %>%
        summarize(sumEmissions=sum(Emissions)) 
    
    #dt$yr = factor(dt$year, levels=c("1999","2002","2005","2008"))
    
    q = ggplot(data=dt
               , aes(x=year, y=sumEmissions, group=type, color=type))
    q = q + geom_line()
    q = q + labs(x="Year")
    q = q + labs(y="Emissions")
    q = q + labs(title="Baltimore City Emission Trend")
    
    ggsave(q, file="plot3.png", width=5, height=5, units="in")
    
    # Runtime
    endTime = now()
    print(paste("Runtime:", endTime-startTime, "seconds"))
}