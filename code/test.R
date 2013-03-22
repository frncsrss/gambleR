# for the sake of the demo, we assume there is a variable named "class"
# that we want to predict from the rest of the variables of a data frame
# this class can take 3 values 1, 2 and 3 and we are interested in 3

# load the data frame to test on
load("data/testData.rda")


#######################
# prediction from trees
#######################
# CART tree
# splitting condition based on deviance statistics
library(tree)
load("models/tree.model.rda")
# predict a class
tree.pred <- predict(tree.model, testData, type="class")
# confusion matrix
table(testData$class, tree.pred)
# F-measure for class 3
fmeasure(testData$class, tree.pred, class=3)

# CART tree
# splitting condition based on either Gini index (default) or Information Gain
library(rpart)
load("models/rpart.model.rda")
rpart.pred <- predict(rpart.model, testData, type="class")
table(testData$class, rpart.pred)
fmeasure(testData$class, rpart.pred, class=3)

# conditional inference tree
library(party)
load("models/ctree.model.rda")
ctree.pred <- predict(ctree.model, testData, type="response")
table(testData$class, ctree.pred)
fmeasure(testData$class, ctree.pred, class=3)

# C4.5 tree with Weka's implementation (J4.8)
# first overwrite the default Java heap space
options(java.parameters = "-Xmx4g")
# then load the library and initializes the JVM
library(RWeka)
load("models/j48.model.rda")
j48.pred <- predict(j48.model, testData, type="class")
table(testData$class, j48.pred)
fmeasure(testData$class, j48.pred, class=3)
