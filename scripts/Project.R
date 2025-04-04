# setwd as 'D:/ait 580/Project'
setwd("D:/ait 580/Project")
# Load the data
data <- read.csv("data.csv", header = TRUE, sep = ",")

# Check the data
str(data)
# Check the data
summary(data)
# Check the data
head(data)

#convert data type of Time_Period_Start_Date and Time_Period_End_Date to date
data$Time_Period_Start_Date <- as.Date(data$Time_Period_Start_Date, format = "%Y-%m-%d")
data$Time_Period_End_Date <- as.Date(data$Time_Period_End_Date, format = "%Y-%m-%d")

# access data by group National_Estimate
library(dplyr)
data1 <- data %>% filter(Group == "National_Estimate")
head(data1)

# plot line chart for National_Estimate with shape at the end of the line and fill with indicator and color with state 
library(ggplot2)
library(plotly)
p<-ggplot(data1, aes(x = Time_Period_Start_Date, y = Value, color = Indicator, shape = State)) + 
  geom_line() + 
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  labs(title = "National Estimation", x = "Year", y = "Value", fill = "Indicator") + 
  scale_fill_brewer(palette = "Set1")+theme(legend.position = "bottom")+
  theme(plot.title = element_text(hjust = 0.5))
ggplotly(p)

# access the data of group 'By Education'
data2 <- data %>% filter(Group == "By_Education")
head(data2)



# move title to middle
ggplot(data2, aes(x = Indicator, y = Value, fill = Subgroup)) +
  geom_bar(position = "dodge", stat = "identity") +
  theme(axis.text.x = element_text(vjust = 0.5, hjust=1)) +
  labs(title = "Indicators based on Education", x = "Indicator", y = "Value") +
  guides(fill = guide_legend(title = "Level of education")) + 
  scale_fill_brewer(palette = "Set1") + 
  theme(axis.text.x = element_text(size = 8,hjust = 0.5)) + 
  scale_x_discrete(guide=guide_axis(n.dodge=3)) + 
  theme(plot.title = element_text(hjust = 0.5))




# perform linear regression on the data
model <- lm(Value ~ ., data = data)
summary(model)
#mean squared error
mse <- mean(model$residuals^2)
mse

# RMSE
rmse <- sqrt(mse)
rmse
# mae 
mae <- mean(abs(model$residuals))
mae
#R2 score
R2 <- 1 - mse/var(data$Value)
R2






# plot the residuals
#plot(model, which = 1)

#perform random forest on the data
library(randomForest)
model1 <- randomForest(Value ~ Indicator + State + Time_Period_Start_Date + Time_Period_End_Date, data = data)
summary(model1)

# plot the importance of the variables
varImpPlot(model1)
# make plot better add color and sort
varImpPlot(model1, sort = TRUE, col = "red")

# plot the partial dependence of the variables
library(pdp)
pdp_glm <- partial(model, pred.var = c("Indicator", "State", "Time_Period_Start_Date", "Time_Period_End_Date"))
plot(pdp_glm, "Indicator")
plot(pdp_glm, "State")
plot(pdp_glm, "Time_Period_Start_Date")
plot(pdp_glm, "Time_Period_End_Date")

#craete a new data frame with only the variables that are important
data3 <- data[,c("Indicator", "State", "Time_Period_Start_Date", "Time_Period_End_Date", "Value")]

# randomly split the data into training and testing data
library(caTools)
set.seed(123)
split <- sample.split(data3$Value, SplitRatio = 0.7)
training_set <- subset(data3, split == TRUE)
test_set <- subset(data3, split == FALSE)

# perform linear regression on the training data
model2 <- lm(Value ~Indicator + State + Time_Period_Start_Date + Time_Period_End_Date, data = training_set)
summary(model2)


# predict the test data
y_pred <- predict(model2, newdata = test_set)
y_pred

# calculate the mean squared error
mse <- mean((test_set$Value - y_pred)^2)
mse

# perform random forest on the training data
model3 <- randomForest(Value ~ Indicator + State + Time_Period_Start_Date + Time_Period_End_Date, data = training_set)
summary(model3)

# predict the test data
y_pred1 <- predict(model3, newdata = test_set)
y_pred1

# calculate the mean squared error
mse1 <- mean((test_set$Value - y_pred1)^2)
mse1

# plot the residuals vs fitted values
plot(model2)

#minimum of time_period_start_date and maximum of time_period_end_date
data4 <- data %>% group_by(Indicator, State) %>% summarise(min = min(Time_Period_Start_Date), max = max(Time_Period_End_Date))
head(data4)


# perform label encoding on the column indicator
library(caret)
data5 <- data
data5$Indicator <- as.factor(data5$Indicator)
data5$Indicator <- as.numeric(data5$Indicator)
head(data5)




library(maps)


data <- filter(data, State != "United States")


states_map <- map_data("state") %>%
  rename(State = region) %>%
  mutate(State = tolower(State))

data <- data %>%
  mutate(State = tolower(State))


merged_data <- merge(states_map, data, by = "State")


indicator_data <- filter(merged_data, Indicator == "Needed Counseling or Therapy But Did Not Get It, Last 4 Weeks")


indicator_data$text <- paste(indicator_data$State, "Value:", indicator_data$Value)


ggplot_map <- ggplot(indicator_data, aes(x = long, y = lat, group = group, fill = Value, text = text)) +
  geom_polygon(color = "blue") +
  coord_fixed(1.3) +
  labs(fill = "Value", title = "Needed Counseling or Therapy But Did Not Get It, Last 4 Weeks") +
  theme_minimal()


plotly_map_1 <- ggplotly(ggplot_map, tooltip = "text")


plotly_map_1

indicator_data <- filter(merged_data, Indicator == "Took Prescription Medication for Mental Health, Last 4 Weeks")


indicator_data$text <- paste(indicator_data$State, "Value:", indicator_data$Value)


ggplot_map <- ggplot(indicator_data, aes(x = long, y = lat, group = group, fill = Value, text = text)) +
  geom_polygon(color = "blue") +
  coord_fixed(1.3) +
  labs(fill = "Value", title = "Took Prescription Medication for Mental Health, Last 4 Weeks") +
  theme_minimal()


plotly_map_2 <- ggplotly(ggplot_map, tooltip = "text")


plotly_map_2

indicator_data <- filter(merged_data, Indicator == "Received Counseling or Therapy, Last 4 Weeks")


indicator_data$text <- paste(indicator_data$State, "Value:", indicator_data$Value)


ggplot_map <- ggplot(indicator_data, aes(x = long, y = lat, group = group, fill = Value, text = text)) +
  geom_polygon(color = "blue") +
  coord_fixed(1.3) +
  labs(fill = "Value", title = "Received Counseling or Therapy, Last 4 Weeks") +
  theme_minimal()


plotly_map_3 <- ggplotly(ggplot_map, tooltip = "text")


plotly_map_3

indicator_data <- filter(merged_data, Indicator == "Took Prescription Medication for Mental Health And/Or Received Counseling or Therapy, Last 4 Weeks")


indicator_data$text <- paste(indicator_data$State, "Value:", indicator_data$Value)


ggplot_map <- ggplot(indicator_data, aes(x = long, y = lat, group = group, fill = Value, text = text)) +
  geom_polygon(color = "blue") +
  coord_fixed(1.3) +
  labs(fill = "Value", title = "Took Prescription Medication for Mental Health And/Or Received Counseling or Therapy, Last 4 Weeks") +
  theme_minimal()


plotly_map_4 <- ggplotly(ggplot_map, tooltip = "text")


plotly_map_4


#p<-subplot(plotly_map_1, plotly_map_2, plotly_map_3, plotly_map_4, nrows = 2, shareX = TRUE, shareY = TRUE) %>%
#  layout(title = "Mental Health in the United States", showlegend = FALSE)

# make 4 plot into one plot with 2 rows and 2 columns and share the x and y axis 
#and keep legend for each plot and add title to the plot and for each plot add text to the plot
p<-subplot(plotly_map_1, plotly_map_2, plotly_map_3, plotly_map_4, nrows = 2, shareX = TRUE, shareY = TRUE) %>%
  layout(title = "Mental Health in the United States", showlegend = TRUE, legend = list(x = 0.5, y = 0.5)) %>%
  layout(annotations = list(x = 0.5, y = 1.2, text = "Took Prescription Medication for Mental Health, Last 4 Weeks", showarrow = FALSE, xref = "paper", yref = "paper", xanchor = "center", yanchor = "bottom", font = list(size = 14))) %>%
  layout(annotations = list(x = 0.5, y = 0.5, text = "Received Counseling or Therapy, Last 4 Weeks", showarrow = FALSE, xref = "paper", yref = "paper", xanchor = "center", yanchor = "bottom", font = list(size = 14))) %>%
  layout(annotations = list(x = 0.5, y = -0.2, text = "Took Prescription Medication for Mental Health And/Or Received Counseling or Therapy, Last 4 Weeks", showarrow = FALSE, xref = "paper", yref = "paper", xanchor = "center", yanchor = "bottom", font = list(size = 14))) %>%
  layout(annotations = list(x = 0.5, y = -0.8, text = "Needed Counseling or Therapy But Did Not Get It, Last 4 Weeks", showarrow = FALSE, xref = "paper", yref = "paper", xanchor = "center", yanchor = "bottom", font = list(size = 14)))
p








