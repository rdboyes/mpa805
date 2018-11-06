#build a model based only on square footage of the first floor

bad_model <- lm(SalePrice ~ X1st.Flr.SF, data = train)

#use this to generate a set of predictions 

submission <- as.data.frame(predict.lm(bad_model, newdata = test))

#add a column with id variables

submission$Id <- seq.int(nrow(submission))

#name the columns

colnames(submission)<- c("Predicted","Id")

#put columns in the right order

submission <- submission %>% select(Id, Predicted)

#write these to a solution file

write.csv(submission, file = "submission.csv", row.names = FALSE)