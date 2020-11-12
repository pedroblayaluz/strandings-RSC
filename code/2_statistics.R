#STATISTICAL MODELLING

#STRANDINGS
#Green turtle model model infos
message(bgBlack$white('strandings model sample sizes and timespans'))
message(green(sum(chelonia.strandings$n)), green(' green turtles'))
message(green(unique(chelonia.strandings$year), collapse=', '))
#Loggerhead turtle model infos
message(yellow(sum(caretta.strandings$n)),' loggerhead turtles')
message(yellow(min(caretta.strandings$year), max(caretta.strandings$year),
               sep='-'))


#Distribution of variable n (best fit = negative binomial)
#Loggerhead turtle
fit.list <- list(fitdist(caretta.strandings$n,"norm"),
                 fitdist(caretta.strandings$n,"pois"),
                 fitdist(caretta.strandings$n,"nbinom"))
par(mfrow = c(2, 2))
denscomp(fit.list)
qqcomp(fit.list)
ppcomp(fit.list)
cdfcomp(fit.list)
#Green turtle
fit.list <- list(fitdist(chelonia.strandings$n,"norm"),
                 fitdist(chelonia.strandings$n,"pois"),
                 fitdist(chelonia.strandings$n,"nbinom"))
denscomp(fit.list)
qqcomp(fit.list)
ppcomp(fit.list)
cdfcomp(fit.list)
chelonia.strandings
#Green
cm.strandings.model <- glm.nb(n~offset(log(km))+sst+w10+Ascension,data=chelonia.strandings)
summary(cm.strandings.model)
#Loggerhead
cc.strandings.model <- glm.nb(n~offset(log(km))+sst+w10+Brazil,data=caretta.strandings)
summary(cc.strandings.model)

#BODY SIZES
#Model data timespan and N
unique(chelonia.sizes$year)
unique(caretta.sizes$year)
dim(chelonia.sizes)[1]
dim(caretta.sizes)[1]
#Green Turtle
cm.sizes.model <- lm(ccl~as.factor(year)+as.factor(month), data=chelonia.sizes)
summary(cm.sizes.model)
#Loggerhead turtle
cc.sizes.model <- lm(ccl~as.factor(year)+as.factor(month), data=caretta.sizes)
summary(cc.sizes.model)
