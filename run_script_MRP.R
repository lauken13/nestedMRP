library(rstan)
library(dplyr)
library(tidyverse)
ideo<-read.csv("../affirmWIdeology.csv")
multinom_ideo<-read.csv("../ideologyMultinomial.csv")
popn_ps<-read.csv("../ps_wUSR.csv")
popn_ps[,c(2:7,9)]<-popn_ps[,c(2:7,9)]+1

data_ls <- list(
  nEffects_z = 7,
  nCellPopulation = nrow(popn_ps),
  indexes_Pop = popn_ps[,c(3,4,6,2,7,5,9)],
  N_Pop = popn_ps$n,
  nCellSample_z = nrow(multinom_ideo),
  nResponse_z = 6,
  response_z  = multinom_ideo[,8:13],
  indexes_z = multinom_ideo[1:7],
  nCellSample = nrow(ideo),
  response = ideo$Success,
  N = ideo$n,
  nGenderCat = 2,
  nEduCat = 4,
  nMarCat = 5,
  nRaceCat = 5,
  nIncCat = 6,
  nAgeCat = 5,
  nUSRCat = 3,
  nideo5_2016 = 6,
  nEffects = 8,
  indexes = ideo[1:8]
)

compiled_model <- stan_model(file = '../MRP.stan')

fit_hier_mnl <- sampling(compiled_model, data = data_ls, iter = 1000)
