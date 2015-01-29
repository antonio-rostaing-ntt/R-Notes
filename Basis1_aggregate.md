R Basis
========================================================

# Sample data

R and some packages come with data included.


```r
data()
```

I'll use **mtcars** dataframe. You can see the data's help file typing **? mtcars**.  
The sample is a data frame with 32 observations on 11 variables.  
The Format is:
- [, 1]  mpg         Miles/(US) gallon
- [, 2]	 cyl	 Number of cylinders
- [, 3]	 disp	 Displacement (cu.in.)
- [, 4]	 hp	 Gross horsepower
- [, 5]	 drat	 Rear axle ratio
- [, 6]	 wt	 Weight (lb/1000)
- [, 7]	 qsec	 1/4 mile time
- [, 8]	 vs	 V/S
- [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
- [,10]	 gear	 Number of forward gears
- [,11]	 carb	 Number of carburetors

Load sample data:

```r
data(mtcars)
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

# Aggregation

## data.frame aggregation

Formulas: 
- Left side represents a variable that we want to make a calculation on 
- Right side represents ono or more variable that we want to group the calculation by.


```r
# Lets see car's horsepower mean by number of cylinders
result <- aggregate (hp ~ cyl, mtcars, mean)
result[order(result$hp, decreasing=TRUE),]
```

```
##   cyl        hp
## 3   8 209.21429
## 2   6 122.28571
## 1   4  82.63636
```

To group the data by more than one variable, add the additional variable to the right side of the formula separating it with a plus sign.


```r
# Lets see car's horsepower mean by number of cylinders and number of carburetours
result <- aggregate (hp ~ cyl + carb, mtcars, mean)
result[order(result$hp, decreasing=TRUE),]
```

```
##   cyl carb    hp
## 9   8    8 335.0
## 7   8    4 234.0
## 5   8    3 180.0
## 8   6    6 175.0
## 4   8    2 162.5
## 6   6    4 116.5
## 2   6    1 107.5
## 3   4    2  87.0
## 1   4    1  77.4
```

To aggregate more than one variable, they must be combined using *cbind* on the left side of the formula.

```r
# Add 1/4 mile time mean
result <- aggregate (cbind(hp, qsec) ~ cyl + carb, mtcars, mean)
result[order(result$hp, decreasing=TRUE),]
```

```
##   cyl carb    hp     qsec
## 9   8    8 335.0 14.60000
## 7   8    4 234.0 16.49500
## 5   8    3 180.0 17.66667
## 8   6    6 175.0 15.50000
## 4   8    2 162.5 17.06000
## 6   6    4 116.5 17.67000
## 2   6    1 107.5 19.83000
## 3   4    2  87.0 18.93667
## 1   4    1  77.4 19.37800
```

Do you need using more than one function? **plyr** package helper function make it easy.  
*each*: Combine multiple functions into a single function returning a named vector of outputs.

```r
require(plyr)
```

```
## Loading required package: plyr
```

```r
result <- aggregate (cbind(hp, qsec) ~ cyl + carb, mtcars, each(min,max,mean))
result[order(result$cyl, result$carb, decreasing=TRUE),]
```

```
##   cyl carb hp.min hp.max hp.mean qsec.min qsec.max qsec.mean
## 9   8    8  335.0  335.0   335.0 14.60000 14.60000  14.60000
## 7   8    4  205.0  264.0   234.0 14.50000 17.98000  16.49500
## 5   8    3  180.0  180.0   180.0 17.40000 18.00000  17.66667
## 4   8    2  150.0  175.0   162.5 16.87000 17.30000  17.06000
## 8   6    6  175.0  175.0   175.0 15.50000 15.50000  15.50000
## 6   6    4  110.0  123.0   116.5 16.46000 18.90000  17.67000
## 2   6    1  105.0  110.0   107.5 19.44000 20.22000  19.83000
## 3   4    2   52.0  113.0    87.0 16.70000 22.90000  18.93667
## 1   4    1   65.0   97.0    77.4 18.61000 20.01000  19.37800
```
The result is a named vector of outputs.

```r
str (result)
```

```
## 'data.frame':	9 obs. of  4 variables:
##  $ cyl : num  4 6 4 8 8 6 8 6 8
##  $ carb: num  1 1 2 2 3 4 4 6 8
##  $ hp  : num [1:9, 1:3] 65 105 52 150 180 110 205 175 335 97 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr  "min" "max" "mean"
##  $ qsec: num [1:9, 1:3] 18.6 19.4 16.7 16.9 17.4 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr  "min" "max" "mean"
```

In Our sample, there are two named vectors

```r
# Vector with values for results of functions min,max and mean of the hp column
class(result$hp)
```

```
## [1] "matrix"
```

```r
result$hp
```

```
##       min max  mean
##  [1,]  65  97  77.4
##  [2,] 105 110 107.5
##  [3,]  52 113  87.0
##  [4,] 150 175 162.5
##  [5,] 180 180 180.0
##  [6,] 110 123 116.5
##  [7,] 205 264 234.0
##  [8,] 175 175 175.0
##  [9,] 335 335 335.0
```

```r
# Access min results...
result$hp[,1]
```

```
## [1]  65 105  52 150 180 110 205 175 335
```


```r
# Vector with values for results of functions min,max and mean of the hp column
class(result$qsec)
```

```
## [1] "matrix"
```

```r
result$qsec
```

```
##         min   max     mean
##  [1,] 18.61 20.01 19.37800
##  [2,] 19.44 20.22 19.83000
##  [3,] 16.70 22.90 18.93667
##  [4,] 16.87 17.30 17.06000
##  [5,] 17.40 18.00 17.66667
##  [6,] 16.46 18.90 17.67000
##  [7,] 14.50 17.98 16.49500
##  [8,] 15.50 15.50 15.50000
##  [9,] 14.60 14.60 14.60000
```

```r
# Access min results...
result$qsec[,1]
```

```
## [1] 18.61 19.44 16.70 16.87 17.40 16.46 14.50 15.50 14.60
```


