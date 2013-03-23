I am involved in a data science project with an online betting company (hence the gambleR project name). I thought I would share the R code I have been writing for prediction models. There is of course no specifics about the data and you can easily reuse all the code.

helper.R
--------
Bunch of functions to compute the precision, recall and f-measure of a vector of predictions compared to the actuals values. Can be restricted to a given class.

Using the ROCR package, it can also compute successive precision/recall values for different cutoffs.

train.R
-------
Examples of how to use trees (CART, C4.5, J4.8, conditional inference), random forests, SVM and Naive Bayes to train classification models.

test.R
------
Examples of how to apply trees (CART, C4.5, J4.8, conditional inference), random forests, SVM and Naive Bayes to predict class or probabilities.
