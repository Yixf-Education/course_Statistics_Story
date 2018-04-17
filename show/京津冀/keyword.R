#!/usr/bin/Rscript

library(tidyverse)

data <- read_tsv("keyword.txt")

g <- ggplot(data, aes(x=year, y=number, color=keyword))
g <- g + geom_line() + geom_point()
g <- g + geom_vline(xintercept=1993, color="gray", linetype="dashed")
g <- g + geom_vline(xintercept=2003, color="cyan4", linetype="dashed")
g <- g + geom_vline(xintercept=2013, color="red", linetype="dashed")
g <- g + labs(x="年", y="CNKI中收录的文章数目", colour="关键词: ")
g <- g + theme_grey(base_size=18)
g <- g + theme(legend.position="top")
ggsave("keyword.png", g, width=15)

data2 <- data %>% group_by(keyword) %>% mutate(percent=number/sum(number)*100)
g <- ggplot(data2, aes(x=year, y=percent, color=keyword))
g <- g + geom_line() + geom_point()
g <- g + geom_vline(xintercept=1993, color="gray", linetype="dashed")
g <- g + geom_vline(xintercept=2003, color="cyan4", linetype="dashed")
g <- g + geom_vline(xintercept=2013, color="red", linetype="dashed")
g <- g + labs(x="年", y="CNKI中收录的文章数目百分比", colour="关键词: ")
g <- g + theme_grey(base_size=18)
g <- g + theme(legend.position="top")
ggsave("keyword_percent.png", g, width=15)