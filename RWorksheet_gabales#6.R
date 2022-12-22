library(ggplot2)

install.packages("dplyr")
library(dplyr)

#1.How many columns are in mpg dataset? How about the number of rows? Show the
#codes and its result.

data(mpg)
nrow(mpg)
ncol(mpg)
  #There are 11 columns and 234 rows in mpg data set.

#2. Which manufacturer has the most models in this data set? Which model has the most
#variations? Ans:

manu_mpg <- mpg$manufacturer
table(manu_mpg)
    #dodge has the most models and variations in this data set.

#2.a Group the manufacturers and find the unique models. Copy the codes and result.

group_data1 <- mpg

unique_mod <- group_data1 %>% group_by(manufacturer, model) %>%
  distinct() %>% count()
unique_mod

colnames(unique_mod) <- c("Manufacturer", "Model", "Counts")
unique_mod

#2.b Graph the result by using plot() and ggplot(). Write the codes and its result.

qplot(model, data = mpg,geom = "bar", fill=manufacturer)
ggplot(mpg, aes(model, manufacturer)) + geom_point()

#3 Same dataset will be used. You are going to show the relationship of the model and
#the manufacturer.

rs_data <- mpg
models <- rs_data %>% group_by(manufacturer, model) %>%
  distinct() %>% count()
models
colnames(models) <- c("Manufacturer", "Model", "Counts")
models

#3.a What does ggplot(mpg, aes(model, manufacturer)) + geom_point() show?

ggplot(mpg, aes(model, manufacturer)) + geom_point()

#4 Using the pipe (%>%), group the model and get the number of cars per model. Show
#codes and its result.

rs_data2 <- models %>% group_by(Model) %>% count()
colnames(rs_data2) <- c("Model","Counts")
rs_data2

#4.a Plot using the geom_bar() + coord_flip() just like what is shown below. Show
#codes and its result.

qplot(mpg$model, data = mpg,
      main = "Number of Cars per Model",
      xlab = "Model", ylab = "Number of Cars",
      geom = "bar", fill = mpg$manufacturer) + coord_flip()

#4.b Use only the top 20 observations. Show code and results.

data_obsvtn <- subset(mpg[c(1:20),c(1:11)])
manu_obsvtn <- mpg$manufacturer[1:20]
model_obsvtn <- mpg$model[1:20]

qplot(model_obsvtn, data = data_obsvtn, main = "Number of Cars per Model", 
      xlab = "Model",ylab = "Number of Cars", geom = "bar", fill = manu_obsvtn) + coord_flip()


#5. Plot the relationship between cyl - number of cylinders and displ - engine displace-ment using geom_point with aesthetic colour = engine displacement. Title should be
#“Relationship between No. of Cylinders and Engine Displacement”.
#5.a Show the codes and its result.

ggplot(data = mpg , 
       mapping = aes(x = displ, 
                    y = cyl, 
                    main = "Relationship between No. of Cylinders and Engine Displacement")) + 
  geom_point(mapping=aes(colour = "engine displacement")) 

#6. Get the total number of observations for drv - type of drive train (f = front-wheel drive,                                                                      r = rear wheel drive, 4 = 4wd) and class - type of class (Example: suv, 2seater, etc.).
#Plot using the geom_tile() where the number of observations for class be used as a fill for aesthetics.
#6.a Show the codes and its result for the narrative in #6.

mpg %>%
  count(class, drv) %>%
  ggplot(aes(x = class, y = drv)) +
  geom_tile(mapping = aes(fill = n))

#7. Discuss the difference between these codes. Its outputs for each are shown below.

#Code 1
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, colour = "blue"))

#Code 2
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")

#8. Try to run the command ?mpg. What is the result of this command?

?mpg

#8.c. Plot the relationship between displ (engine displacement) and hwy(highway miles per gallon). Mapped it with a continuous variable you have identified in #5-b. What is its
#result? Why it produced such output?

ggplot(mpg, aes(x = displ, y = hwy, colour = cty)) + geom_point()
  
#9. Plot the relationship between displ (engine displacement) and hwy(highway miles per gallon) using geom_point(). Add a trend line over the existing plot using
#geom_smooth() with se = FALSE. Default method is “loess”.

ggplot(data= mpg, mapping = aes(x= displ, y= hwy)) + geom_point(mapping= aes(color= class)) +
  geom_smooth(se= FALSE)

#10.Using the relationship of displ and hwy, add a trend line over existing plot. Set the se = FALSE to
#remove the confidence interval and method = lm to check for linear modeling

ggplot(data= mpg, mapping= aes(x= displ, y= hwy, color= class)) + geom_point() +
  geom_smooth(se= FALSE)