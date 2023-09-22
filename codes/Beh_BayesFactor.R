#_NPcomparison.R_############################################
#_compare NP measures between groups_########################
#############################################################

#clear workspace####
rm(list=ls())

#package loading function####
load.packages <- function(package.list){ 
new.packages <- package.list[!(package.list %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
for (i in 1:length(package.list)){
library(package.list[i],character.only=TRUE)
}
}

#load packages, install if needed
package.list <- c("effectsize","BayesFactor")
load.packages(package.list)

# learning profile
data<-read.csv("learningprofile_data_IES.csv")
data$ID <- factor(data$ID)
data$day <- factor(data$day)
data$group <- factor(data$group) # 1 is ASD and 2 is TD
#session by group repeated ANOVA ####
bf = anovaBF(IEF ~ day*group + ID, data = data, whichRandom="ID")
bf # main effect
bf[4]/bf[3] # interaction
# one-way repeated ANOVA ASD
bf = anovaBF(EF ~ day + ID, data = data[data$group=='1',], whichRandom="ID")
bf
# one-way repeated ANOVA TD
bf = anovaBF(EF ~ day + ID, data = data[data$group=='2',], whichRandom="ID")
bf
# two sample ttest on learning rate
data<-read.csv("whizz_beh_data.csv")
bf = ttestBF(x = data$LearningRate[data$group=='1'], y = data$LearningRate[data$group=='2'], paired=FALSE)
bf
# two sample ttest on each day
bf = ttestBF(x = data$LearningProfileDay1[data$group=='1'], y = data$LearningProfileDay1[data$group=='2'], paired=FALSE)
bf
bf = ttestBF(x = data$LearningProfileDay2[data$group=='1'], y = data$LearningProfileDay2[data$group=='2'], paired=FALSE)
bf
bf = ttestBF(x = data$LearningProfileDay3[data$group=='1'], y = data$LearningProfileDay3[data$group=='2'], paired=FALSE)
bf
bf = ttestBF(x = data$LearningProfileDay4[data$group=='1'], y = data$LearningProfileDay4[data$group=='2'], paired=FALSE)
bf
bf = ttestBF(x = data$LearningProfileDay5[data$group=='1'], y = data$LearningProfileDay5[data$group=='2'], paired=FALSE)
bf



# math verification
data<-read.csv("mathverification_data_train.csv")
data$ID <- factor(data$ID)
data$time <- factor(data$time) # 1 is pre and 2 is post
data$group <- factor(data$group) # 1 is ASD and 2 is TD
#session by group repeated ANOVA ####
bf = anovaBF(ACC ~ time*group + ID, data = data, whichRandom="ID")
bf # main effect
bf[4]/bf[3] # interaction
# two sample ttest in each group
bf = ttestBF(x = data$ACC[data$group=='2' & data$time=='1'], y = data$ACC[data$group=='2' & data$time=='2'], paired=TRUE)
bf
bf = ttestBF(x = data$ACC[data$group=='1' & data$time=='1'], y = data$ACC[data$group=='1' & data$time=='2'], paired=TRUE)
bf
# two sample ttest on group difference in each time point 
bf = ttestBF(x = data$ACC[data$group=='1' & data$time=='1'], y = data$ACC[data$group=='2' & data$time=='1'], paired=FALSE)
bf
bf = ttestBF(x = data$ACC[data$group=='1' & data$time=='2'], y = data$ACC[data$group=='2' & data$time=='2'], paired=FALSE)
bf
# two sample ttest on acc gains
data<-read.csv("whizz_beh_data.csv")
bf = ttestBF(x = data$AccGainTrain[data$group=='1'], y = data$AccGainTrain[data$group=='2'], paired=FALSE)
bf
# control analysis Untrain problem
#session by group repeated ANOVA ####
data<-read.csv("mathverification_data_untrain.csv")
data$ID <- factor(data$ID)
data$time <- factor(data$time) # 1 is pre and 2 is post
data$group <- factor(data$group) # 1 is ASD and 2 is TD
bf = anovaBF(ACC ~ time*group + ID, data = data, whichRandom="ID")
bf # main effect
bf[4]/bf[3] # interaction
# two sample ttest in each group
bf = ttestBF(x = data$ACC[data$group=='2' & data$time=='1'], y = data$ACC[data$group=='2' & data$time=='2'], paired=TRUE)
bf
bf = ttestBF(x = data$ACC[data$group=='1' & data$time=='1'], y = data$ACC[data$group=='1' & data$time=='2'], paired=TRUE)
bf
# two sample ttest on group difference in each time point 
bf = ttestBF(x = data$ACC[data$group=='1' & data$time=='1'], y = data$ACC[data$group=='2' & data$time=='1'], paired=FALSE)
bf
bf = ttestBF(x = data$ACC[data$group=='1' & data$time=='2'], y = data$ACC[data$group=='2' & data$time=='2'], paired=FALSE)
bf

data<-read.csv("whizz_beh_data.csv")
bf = ttestBF(x = data$AccGainUntrain[data$group=='1'], y = data$AccGainUntrain[data$group=='2'], paired=FALSE)
bf

# math production
data<-read.csv("mathproduction_data_train.csv")
data$ID <- factor(data$ID)
data$time <- factor(data$time) # 1 is pre and 2 is post
data$group <- factor(data$group) # 1 is ASD and 2 is TD
#session by group repeated ANOVA ####
bf = anovaBF(RT ~ time*group + ID, data = data, whichRandom="ID")
bf # main effect
bf[4]/bf[3] # interaction
# two sample ttest in each group
bf = ttestBF(x = data$RT[data$group=='1' & data$time=='1'], y = data$RT[data$group=='1' & data$time=='2'], paired=TRUE)
bf
bf = ttestBF(x = data$RT[data$group=='2' & data$time=='1'], y = data$RT[data$group=='2' & data$time=='2'], paired=TRUE)
bf
bf = ttestBF(x = data$RT[data$group=='1' & data$time=='1'], y = data$RT[data$group=='2' & data$time=='1'], paired=FALSE)
bf
bf = ttestBF(x = data$RT[data$group=='1' & data$time=='2'], y = data$RT[data$group=='2' & data$time=='2'], paired=FALSE)
bf
# two sample ttest on RT gains
data<-read.csv("whizz_beh_data.csv")
bf = ttestBF(x = data$RTGainTrain[data$group=='1'], y = data$RTGainTrain[data$group=='2'], paired=FALSE)
bf
# control analysis Untrain problem
#session by group repeated ANOVA ####
data<-read.csv("mathproduction_data_untrain.csv")
data$ID <- factor(data$ID)
data$time <- factor(data$time) # 1 is pre and 2 is post
data$group <- factor(data$group) # 1 is ASD and 2 is TD
bf = anovaBF(RT ~ time*group + ID, data = data, whichRandom="ID")
bf # main effect
bf[4]/bf[3] # interaction
bf = ttestBF(x = data$RT[data$group=='1' & data$time=='1'], y = data$RT[data$group=='1' & data$time=='2'], paired=TRUE)
bf
bf = ttestBF(x = data$RT[data$group=='2' & data$time=='1'], y = data$RT[data$group=='2' & data$time=='2'], paired=TRUE)
bf
bf = ttestBF(x = data$RT[data$group=='1' & data$time=='1'], y = data$RT[data$group=='2' & data$time=='1'], paired=FALSE)
bf
bf = ttestBF(x = data$RT[data$group=='1' & data$time=='2'], y = data$RT[data$group=='2' & data$time=='2'], paired=FALSE)
bf
data<-read.csv("whizz_beh_data.csv")
bf = ttestBF(x = data$RTGainUntrain[data$group=='1'], y = data$RTGainUntrain[data$group=='2'], paired=FALSE)
bf

# stratgy 
# data<-read.csv("strategy_data_train_pre.csv")
A <- c(rep("procedure",29),rep("retrieval",4),rep("procedure",23),rep("retrieval",5))
B <- c(rep("ASD",33),rep("TD",28)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 

# data<-read.csv("strategy_data_train_post.csv")
A <- c(rep("procedure",16),rep("retrieval",17),rep("procedure",6),rep("retrieval",22))
B <- c(rep("ASD",33),rep("TD",28)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 

# data<-read.csv("strategy_data_untrain_pre.csv")
A <- c(rep("procedure",29),rep("retrieval",4),rep("procedure",25),rep("retrieval",3))
B <- c(rep("ASD",33),rep("TD",28)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 

# data<-read.csv("strategy_data_untrain_post.csv")
A <- c(rep("procedure",22),rep("retrieval",11),rep("procedure",16),rep("retrieval",12))
B <- c(rep("ASD",33),rep("TD",28)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 

# pre
# ASD
A <- c(rep("procedure",29),rep("retrieval",4),rep("procedure",29),rep("retrieval",4))
B <- c(rep("Trained",33),rep("Untrained",33)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 
# TD
A <- c(rep("procedure",23),rep("retrieval",5),rep("procedure",25),rep("retrieval",3))
B <- c(rep("Trained",28),rep("Untrained",28)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 

# post
# TD
A <- c(rep("procedure",6),rep("retrieval",22),rep("procedure",16),rep("retrieval",12))
B <- c(rep("Trained",28),rep("Untrained",28)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 
# ASD
A <- c(rep("procedure",16),rep("retrieval",17),rep("procedure",22),rep("retrieval",11))
B <- c(rep("Trained",33),rep("Untrained",33)) 
mytable <- table(B,A) # 
mytable # 
bf = contingencyTableBF(mytable, sampleType = "indepMulti", fixedMargin = "cols")
bf 
