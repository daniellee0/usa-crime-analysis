# df.list <- list(df1,df2,...)
# res <- lapply(df.list, function(x) rowMeans(subset(x, select = c(start, stop)), na.rm = TRUE))
library(plyr)
library(dplyr)

population.size.2005 <- read.csv("data/population-size-2005.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2005) %>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2005.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2005.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2005.estimated.population * 100000,
         Robbery.rate = Robbery / X2005.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2005.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2005.estimated.population * 100000,
         Burglary.rate = Burglary / X2005.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2005.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2005.estimated.population * 100000,
         Arson.rate = Arson / X2005.estimated.population * 100000)

population.size.2006 <- read.csv("data/population-size-2006.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2006) %>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2006.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2006.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2006.estimated.population * 100000,
         Robbery.rate = Robbery / X2006.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2006.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2006.estimated.population * 100000,
         Burglary.rate = Burglary / X2006.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2006.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2006.estimated.population * 100000,
         Arson.rate = Arson / X2006.estimated.population * 100000)

population.size.2007 <- read.csv("data/population-size-2007.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2007) %>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2007.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2007.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2007.estimated.population * 100000,
         Robbery.rate = Robbery / X2007.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2007.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2007.estimated.population * 100000,
         Burglary.rate = Burglary / X2007.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2007.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2007.estimated.population * 100000,
         Arson.rate = Arson / X2007.estimated.population * 100000)

population.size.2008 <- read.csv("data/population-size-2008.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2008)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2008.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2008.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2008.estimated.population * 100000,
         Robbery.rate = Robbery / X2008.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2008.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2008.estimated.population * 100000,
         Burglary.rate = Burglary / X2008.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2008.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2008.estimated.population * 100000,
         Arson.rate = Arson / X2008.estimated.population * 100000)

population.size.2009 <- read.csv("data/population-size-2009.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2009)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2009.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2009.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2009.estimated.population * 100000,
         Robbery.rate = Robbery / X2009.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2009.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2009.estimated.population * 100000,
         Burglary.rate = Burglary / X2009.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2009.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2009.estimated.population * 100000,
         Arson.rate = Arson / X2009.estimated.population * 100000)

population.size.2010 <- read.csv("data/population-size-2010.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2010)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2010.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2010.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2010.estimated.population * 100000,
         Robbery.rate = Robbery / X2010.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2010.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2010.estimated.population * 100000,
         Burglary.rate = Burglary / X2010.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2010.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2010.estimated.population * 100000,
         Arson.rate = Arson / X2010.estimated.population * 100000)

population.size.2011 <- read.csv("data/population-size-2011.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2011)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2011.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2011.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2011.estimated.population * 100000,
         Robbery.rate = Robbery / X2011.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2011.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2011.estimated.population * 100000,
         Burglary.rate = Burglary / X2011.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2011.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2011.estimated.population * 100000,
         Arson.rate = Arson / X2011.estimated.population * 100000)

population.size.2012 <- read.csv("data/population-size-2012.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2012)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2012.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2012.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2012.estimated.population * 100000,
         Robbery.rate = Robbery / X2012.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2012.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2012.estimated.population * 100000,
         Burglary.rate = Burglary / X2012.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2012.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2012.estimated.population * 100000,
         Arson.rate = Arson / X2012.estimated.population * 100000)

population.size.2013 <- read.csv("data/population-size-2013.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2013)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2013.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2013.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2013.estimated.population * 100000,
         Robbery.rate = Robbery / X2013.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2013.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2013.estimated.population * 100000,
         Burglary.rate = Burglary / X2013.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2013.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2013.estimated.population * 100000,
         Arson.rate = Arson / X2013.estimated.population * 100000)

population.size.2014 <- read.csv("data/population-size-2014.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2014)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2014.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2014.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2014.estimated.population * 100000,
         Rape.revised.rate = Rape.revised / X2014.estimated.population * 100000,
         Robbery.rate = Robbery / X2014.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2014.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2014.estimated.population * 100000,
         Burglary.rate = Burglary / X2014.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2014.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2014.estimated.population * 100000,
         Arson.rate = Arson / X2014.estimated.population * 100000)

population.size.2015 <- read.csv("data/population-size-2015.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2015)%>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2015.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2015.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2015.estimated.population * 100000,
         Rape.revised.rate = Rape.revised / X2015.estimated.population * 100000,
         Robbery.rate = Robbery / X2015.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2015.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2015.estimated.population * 100000,
         Burglary.rate = Burglary / X2015.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2015.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2015.estimated.population * 100000,
         Arson.rate = Arson / X2015.estimated.population * 100000)

population.size.2016 <- read.csv("data/population-size-2016.csv", stringsAsFactors = FALSE) %>% 
  filter(Year == 2016) %>% 
  slice(4:11) %>% 
  mutate(Violent.crime.rate = Violent.crime / X2016.estimated.population * 100000,
         Murder.and.nonnegligent.manslaughter.rate = Murder.and.nonnegligent.manslaughter / X2016.estimated.population * 100000,
         Forcible.rape.rate = Forcible.rape / X2016.estimated.population * 100000,
         Rape.revised.rate = Rape.revised / X2016.estimated.population * 100000,
         Robbery.rate = Robbery / X2016.estimated.population * 100000,
         Aggravated.assault.rate = Aggravated.assault / X2016.estimated.population * 100000,
         Property.crime.rate = Property.crime / X2016.estimated.population * 100000,
         Burglary.rate = Burglary / X2016.estimated.population * 100000,
         Larceny.theft.rate = Larceny.theft / X2016.estimated.population * 100000,
         Motor.vehicle.theft.rate = Motor.vehicle.theft / X2016.estimated.population * 100000,
         Arson.rate = Arson / X2016.estimated.population * 100000)

population.size <- rbind.fill(population.size.2005, population.size.2006, population.size.2007, population.size.2008, population.size.2009
                      , population.size.2010, population.size.2011, population.size.2012, population.size.2013, population.size.2014
                      , population.size.2015, population.size.2016)
#apply or sapply the slice function 
#rbind(df, df)