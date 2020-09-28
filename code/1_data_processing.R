#DATA PROCESSING

#Calling survey and effort date
surveys <- read.csv(paste0(dir.data,'surveysfinal.csv'), header=T)
efforts <- read.csv(paste0(dir.data,'efforts.csv'), header=T)
efforts <- efforts %>% filter(year>=1996)
surveys <- surveys %>% filter(year>=1996)

#Getting name right
surveys$spp[which(surveys$spp==' Chelonia mydas ')] <- 'Chelonia mydas'
surveys <- droplevels(surveys)
surveys <- surveys[-which.max(surveys$ccl),]
#Adjusting date to the right format
surveys$date <- as.Date(paste(surveys$day,surveys$month,surveys$year,
                              sep='-'), format="%d-%m-%Y")
efforts$date <- as.Date(paste(efforts$day,efforts$month,efforts$year,
                              sep='-'), format="%d-%m-%Y")
#Counting turtles per survey
counts <- surveys %>%
  group_by(date,area,spp) %>%
  tally()

#One data.frame for each species
chelonia <- subset(counts, spp=="Chelonia mydas")
caretta <- subset(counts, spp=="Caretta caretta")

#Merging turtle counts and efforts
chelonia <- merge(chelonia,efforts,by=c("date","area"),all.y=T)
caretta <- merge(caretta,efforts,by=c("date","area"),all.y=T)
#Days with no turtles:
chelonia$n[is.na(chelonia$n)] <- 0 #days with no turtles
caretta$n[is.na(caretta$n)] <- 0   #days with no turtles

#Removing spp row
chelonia <- chelonia[,-3]
caretta <- caretta[,-3]

#Beach surveys sampling summary
message(bgBlack$white(dim(efforts)[1],' beach surveys: ',
                      (efforts %>% group_by(area) %>% tally())[1,2], ' ',
                      (efforts %>% group_by(area) %>% tally())[1,1], ' | ',
                      (efforts %>% group_by(area) %>% tally())[2,2], ' ',
                      (efforts %>% group_by(area) %>% tally())[2,1], ' '))
message(bgBlack$white(sum(efforts$km),'kms covered'))
message(green(sum(chelonia$n),' green turtles stranded'))
message(green(dim(surveys %>% filter(spp %in% 'Chelonia mydas') %>% 
                    filter(!ccl %in% !NA))[1], ' green turtle CCLs'))
message(sum(caretta$n),' loggerhead turtles stranded')
message(dim(surveys %>% filter(spp %in% 'Caretta caretta') %>%
              filter(!ccl %in% !NA))[1], ' loggerhead CCLs')


#Including environmental variables
#Wind
wind <- read.csv(paste0(dir.data,'wind10days.csv'), header=T)[,-1]
chelonia.strandings <- merge(chelonia, wind, by=c('day', 'month', 'year'))
caretta.strandings <- merge(caretta, wind, by=c('day', 'month', 'year'))
#Temperature
temperature <- read.csv(paste0(dir.data,'temperature.csv'), header=T)[,-1]
chelonia.strandings <- merge(chelonia.strandings, temperature, by=c('month', 'year'))
caretta.strandings <- merge(caretta.strandings, temperature, by=c('month', 'year'))

#Green turtle
#Include reproductive data
ascension <- read.csv(paste0(dir.data,'ascension.csv'))
trindade <- read.csv(paste0(dir.data,'trindade.csv'))[,-1]
#Rename
names(ascension) <- c('year','Ascension')
names(trindade) <- c('year','Trindade')
#Add 5 year delay (mean age of turtles found stranded)
ascension$year <- ascension$year+5
trindade$year <- trindade$year+5
#Data for plots
chelonia.plot.data <- merge(chelonia.strandings,ascension, by='year', all.x = T)
chelonia.plot.data <- merge(chelonia.plot.data,trindade, by='year', all.x=T)
#Data for models
chelonia.strandings <- merge(chelonia.strandings,ascension, by='year')
chelonia.strandings <- merge(chelonia.strandings,trindade,by='year')
chelonia.strandings <- chelonia.strandings[-which(is.na(chelonia.strandings$Trindade)),] #Removing NAs

#Loggerhead turtle
brazil <- read.csv(paste0(dir.data,'brazil.csv'))
brazil <- brazil[,c(5,4)]
#Add 15 year delay (mean age of turtles found stranded)
brazil$year <- brazil$year+15
brazil <- rename(brazil,Brazil='nests')

#Data for plots
caretta.plot.data <- merge(caretta.strandings,brazil, by='year', all.x = T)
#Data for models
caretta.strandings <- merge(caretta.strandings,brazil, by='year')
#BODY SIZES
caretta.sizes <- (surveys %>% filter (!ccl %in% NA) %>%
                 filter(spp %in% 'Caretta caretta'))[,c('month','year','ccl')]
chelonia.sizes <- (surveys %>% filter (!ccl %in% NA) %>%
            filter(spp %in% 'Chelonia mydas'))[,c('month','year','ccl')]
