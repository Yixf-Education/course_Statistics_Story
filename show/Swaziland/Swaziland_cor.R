library(tidyverse)
library(ggpubr)
library(gridExtra)

data <- read_tsv("Swaziland.txt")

data <- data %>% mutate(deathBirth = babyDeath / babyBirth)

p1 <-
  ggscatter(
    data,
    x = "lifeMan",
    y = "lifeWoman",
    add = "reg.line",
    add.params = list(color = "blue", fill = "lightgray"),
    conf.int = TRUE,
    title = "男性与女性出生时预期寿命的相关性",
    xlab = "男性出生时的预期寿命",
    ylab = "女性出生时的预期寿命"
  ) + stat_cor(
    method = "pearson",
    label.x = 50,
    label.y = 60,
    size = 8,
    color = "red"
  )

p2 <-
  ggscatter(
    data,
    x = "lifeMan",
    y = "babyBirth",
    add = "reg.line",
    add.params = list(color = "blue", fill = "lightgray"),
    conf.int = TRUE,
    title = "(男性)出生时预期寿命与出生率的相关性",
    xlab = "男性出生时的预期寿命",
    ylab = "出生率"
  ) + stat_cor(
    method = "pearson",
    label.x = 50,
    label.y = 51,
    size = 8,
    color = "red"
  )

p3 <-
  ggscatter(
    data,
    x = "lifeMan",
    y = "babyDeath",
    add = "reg.line",
    add.params = list(color = "blue", fill = "lightgray"),
    conf.int = TRUE,
    title = "(男性)出生时预期寿命与婴儿死亡率的相关性",
    xlab = "男性出生时的预期寿命",
    ylab = "婴儿死亡率"
  ) + stat_cor(
    method = "pearson",
    label.x = 52,
    label.y = 130,
    size = 8,
    color = "red"
  )

p4 <-
  ggscatter(
    data,
    x = "lifeMan",
    y = "deathBirth",
    add = "reg.line",
    add.params = list(color = "blue", fill = "lightgray"),
    conf.int = TRUE,
    title = "(男性)出生时预期寿命与婴儿死亡率/出生率的相关性",
    xlab = "男性出生时的预期寿命",
    ylab = "婴儿死亡率/出生率"
  ) + stat_cor(
    method = "pearson",
    label.x = 50,
    label.y = 3,
    size = 8,
    color = "red"
  )

png(
  "swaziland_correlation.png",
  width = 2048,
  height = 1024,
  res = 95
)
grid.arrange(p1, p2, p3, p4, ncol = 4)
dev.off()
