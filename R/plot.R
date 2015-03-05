require(graphics)
?plot
plot_csv=read.csv(file = "plot.csv")

# Single Classifier Average Precision
dat <- read.table(text = "Logistic_Regression   BayesNet   Multilayer_Perceptron   J48   
 0.240395504773 0.505756407599 0.365180079865 0.252763272411", header = TRUE)
barplot(as.matrix(dat),main="Single Classifier",
        ylab="Average Precision", col=c("blue"),  ylim=c(0.0,1.0))
text(x = bplt, y = plot_csv$v3, label = plot_csv$v3, pos = 3, cex = 0.8, col = "black")

#Single Classifier Precision Recall
dat <- read.table(text = "Logistic_Regression   BayesNet   Multilayer_Perceptron   J48   
1 0.316  0.114 0.588  0.283
2 0.141 0.894 0.118 0.200", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Single Classifier",
        xlab="Fraud Class",  col=c("red","darkblue"), beside=TRUE, legend = c("Precision","Recall"), ylim=c(0.0,1.0))
text(x = bplt, y = plot_csv$freqs, label = plot_csv$freqs, pos = 3, cex = 0.8, col = "black")

#Ensemble Classifier Average Precision
dat <- read.table(text = "Bagging_J48   Bagging_RandomForest   Bagging_REPTree   Adaboost_J48   
 0.450121147766 0.499858523446 0.47057287667 0.366349346527", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Ensemble Classifier",
        ylab="Average Precision",  ylim=c(0.0,1.0),col=c("blue"),
        names.arg = c("Bagging\nJ48","Bagging\nRandomForest","Bagging\nREPTree","Adaboost\nJ48") )
text(x = bplt, y = plot_csv$v4, label = plot_csv$v4, pos = 3, cex = 0.8, col = "black")

#Ensemble Classifier Precision Recall
dat <- read.table(text = "Bagging_J48   Bagging_RandomForest   Bagging_REPTree   Adaboost_J48   
 0.655 0.846 0.765 0.476
 0.224 0.129 0.153 0.235", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Ensemble Classifier",
              xlab="Fraud Class",  ylim=c(0.0,1.0),col=c("red","darkblue"),legend = c("Precision","Recall"),
              names.arg = c("Bagging\nJ48","Bagging\nRandomForest","Bagging\nREPTree","Adaboost\nJ48") , beside=TRUE)
text(x = bplt, y = plot_csv$v7, label = plot_csv$v7, pos = 3, cex = 0.8, col = "black")


#Ensemble Classifier Average Precision
dat <- read.table(text = "Adaboost_RandomForest Adaboost_REPTree stacking_NB_J48_MLP  Stacking_NB_BJ48_BRF
 0.383562432806 0.36223414556 0.434732263599 0.527972412917", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Ensemble Classifier",
              ylab="Average Precision",  ylim=c(0.0,1.0),col=c("blue"),
              names.arg = c("Adaboost\nRandomForest" ,"Adaboost\nREPTree","Stacking-NB\nJ48-MLP","Stacking-NB\nBJ48-BRF") )
text(x = bplt, y = plot_csv$v5, label = plot_csv$v5, pos = 3, cex = 0.8, col = "black")

#Ensemble Classifier Precision Recall
dat <- read.table(text = "Adaboost_RandomForest Adaboost_REPTree stacking_NB_J48_MLP  Stacking_NB_BJ48_BRF 
 0.625 0.457 0.293 0.365
 0.118 0.247 0.565 0.682", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Ensemble Classifier",
              xlab="Fraud Class",  ylim=c(0.0,1.0),col=c("red","darkblue"),legend = c("Precision","Recall"),
              names.arg = c("Adaboost\nRandomForest" ,"Adaboost\nREPTree","Stacking-NB\nJ48-MLP","Stacking-NB\nBJ48-BRF") , beside=TRUE)
text(x = bplt, y = plot_csv$v8, label = plot_csv$v8, pos = 3, cex = 0.8, col = "black")

#Sampling with Ensemble Classifier
dat <- read.table(text = "Cluster15:85-Bagging-RF   Cluster33:67-Stacking-NB-BJ48-BRF   Cluster50:50-Bagging-RF      
 0.523081930364 0.52842476273 0.533806658287", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Cluster with Ensemble Classifier",
        ylab="Average Precision", ylim=c(0.0,1.0), col=c("blue","red","green"),  
        names.arg = c("Cluster 15:85\nBagging-RF","Cluster 33:67\nStacking-NB-BJ48-BRF","Cluster 50:50\nBagging-RF"))
text(x = bplt, y = plot_csv$v2, label = plot_csv$v2, pos = 3, cex = 0.8, col = "black")

#Sampling with Ensemble Classifier Precision recall
dat <- read.table(text = "Cluster15:85-Bagging-RF   Cluster33:67-Stacking-NB-BJ48-BRF   Cluster50:50-Bagging-RF      
 0.458 0.171 0.125
 0.576 0.882 0.941", header = TRUE)
bplt<-barplot(as.matrix(dat),main="Cluster with Ensemble Classifier",
              xlab="Fraud Class", ylim=c(0.0,1.2), col=c("red","darkblue"),legend = c("Precision","Recall"),beside=TRUE , 
              names.arg = c("Cluster 15:85\nBagging-RF","Cluster 33:67\nStacking-NB-BJ48-BRF","Cluster 50:50\nBagging-RF"))
text(x = bplt, y = plot_csv$v9, label = plot_csv$v9, pos = 3, cex = 0.8, col = "black")


#Sampling with Ensemble Classifier
dat <- read.table(text = "Resampling17:83BaggingREPTree   SMOTE100%StackingNBBJ48BRF   SMOTE500%BaggingJ48
 0.519160030954 0.519574604261 0.441983011655", header = TRUE)
bplt<-barplot(as.matrix(dat),main="SMOTE with Ensemble Classifier",
              ylab="Average Precision", ylim=c(0.0,1.0), col=c("blue","red","green"),  
              names.arg = c("Resampling 17:83\nBagging REPTree","SMOTE 100%\nStacking NB BJ48 BRF","SMOTE 500%\nBagging J48"))
text(x = bplt, y = plot_csv$v6, label = plot_csv$v6, pos = 3, cex = 0.8, col = "black")

#Sampling with Ensemble Classifier Precision recall
dat <- read.table(text = "Resampling17:83BaggingREPTree   SMOTE100%StackingNBBJ48BRF   SMOTE500%BaggingJ48
 0.462 0.371 0.444
 0.565 0.659 0.424", header = TRUE)
bplt<-barplot(as.matrix(dat),main="SMOTE with Ensemble Classifier",
              xlab="Fraud Class", ylim=c(0.0,1.0), col=c("red","darkblue"),legend = c("Precision","Recall"),beside=TRUE , 
              names.arg = c("Resampling 17:83\nBagging REPTree","SMOTE 100%\nStacking NB BJ48 BRF","SMOTE 500%\nBagging J48"))
text(x = bplt, y = plot_csv$v10, label = plot_csv$v10, pos = 3, cex = 0.8, col = "black")




