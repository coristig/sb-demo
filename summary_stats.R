library(survival)
library(ggplot2)

df <- read.table('users-2015-08-18.csv', sep=',')

df$total.minutes <- df$total.day.minutes + df$total.eve.minutes + df$total.night.minutes + df$total.intl.minutes
df$total.charge <- df$total.day.charge + df$total.eve.charge + df$total.night.charge + df$total.intl.charge

df$avg.lifetime.value <- df$total.charge/df$account.length

p <- ggplot(df, aes(account.length,total.minutes ,colour = Churn))
p + geom_point()

p <- ggplot(df, aes(account.length,1/avg.lifetime.value ,colour = Churn))
p + geom_point()

library(reshape2)
vars <- c('total.day.minutes','total.night.minutes','total.eve.minutes')
df2 <- df[vars]
data<-melt(df2)
p <- ggplot(data,aes(x=value, fill=variable))
p + geom_density(alpha=.25)


s <- with(df, Surv(account.length, as.numeric(Churn)))

model <- coxph(s ~ total.day.charge + number.customer.service.calls, data=df[, -4])
summary(model)
plot(survfit(model), xlab = 'Days since Subscribing', ylab = 'Percent Surviving')

model2 <- coxph(s ~ total.day.charge + strata(number.customer.service.calls <= 3), data=df[, -4])
summary(model2)
plot(survfit(model2), col=c("dark blue", "red"), xlab = 'Days since Subscribing', ylab = 'Percent Surviving')
