data(mtcars)
str(mtcars)

? mtcars
# [, 1]    mpg	 Miles/(US) gallon
# [, 2]	 cyl	 Number of cylinders
# [, 3]	 disp	 Displacement (cu.in.)
# [, 4]	 hp	 Gross horsepower
# [, 5]	 drat	 Rear axle ratio
# [, 6]	 wt	 Weight (lb/1000)
# [, 7]	 qsec	 1/4 mile time
# [, 8]	 vs	 V/S
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
# [,10]	 gear	 Number of forward gears
# [,11]	 carb	 Number of carburetors

# Formulas: 
# Left side represents a variable that we want to make a calculation on 
# Right side represents ono or more variable that we want to group the calculation by.

# Lets see car's horsepower mean by number of cylinders
result <- aggregate (hp ~ cyl, mtcars, mean)
result[order(result$hp, decreasing=TRUE),]

# To group the data by more than one variable, add the additional variable to the right side
# of the formula separating it with a plus sign 

# Lets see car's horsepower mean by number of cylinders and number of carburetours
result <- aggregate (hp ~ cyl + carb, mtcars, mean)
result[order(result$hp, decreasing=TRUE),]

# To aggregate more than one variable, the must be combined using *cbind* on the left side of the formula
result <- aggregate (cbind(hp, qsec) ~ cyl + carb, mtcars, mean)
result[order(result$hp, decreasing=TRUE),]

# Do you need using more than one function? plyr package helper function make it easy.
# each: Combine multiple functions into a single function returning a named vector of outputs
require(plyr)
result <- aggregate (cbind(hp, qsec) ~ cyl + carb, mtcars, each(min,max,mean))
result[order(result$cyl, result$carb, decreasing=TRUE),]
result
