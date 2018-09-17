#!/usr/bin/Rscript

library(tidyverse)

dfa <- data.frame(cutoff=numeric(), result=numeric())
for (cutoff in seq(from=10, to=90, by=10)){
  for (i in 1:10000){
    x <- sample(1:100, size=100)
    x_pass <- x[1:cutoff]
    max_pass <- max(x_pass)
    cutoff1 <- cutoff + 1
    x_keep <- x[cutoff1:100]
    x_select <- head(x_keep[x_keep>max_pass], 1)
    result <- ifelse(length(x_select)==1, x_select, x[100])
    dfa <- bind_rows(dfa, data.frame(cutoff=cutoff, result=result))
  }
}
write_tsv(dfa, "all_results.txt")
g <- ggplot(dfa, aes(x=result)) + geom_density() + facet_grid(rows = vars(cutoff))
ggsave("all_density.png", g, width=15, height=20)
dfam <- dfa %>% group_by(cutoff) %>% summarise(median=median(result), mean=mean(result))
write_tsv(dfam, "all_median.txt")
dfac <- dfa %>% filter(result>=98) %>% group_by(cutoff, result) %>% summarise(number=n()) %>% mutate(percent=number/10000*100)
write_tsv(dfac, "all_number.txt")


dfb <- data.frame(cutoff=numeric(), result=numeric())
for (cutoff in seq(from=30, to=40, by=1)){
  for (i in 1:100000){
    x <- sample(1:100, size=100)
    x_pass <- x[1:cutoff]
    max_pass <- max(x_pass)
    cutoff1 <- cutoff + 1
    x_keep <- x[cutoff1:100]
    x_select <- head(x_keep[x_keep>max_pass], 1)
    result <- ifelse(length(x_select)==1, x_select, x[100])
    dfb <- bind_rows(dfb, data.frame(cutoff=cutoff, result=result))
  }
}
write_tsv(dfb, "refine_results.txt")
g <- ggplot(dfb, aes(x=result)) + geom_density() + facet_grid(rows = vars(cutoff))
ggsave("refine_density.png", g, width=15, height=20)
dfbm <- dfb %>% group_by(cutoff) %>% summarise(median=median(result), mean=mean(result))
write_tsv(dfbm, "refine_median.txt")
dfbc <- dfb %>% filter(result>=98) %>% group_by(cutoff, result) %>% summarise(number=n()) %>% mutate(percent=number/100000*100)
write_tsv(dfbc, "refine_number.txt")
