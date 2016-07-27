setwd("D:/Elham/ONGOING ISSUES/NAVID/BN")
# Clean Workspace: rm(list = ls())
library (R.matlab)
library(bnlearn)

#column 1 is time in seconds 
#columns 2 to 9 are normalized (0-100% activation) readings from:
#- Col2 : Deltoid Anterior
#- Col3 : Deltoid Medius
#- col4 : Deltoid Posterior
#- Col 5: Biceps
#- Col 6: Triceps Long-head
#- Col 7: Triceps Lateral-head
#- Col 8: Brachioradialis 
#- Col 9: Pectorialis Major
Left <- readMat("Processed_Navid_Left.mat")
Right <- readMat("Processed_Navid_Right.mat")
NewLeft <- data.frame(Left)
NewRight <- data.frame (Right)

Names <- c("time", "DeltoidAnterior", "DeltoidMedius", "DeltoidPosterior",
           "Biceps", "TricepsLonghead", "TricepsLateralhead", 
           "Brachioradialis", "PectorialisMajor")

colnames(NewLeft) <- Names
colnames(NewRight) <- Names
# How to Descretize more wisely (according to histogram)?! USE dedup as well 
d_left = discretize(NewLeft[2:9], method = 'hartemink', breaks = 4, ibreaks = 20)
d_right = discretize(NewRight[2:9], method = 'hartemink', breaks = 4, ibreaks = 20)

bn_left  <- hc(d_left)
bn_right <- hc(d_right) 
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
plot(bn_left, main = "Left")
plot(bn_right, main = "Right")

l1 = AIC(bn_left,NewLeft[2:9] )
l2 = AIC(bn_right, NewRight[2:9])