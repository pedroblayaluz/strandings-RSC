#PLOTS
#STRANDINGS
#Green turtle
cols <- c('Trindade'='black','Ascension'="black","strandings"="darkseagreen4")
line_types <- c("strandings"=1,"Ascension"=2,'Trindade'=NA)
chelonia.strandings.plot <- chelonia.plot.data %>%
  ggplot(aes(x=year,y=n/km)) + geom_point(size=0.5,color='darkseagreen') +
  geom_violin(aes(group = cut_width(year, 1)), scale = "width", alpha=0.3, color='darkseagreen',fill='darkseagreen') +
  stat_summary(aes(linetype='strandings', colour="strandings"),fun=mean, geom="line", size=.5) + 
  geom_line(aes(linetype='Ascension', colour="Ascension",y=Ascension/200000),alpha=0.8)+
  geom_point(aes(linetype='Trindade', colour="Trindade",y=Trindade/20000),shape=6, stat='unique')+
  scale_y_continuous(
    name = "stranded turtles/km surveyed",
    sec.axis = sec_axis(trans=~.*200000, name="")) +
  theme_light() + labs(title="Green turtle", tag='(a)') +
  scale_colour_manual(name=" ",values=cols,
                      guide = guide_legend(override.aes = list(
                        shape = c(NA, NA, 6)))) + 
  scale_linetype_manual(name=' ',values=line_types)+
  theme(plot.tag=element_text(size=10), legend.background = element_blank(),  legend.position = c(0.15,0.9)) +
  coord_cartesian(clip = 'off')

#Loggerhead
cols2 <- c('Brazil'="black","strandings"="darkgoldenrod4","BAR"="#62c76b")
line_types2 <- c("Brazil"=2,"strandings"=1)
caretta.strandings.plot <- caretta.plot.data %>%
  ggplot(aes(x=year,y=n/km)) + geom_point(size=0.5,color='darkgoldenrod') +
  geom_violin(aes(group = cut_width(year, 1)),scale = "width", alpha=0.3, color='darkgoldenrod2',fill='darkgoldenrod2') +
  geom_line(aes(group=1,linetype='Brazil',colour='Brazil',y=Brazil/10000),size=0.5, alpha=0.6)+
  scale_y_continuous(
    name = "stranded turtles/km surveyed",
    sec.axis = sec_axis(trans=~.*10000, name="Brazil\n ")) +
  scale_colour_manual(name=" ",values=cols2, 
                      guide = guide_legend(override.aes=aes(fill=NA))) + 
  scale_linetype_manual(name=' ',values=line_types2)+
  theme_light() + labs(tag='(b)',title="Loggerhead turtle") +
  stat_summary(aes(group=1,linetype='strandings',colour='strandings'), fun=mean, geom="line", size=.5) + theme(plot.tag=element_text(size=10), legend.background = element_blank(),  legend.position = c(0.15,0.9)) +
  coord_cartesian(clip = 'off')

#MODEL EFFECTS
#Function for plotting effets with an offset
effects.offset <- function(model,terms){
  effect <- ggpredict(model,terms=c(terms), condition=c('km'=1))
  plot.effect <- plot(effect)
  return(plot.effect)
}
#Green turtle effects plots
#SST
plot.cm.effects.sst <- effects.offset(cm.strandings.model,'sst')
plot.cm.effects.sst <- plot.cm.effects.sst +
  scale_y_continuous(limits = c(0,0.22),breaks=c(0,0.1,0.2)) +
  scale_x_continuous(breaks=c(15,20),limits=c(11,22)) +
  labs(tag='(c)',title='p<0.001', y='', x=expression(paste(degree~C))) +
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8,colour = "black"))
#Wind
plot.cm.effects.w10 <- effects.offset(cm.strandings.model,'w10')
plot.cm.effects.w10 <- plot.cm.effects.w10 +
  scale_y_continuous(limits = c(0,0.22),breaks=c(0,0.1,0.2)) +
  scale_x_continuous(limits=c(-20,20),breaks=c(-15,0,15)) +
  labs(tag='(d)',title='p<0.001', y='', x='wind') +
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8))
#Ascension
plot.cm.effects.asc <- effects.offset(cm.strandings.model,'Ascension')
plot.cm.effects.asc <- plot.cm.effects.asc +
  scale_y_continuous(limits = c(0,0.22),breaks=c(0,0.1,0.2)) +
  scale_x_continuous(breaks=c(35000,55000,75000)) +
  labs(tag='(e)',title='p=0.009', y='',x='Ascension hatchlings')+
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8))
#Trindade
plot.cm.effects.tri <- effects.offset(cm.strandings.model,'Trindade')
plot.cm.effects.tri <- plot.cm.effects.tri +
  scale_y_continuous(limits = c(0,0.22),breaks=c(0,0.1,0.2)) +
  scale_x_continuous() +
  labs(tag='(f)',title='p=0.09', y='',x='Trindade tracks')+
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8))
#Loggerhead effects plots
#SST
plot.cc.effects.sst <- effects.offset(cc.strandings.model,'sst') +
  scale_y_continuous(limits = c(0,0.2),breaks=c(0,0.1,0.2)) +
  scale_x_continuous(breaks=c(15,20),limits=c(11,22)) +
  labs(tag='(g)',title='p<0.001', y='', x=expression(paste(degree~C))) +
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8))

#Wind
plot.cc.effects.w10 <- effects.offset(cc.strandings.model,'w10')+
  scale_y_continuous(limits = c(0,0.2), breaks=c(0,0.1,0.2)) +
  scale_x_continuous(limits=c(-20,20),breaks=c(-15,0,15)) +
  labs(tag='(h)',title='p<0.001', y='', x='wind') +
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8))

#Brazil
plot.cc.effects.Brazil <- effects.offset(cc.strandings.model,'Brazil') +
  scale_y_continuous(limits = c(0,0.2), breaks=c(0,0.1,0.2)) +
  scale_x_continuous(breaks=c(1000,4000)) +
  labs(tag='(i)',title='p<0.001', y='',x='Brazil Brazil') +
  theme_linedraw() +
  theme(plot.tag=element_text(size=10),
        plot.title = element_text(size=8))

#Title Predictor effects
label.plot <- ggplot() +
  annotate(x=0,y=50,hjust=0,'text',label='Predictors\neffects:') +
  scale_x_continuous(limits = c(0,100)) + scale_y_continuous(limits=c(0,100)) +
  theme_void()

#MODEL EFFECTS
strandings.plot <- ggarrange(ggarrange(chelonia.strandings.plot,caretta.strandings.plot,nrow=2),
                        ggarrange(label.plot,
                                  plot.cm.effects.sst,
                                  plot.cm.effects.w10,
                                  plot.cm.effects.asc,
                                  plot.cm.effects.tri,
                                  ggplot() + theme_void(),
                                  plot.cc.effects.sst,
                                  plot.cc.effects.w10,
                                  plot.cc.effects.Brazil,
                                  ncol=1,
                                  heights=c(1,2,2,2,2,
                                            1,2,2,2)),
                        ggplot() + theme_void(),
                        ncol=3, widths = c(12,2,.5)
                        )

#BODY SIZES
#Green turtle
chelonia.annual.plot <- ggplot(chelonia.sizes, aes(x =ccl, y = as.factor(year), fill=year)) + 
  geom_density_ridges(aes(color=as.factor(year)),
                      point_alpha =.2 , point_size=.5,
                      jittered_points = TRUE, scale=5, alpha=.8)+
  scale_fill_distiller(palette=5, direction=1)+ theme_minimal()+
  theme_minimal() + theme(plot.tag=element_text(size=10)) +
  labs(title="Green turtle", y="", x="cm", tag = '(a)')+
  theme(legend.position="none") + scale_x_continuous(limits=c(25,65)) +
  scale_color_manual(values=c('black','black','black','black','black','black','black','black',
                              'black','black','black','black','black','black','white','black',
                              'black','black','black','black','black','white','white')) +
  annotate(geom='text',x=25,y=22.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=21.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=14.8,label='*', color='red', fontface=2,size=6)

#Loggerhead turtle
#Annual
caretta.annual.plot <- ggplot(caretta.sizes, aes(x = ccl, y = as.factor(year), fill=year)) +
  geom_density_ridges(aes(color=(as.factor(year))),
                      point_alpha =.2 , point_size=.5, jittered_points = TRUE, scale=5, alpha=.8)+
  scale_fill_distiller(palette=7, direction=1)+ theme_minimal()+
  labs(tag='(b)',title="Loggerhead turtle", y="", x="cm")+
  theme(legend.position="none", plot.tag=element_text(size=10))+
  scale_x_continuous(limits=c(25,125)) +
  scale_color_manual(values=c('black','black','black','black','black','black','black','white',
                              'white','white','white','black','black','black','white','white',
                              'white','black','black','black','black','black','black','black')) +
  annotate(geom='text',x=25,y=14.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=15.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=16.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=10.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=9.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=8.8,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=25,y=7.8,label='*', color='red', fontface=2,size=6)
#Monthly
#Green
chelonia.monthly.plot <- ggplot(chelonia.sizes, aes(x=as.factor(month), y=ccl)) +
  geom_sina(size=0.000001, color='darkseagreen4', alpha=0.3) +
  geom_violin(colour="darkseagreen", linetype=1, se=T,
              fill="darkseagreen", draw_quantiles = 0.5,alpha=0.3) +
  geom_smooth(aes(x=month,y=ccl),color='seagreen4') +
  scale_y_continuous(limits=c(25,55))+
  labs(tag='(c)',title="", y="cm", x="month")+
  theme_linedraw() + theme(plot.tag=element_text(size=10)) +
  annotate(geom='text',x=4,y=25,label='*', color='red', fontface=2,size=6) +
  annotate(geom='text',x=5,y=25,label='*', color='red', fontface=2,size=6)
#Loggerhead
caretta.monthly.plot <- ggplot(caretta.sizes, aes(x=as.factor(month), y=ccl)) +
  geom_sina(size=.00001, color='darkgoldenrod', alpha=0.3) +
  geom_violin(colour="darkgoldenrod3", linetype=1, se=T,
              fill="darkgoldenrod2", draw_quantiles = 0.5,alpha=0.3, size=.3) +
  geom_smooth(aes(x=month,y=ccl),color='darkgoldenrod',fill='darkgoldenrod',alpha=0.3) +
  scale_y_continuous(limits=c(45,100))+
  labs(tag='(d)',title="", y="cm", x="month")+
  theme_linedraw() + theme(plot.tag=element_text(size=10)) +
  annotate(geom='text',x=2,y=45,label='*', color='blue', fontface=2,size=6)
#Arranging all plots together
sizes.plot <- ggarrange(nrow=2,heights = c(5,2),
  ggarrange(chelonia.annual.plot,caretta.annual.plot,ncol=2),
  ggarrange(chelonia.monthly.plot,caretta.monthly.plot,ncol=2))

#Removing local objects
rm(label.plot,
   caretta.annual.plot,
   caretta.monthly.plot,
   chelonia.annual.plot,
   chelonia.monthly.plot,
   plot.cm.effects.asc,
   plot.cm.effects.sst,
   plot.cm.effects.tri,
   plot.cm.effects.w10,
   plot.cc.effects.Brazil,
   plot.cc.effects.sst,
   plot.cc.effects.w10,
   cols,cols2,
   line_types,line_types2,
   effects.offset)
