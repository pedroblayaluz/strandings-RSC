#Supplementary material
#Directories
#Tables summarising data
#Body sizes
cm.table <- surveys %>% filter(spp %in% 'Chelonia mydas') %>%
  group_by(year) %>% summarise(Mean=mean(ccl, na.rm=T),
                               SD=sd(ccl,na.rm=T),
                               Min=min(ccl,na.rm=T),
                               Max=max(ccl,na.rm=T)) %>%
  round(digits = 2)
cc.table <- surveys %>% filter(spp %in% 'Caretta caretta') %>%
  group_by(year) %>% summarise(Mean=mean(ccl, na.rm=T),
                               SD=sd(ccl,na.rm=T),
                               Min=min(ccl,na.rm=T),
                               Max=max(ccl,na.rm=T)) %>%
  round(digits=2)
#Strandings
cm.table <- cbind(cm.table,
                  (chelonia %>% 
                     group_by(year) %>% 
                     summarise(Strandings=sum(n)) )[,-1])
cc.table <- cbind(cc.table,
                  (caretta %>% 
                     group_by(year) %>% 
                     summarise(Strandings=sum(n)) )
                  [,-1])
lastlinecm <- cbind('total',
                    surveys %>% filter(spp %in% 'Chelonia mydas') %>%
                      summarise(mean(ccl, na.rm=T),
                                sd(ccl,na.rm=T),
                                min(ccl,na.rm=T),
                                max(ccl,na.rm=T)
                      ),
                    sum(chelonia$n))
lastlinecc <- cbind('total',
                    surveys %>% filter(spp %in% 'Caretta caretta') %>%
                      summarise(mean(ccl, na.rm=T),
                                sd(ccl,na.rm=T),
                                min(ccl,na.rm=T),
                                max(ccl,na.rm=T)
                      ),sum(caretta$n))
names(lastlinecm) <- names(cm.table) 
names(lastlinecc) <- names(cc.table) 
lastlinecc[2:3] <- round(lastlinecc[2:3],digits=2)
lastlinecm[2:3] <- round(lastlinecm[2:3],digits=2)
cm.table <- rbind(cm.table,lastlinecm)
cc.table <- rbind(cc.table,lastlinecc)
complete.table <- cbind(cm.table[,c(1,6,2:5)],cc.table[,c(6,2:5)])
complete.table <- rbind(names(complete.table),complete.table)
names(complete.table) <- c(' ','Green turtle',' ',' ',' ',' ',
                           'Loggerhead',' ',' ',' ',' ')
complete.table
#Writing files
cm.table
write.csv(complete.table,paste0(dir.sup,'complete_table.csv'))
#Plots
#Monthly variation
#Green turtle
monthchelonia <- chelonia.plot.data %>%
  ggplot(aes(x=month,y=n/km)) + geom_jitter(size=0.5,color='darkseagreen3') +
  geom_smooth(color='seagreen4', fill='seagreen3', alpha=0.5, size=0.5,
              method='gam') +
  labs(title='Green turtle',  x='month',
       y='stranded turtles/km surveyed', tag='(a)') +
  scale_y_continuous(limits=c(0,0.7)) +
  scale_x_continuous(breaks=c(1:12))  +
  theme_linedraw() + theme(title = element_text(size=8))
#MLoggehead turtle
monthcaretta <- caretta.plot.data %>%
  ggplot(aes(x=month,y=n/km)) + geom_jitter(size=0.5,alpha=0.5,color='darkgoldenrod') +
  geom_smooth(color='darkgoldenrod3', fill='darkgoldenrod2',
              alpha=0.3, size=0.5, method='gam') +
  labs(title='Loggerhead turtle', x='month', y=' ', tag='(b)') +
  scale_y_continuous(limits=c(0,0.7)) +
  scale_x_continuous(breaks=c(1:12)) +
  theme_linedraw() + theme(title = element_text(size=8))
#Both
monthly.strandings <- ggarrange(monthchelonia,monthcaretta)

#Covariates distribution
wind$date <- as.Date(paste(wind$day,wind$month,wind$year,
                           sep='-'), format="%d-%m-%Y")
##Wind whole study period
winds.date <- wind %>%
  filter(year >= 1996) %>%
  ggplot(aes(x=date,y=w10)) + geom_jitter(aes(color=w10),size=.1, alpha=0.5) +
  geom_smooth(color='black', size=.5) +
  scale_colour_gradient(low = "light blue",  high = "dark blue", name='(w)')+
  labs(title='Frontal winds variation in the whole study period', y='(w)',
       tag='(a)', x='') +
  scale_x_date() +
  theme_linedraw() + theme(legend.position = "none",
                           title = element_text(size=9)) 
#Wind monthly variation
winds.month <- wind %>%
  filter(year >= 1996) %>%
  ggplot(aes(x=month,y=w10)) + geom_jitter(aes(color=w10),size=.1, alpha=0.5) +
  scale_colour_gradient(low = "light blue", high = "dark blue", name='(w)')+
  geom_smooth(color='black', size=.5) +
  labs(title='Monthly wind variation', y='(w)', tag='(b)') +
  scale_x_continuous(breaks=c(1:12))+
  theme_linedraw() + theme(legend.position = "none",
                           title = element_text(size=9))

#Temperature monthly variation
temperature.month <- temperature %>%
  filter(year >= 1996) %>%
  ggplot(aes(x=month,y=sst)) + geom_jitter(aes(color=sst),size=1, alpha=0.5) +
  scale_color_viridis_c(option='plasma',name=expression(paste(degree~C)))+
  geom_smooth(color='dark gray', size=.5, alpha=0.1) +
  labs(title='Monthly temperature variation', y=expression(paste(degree~C)),
       tag='(c)') +
  scale_x_continuous(breaks=c(1:12))+
  theme_linedraw() + theme(legend.position = "none",
                           title = element_text(size=9))
covariates <- ggarrange(winds.date,
                        ggarrange(winds.month,temperature.month),
                        nrow=2)
