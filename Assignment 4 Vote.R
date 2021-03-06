setwd("/Users/chicheongweng/Downloads")
gerber = read.csv("gerber.csv")
str(gerber)

table(gerber$voting)

t = table(gerber$voting, gerber$hawthorne == 1)
t[4]/(t[3]+t[4])
t =table(gerber$voting, gerber$civicduty == 1)
t[4]/(t[3]+t[4])
t =table(gerber$voting, gerber$neighbors == 1)
t[4]/(t[3]+t[4])
t= table(gerber$voting, gerber$hawthorne == 1)
t[4]/(t[3]+t[4])

str(gerber)
LogModel = glm(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, family="binomial")
summary(LogModel)

pred = predict(LogModel, type="response")
table(gerber$voting, pred>=0.5)

CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)
CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)

CARTmodel3 = rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data=gerber, cp=0.0)
prp(CARTmodel3)

Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
LmModel = glm(voting ~ control+sex, data=gerber, family="binomial")
LogModelSex = rpart(voting ~ control+sex, data=gerber, cp=0.0)
p1 = predict(LmModel, newdata=Possibilities,type="response")
p2 = predict(LogModelSex, newdata=Possibilities, type="response")

LogModel2 = glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")
summary(LogModel2)

predict(LogModel2, newdata=Possibilities, type="response")
