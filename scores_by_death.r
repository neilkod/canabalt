library('plyr')
library('ggplot2')
canabalt <- read.csv('/Users/nkodner/Dropbox/development/R/canabalt/data/canabaltdetailedscores.csv',stringsAsFactors=FALSE)
names(canabalt)<-c('score','death','device')

# group on type of death and compute the count, mean, stddev, median, range.
# we'll use this later
grpd<-ddply(canabalt,"death",function(df)c(length(df$score),round(mean(df$score)),round(sd(df$score)),median(df$score),max(df$score),min(df$score),max(df$score)-min(df$score)))
names(grpd) <- c('death','count','mean','stddev','median','max','min','range')

p <- ggplot(canabalt,aes(factor(death),score))
p + geom_boxplot()+coord_flip() + facet_wrap(~ device, ncol=1)
