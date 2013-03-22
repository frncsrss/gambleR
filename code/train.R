# for the sake of the demo, we assume there is a variable named "class"
# that we want to predict from the rest of the variables of a data frame

# load the data frame to train on
load("data/trainData.rda")


#####################
# learning from trees
#####################
# CART tree
# splitting condition based on deviance statistics
library(tree)
tree.model <- tree(formula=factor(class) ~ ., data=trainData)
save(tree.model, file="models/tree.model.rda")

# CART tree
# splitting condition based on either Gini index (default) or Information Gain
library(rpart)
rpart.model <- rpart(formula=factor(class) ~ ., data=trainData)
save(rpart.model, file="models/rpart.model.rda")
rpart.model.information <- rpart(formula=factor(class) ~ ., data=trainData,
                                 parms=list(split="information"))
save(rpart.model.information, file="models/rpart.model.information.rda")

# conditional inference tree
library(party)
ctree.model <- ctree(formula=factor(class) ~ ., data=trainData)
save(ctree.model, file="models/ctree.model.rda")

# C4.5 tree with Weka's implementation (J4.8)
# first overwrite the default Java heap space
options(java.parameters = "-Xmx4g")
# then load the library and initializes the JVM
library(RWeka)
j48.model <- J48(formula=factor(class) ~ ., data=trainData)
library(rJava)
# serialize the Java reference before saving the R object
.jcache(j48.model$classifier)
save(j48.model, file="models/j48.model.rda")


#######################
# learning from forests
#######################
# random forest
library(randomForest)
rf.model <- randomForest(formula=factor(class) ~ ., data=trainData)
save(rf.model, file="models/rf.model.rda")

# conditional inference forest
library(party)
cforest.model <- cforest(formula=factor(class) ~ ., data=trainData)
save(cforest.model, file="models/cforest.model.rda")
