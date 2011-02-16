library('plyr')
library('ggplot2')
canabalt <- read.csv('/Users/nkodner/Dropbox/development/R/canabalt/data/canabaltdetailedscores.csv',stringsAsFactors=FALSE)
names(canabalt)<-c('score','death','device')

# group on type of death and the device and compute the count, mean, stddev, median, range.
# we'll use this later
bydeathtype<-ddply(canabalt,"death",function(df)c(length(df$score),round(mean(df$score)),round(sd(df$score)),median(df$score),max(df$score),min(df$score),max(df$score)-min(df$score)))
names(bydeathtype) <- c('death','count','mean','stddev','median','max','min','range')

bydevice<-ddply(canabalt,"device",function(df)c(length(df$score),round(mean(df$score)),round(sd(df$score)),median(df$score),max(df$score),min(df$score),max(df$score)-min(df$score)))
names(bydevice) <- c('device','count','mean','stddev','median','max','min','range')

p <- ggplot(canabalt,aes(factor(death),score))
p + geom_boxplot()+coord_flip() + facet_wrap(~ device, ncol=1) + opts(title="Canabalt Scores by method of death by device type")


canabalt_regexp = re.compile(r'I ran (\d{3,7})m before (.*) on my ([^.]+)\.')

# plot the scores
m<-ggplot(canabalt,aes(x=score))
m+geom_histogram(binwidth = 600, aes(y = ..count..,fill = ..count.. )) + geom_density() + opts(title="Canabalt Scores")

# plot the scores by device type
m+geom_histogram(binwidth = 300, aes(y = ..count..,fill = ..count.. )) + geom_density() + facet_wrap(~ device,nrow=1) + opts(title="Canabalt Scores by device type")

# plot the scores by death type
m+geom_histogram(binwidth = 300, aes(y = ..count..,fill = ..count.. )) + geom_density() + facet_wrap(~ death) + opts(title="Canabalt Scores by death type")

# scores by device. show the count
p <- ggplot(canabalt,(aes(y=score,x=device)))
p + geom_jitter(aes(colour=score)) + opts(title="Canabalt Scores by device")

# scores by death. show count
p <- ggplot(canabalt,(aes(y=score,x=death)))
p + geom_jitter(aes(colour=score)) + coord_flip() + opts(title="Canabalt Scores by death type")

# scores by death by device
p <- ggplot(canabalt,(aes(y=score,x=death)))
p + geom_jitter(aes(colour=score,size=1.5)) + facet_wrap(~ device) + coord_flip() + opts(title="Canabalt Scores by method of death by device type")
