library("shiny") 
library("ggplot2")
library('dplyr')
library('plyr')
library('maps')
library('shinythemes')
library('reshape2')

hatecrime.2005 <- read.csv('data/hatecrime2005.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2006 <- read.csv('data/hatecrime2006.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2007 <- read.csv('data/hatecrime2007.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2008 <- read.csv('data/hatecrime2008.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2009 <- read.csv('data/hatecrime2009.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2010 <- read.csv('data/hatecrime2010.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2011 <- read.csv('data/hatecrime2011.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2012 <- read.csv('data/hatecrime2012.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2013 <- read.csv('data/hatecrime2013.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2014 <- read.csv('data/hatecrime2014.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2015 <- read.csv('data/hatecrime2015.csv', fileEncoding = "UTF-8-BOM")
hatecrime.2016 <- read.csv('data/hatecrime2016.csv', fileEncoding = "UTF-8-BOM")

# rename the incidents column with the year
colnames(hatecrime.2005)[3] <- "2005"
colnames(hatecrime.2006)[2] <- "2006"
colnames(hatecrime.2007)[2] <- "2007"
colnames(hatecrime.2008)[2] <- "2008"
colnames(hatecrime.2009)[2] <- "2009"
colnames(hatecrime.2010)[2] <- "2010"
colnames(hatecrime.2011)[2] <- "2011"
colnames(hatecrime.2012)[2] <- "2012"
colnames(hatecrime.2013)[2] <- "2013"
colnames(hatecrime.2014)[2] <- "2014"
colnames(hatecrime.2015)[2] <- "2015"
colnames(hatecrime.2016)[2] <- "2016"

# join all hate crime incidents from different years by bias motivation
hatecrime <- merge(x = hatecrime.2005[, 1:3], y = hatecrime.2006[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2007[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2008[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2009[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2010[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2011[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2012[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2013[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2014[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2015[, 1:2], by = "Bias.motivation", all.x = TRUE)
hatecrime <- merge(x = hatecrime, y = hatecrime.2016[, 1:2], by = "Bias.motivation", all.x = TRUE)
