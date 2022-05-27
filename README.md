---
title: "Final Project Template"
author: Dr. Petersen
output: pdf_document
---

<style type="text/css">
h1.title {
font-size: 40px;
text-align: center;
}
h4.author {
font-size: 40px;
text-align: center;
}
</style>

\newpage

```{r setup, include=FALSE}
library(ggfortify)  
library(alr4)  
library(corrplot)
library(tidyverse)
library(lubridate)
library(gridExtra)
library(leaps)
library(readr)
sz = 16
```

# Abstract

We analyzed death caused by Cardiovascular diseases (CVDs) by finding and fitting a logistic regression model to help predict the likelihood of death of someone with a CVD. We used a dataset on kaggle and assessed two primary questions, which determined the impact of predictors. We found that age, ejection_fraction, serum_creatinine, and time between appointments had the greatest impact in predicting the likelihood of someone with a CVD dying. We also determined that having high blood pressure reduced the likelihood of a death event by a factor of .903 and smoking reduced the likelihood by a factor of .986.

# 1 Problem and Motivation

Cardiovascular diseases (CVDs) are the number 1 cause of death globally accounting for as much as 31% of the deaths in the world.
While most factors can be prevented by addressing behavioral risk factors such as smoking or other lifestyle choices (which impact blood pressure), there are some people with cardiovascular disease or who are at high cardiovascular risk naturally who need early detection and management.


## 1.1 Data Description
Data from kaggle (‘https://www.kaggle.com/andrewmvd/heart-failure-clinical-data’) was originally obtained from medical records released in July 2017 about 299 Pakistani patients. Each row in our data set represents a patient and the following is a description of our variables.

Variable                | Description
----------- | -------------
age                     | The patients age 40-95
anaemia                 | Decrease of red blood cells or hemoglobin (boolean)
creatinine_phosphkinase | Level of the CPK enzyme in the blood (mcg/L)
diabetes                | If the patient has diabetes
ejection_fraction       | Percentage of blood leaving the heart at each contraction
high_blood_pressure     | If the patient has hypertension (boolean)
plateletes              | Platelets in the blood (kiloplatelets/mL)
serum_creatinine        | Level of serum creatinine in the blood (mg/dL)
serum_sodium            | Level of serum sodium in the blood (mEq/L)
sex                     | Woman or man (binary)
smoking                 | If the patient smokes or not (boolean)
time                    | Follow-up period (days)
DEATH_EVENT             | If the patient deceased during the follow-up period (boolean)
                    

## 1.2 Questions of Interest

Question 1: Which predictors from our model are significant in predicting those at risk from CVD?

Question 2: How much impact does smoking and high blood pressure have on increasing the odds of a CVD resulting in a death event?

## 1.3 Regression Methods

For each question of interest listed in Section 2, describe what regression models, techniques, and tools you will use to fully answer it.  These should include any plots you will use for exploratory analysis or diagnostic checks, as well as methods of inference you will use. >

# 2 Analyses, Results, and Interpretation

Conduct the analysis in a logical fashion, including necessary code (and not any superfluous code) and its output.  Give simple interpretations of your findings related to the questions of interest.

```{r, fig.align='center'}
#DATA CLEANING
heart <- read_csv("heart_failure_clinical_records_dataset.csv")
heart
heart$age<- as.integer(heart$age)
heart$anaemia <- factor(heart$anaemia)
heart$sex <- factor(heart$sex)
heart$diabetes <- factor(heart$diabetes)
heart$high_blood_pressure <- factor(heart$high_blood_pressure)
heart$DEATH_EVENT <- factor(heart$DEATH_EVENT, levels = c(0, 1))
heart$DEATH_EVENT
heart$smoking <- factor(heart$smoking)
heart$DEATH_EVENT

#Liner Models
full.lm <- glm(DEATH_EVENT  ~ ., data = heart, family = binomial(link = 'logit'))
summary(full.lm)
vif(full.lm) #variance inflation isn't a problem, so we are going to keep the full model.
full.lm$deviance
sum(residuals(full.lm, type = 'pearson')^2)
```





```{r} 
#finding the most important predictors for predcting in Death Event
bestSub <- regsubsets(DEATH_EVENT ~ . + diabetes:sex, data = heart, nvmax = ncol(heart) - 1)
bestSubSum <- summary(bestSub); bestSubSum$which
plot(bestSub, method = 'bic')
bicBestSub <- glm(DEATH_EVENT ~ age + ejection_fraction + serum_creatinine + time, data = heart, family = binomial(link = 'logit'))

anova(bicBestSub, full.lm, test = "Chisq") #conclude that the reduced model does not contain all predictors that are significant in estimating the likelihood of a death event. The full model gives a better prediction than the reduced model. 

# red.lm1 <- glm(DEATH_EVENT  ~ ejection_fraction + serum_creatinine + time, data = heart, family = binomial(link = 'logit'))
# red.lm2 <- glm(DEATH_EVENT  ~ age + serum_creatinine + time, data = heart, family = binomial(link = 'logit'))
# red.lm3 <- glm(DEATH_EVENT  ~ ejection_fraction + age + time, data = heart, family = binomial(link = 'logit'))
# red.lm4 <- glm(DEATH_EVENT  ~ ejection_fraction + serum_creatinine + age, data = heart, family = binomial(link = 'logit'))
# anova(red.lm1, full.lm, test = "Chisq")
# anova(red.lm2, full.lm, test = "Chisq") 
# anova(red.lm3, full.lm, test = "Chisq")
# anova(red.lm4, full.lm, test = "Chisq")
#1. ejection fraction was most important
#2. time was second
#3. serum_creatinine
#4. Age
```

We found that the four main predictors were age, ejection_fraction, serum_creatinine, and time. However, we also found that these were not the only important predictors in estimating the likelihood of dying.


```{r}
#How much much of an impact does diabetes, sex have on heart disease?
OddsBloodPressure <- exp(full.lm$coefficients[7])
OddsSmoking <- exp(full.lm$coefficients[12])
OddsBloodPressure
OddsSmoking

```

We found that having high blood pressure and being a smoker both actually slightly decreases the likelihood of a CVD patient dying.



# 3 Conclusions

Give additional context to you results and interpretations from Section 5 with respect to the data set and its purpose.  Describe any potential weaknesses in your analysis, and how they may affect the reliability of the results.

## APPENDIX
```{r, include = FALSE, eval =FALSE}
#ScatterPlots
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = age)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = anaemia)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = creatinine_phosphokinase)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = diabetes)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = ejection_fraction)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = high_blood_pressure)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = platelets)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = serum_creatinine)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = serum_sodium)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = sex)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = smoking)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)
ggplot(data = heart, mapping = aes(y =DEATH_EVENT, x = time)) +
  geom_point() +
  geom_jitter(height = 0.1) +  # this is what makes the jitter
  # you can change the height argument to see how it affects the jittering
  theme_bw() +
  theme(axis.title.x = element_text(size = sz),
        axis.title.y = element_text(size = sz),
        axis.text = element_text(size = sz),
        aspect.ratio = 1)

#CHECKING FOR TRANSFORMATIONS
residualMatrix <- residuals(full.lm, type ="partial")

ggplot(mapping = aes(x = heart$age, y = residualMatrix[,1]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
ggplot(mapping = aes(x = heart$creatinine_phosphokinase, y = residualMatrix[,3]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
ggplot(mapping = aes(x = heart$ejection_fraction, y = residualMatrix[,5]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
ggplot(mapping = aes(x = heart$platelets, y = residualMatrix[,7]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
ggplot(mapping = aes(x = heart$serum_creatinine, y = residualMatrix[,8]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
ggplot(mapping = aes(x = heart$serum_sodium, y = residualMatrix[,9]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
ggplot(mapping = aes(x = heart$time, y = residualMatrix[,12]))+
  geom_point()+
  geom_smooth(method = lm, se = FALSE)
```
