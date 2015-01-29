R Basis. Package data.table
========================================================

- Speed improvement
- Extends and enhances the functionality of data.frame
- Different syntax from data.frame

# Sample data

R and some packages come with sample data included.


```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
# Use data() to discover available data sets in each package
data()
```

I'll use **movies** dataframe included in **ggplot2** package. 
You can see the data's help file typing *? movies*.  
The sample is a data frame with 28819 rows and 24 variables.  
The columns are:
- title. Title of the movie.
- year. Year of release.
- budget. Total budget (if known) in US dollars
- length. Length in minutes.
- rating. Average IMDB user rating.
- votes. Number of IMDB users who rated this movie.
- r1-10. Multiplying by ten gives percentile (to nearest 10%) of users who rated this movie a 1.
- mpaa. MPAA rating.
- action, animation, comedy, drama, documentary, romance, short. Binary variables representing if movie was classified as belonging to that genre.

Load sample data:

```r
data(movies)
head(movies, 5)
```

```
##                      title year length budget rating votes   r1   r2  r3
## 1                        $ 1971    121     NA    6.4   348  4.5  4.5 4.5
## 2        $1000 a Touchdown 1939     71     NA    6.0    20  0.0 14.5 4.5
## 3   $21 a Day Once a Month 1941      7     NA    8.2     5  0.0  0.0 0.0
## 4                  $40,000 1996     70     NA    8.2     6 14.5  0.0 0.0
## 5 $50,000 Climax Show, The 1975     71     NA    3.4    17 24.5  4.5 0.0
##     r4   r5   r6   r7   r8   r9  r10 mpaa Action Animation Comedy Drama
## 1  4.5 14.5 24.5 24.5 14.5  4.5  4.5           0         0      1     1
## 2 24.5 14.5 14.5 14.5  4.5  4.5 14.5           0         0      1     0
## 3  0.0  0.0 24.5  0.0 44.5 24.5 24.5           0         1      0     0
## 4  0.0  0.0  0.0  0.0  0.0 34.5 45.5           0         0      1     0
## 5 14.5 14.5  4.5  0.0  0.0  0.0 24.5           0         0      0     0
##   Documentary Romance Short
## 1           0       0     0
## 2           0       0     0
## 3           0       0     1
## 4           0       0     0
## 5           0       0     0
```

You can see *data.table* use samples with *example* command.

```r
require(data.table)
```

```
## Loading required package: data.table
```

```r
example(data.table)
```

# Creating data.table

Creating *data.table* is like creating data.frames.

```r
require(data.table)
DF = data.frame(x=rep(c("a","b","c"),each=3), y=c(1,3,6), v=1:9)
DT = data.table(x=rep(c("a","b","c"),each=3), y=c(1,3,6), v=1:9)
DF
DT
```

```
##   x y v
## 1 a 1 1
## 2 a 3 2
## 3 a 6 3
## 4 b 1 4
## 5 b 3 5
## 6 b 6 6
## 7 c 1 7
## 8 c 3 8
## 9 c 6 9
##    x y v
## 1: a 1 1
## 2: a 3 2
## 3: a 6 3
## 4: b 1 4
## 5: b 3 5
## 6: b 6 6
## 7: c 1 7
## 8: c 3 8
## 9: c 6 9
```
By default *data.frame* turns characters data into factors, **while data.frame does not**

```r
str(DF)
str(DT)
```

```
## 'data.frame':	9 obs. of  3 variables:
##  $ x: Factor w/ 3 levels "a","b","c": 1 1 1 2 2 2 3 3 3
##  $ y: num  1 3 6 1 3 6 1 3 6
##  $ v: int  1 2 3 4 5 6 7 8 9
## Classes 'data.table' and 'data.frame':	9 obs. of  3 variables:
##  $ x: chr  "a" "a" "a" "b" ...
##  $ y: num  1 3 6 1 3 6 1 3 6
##  $ v: int  1 2 3 4 5 6 7 8 9
##  - attr(*, ".internal.selfref")=<externalptr>
```

It is also possible to create a *data.table* out of an existing *data.frame*.

```r
DF2 <- data.table(DF)
DF2
rm(DF2)
```

```
##    x y v
## 1: a 1 1
## 2: a 3 2
## 3: a 6 3
## 4: b 1 4
## 5: b 3 5
## 6: b 6 6
## 7: c 1 7
## 8: c 3 8
## 9: c 6 9
```

Lets load *movies* *data.frame* into a *data.table*

```r
# Create data.table
moviesdt <- data.table(movies)

# Printing data.table just prints the first five and last five rows.
moviesdt
```

```
##                           title year length   budget rating votes   r1
##     1:                        $ 1971    121       NA    6.4   348  4.5
##     2:        $1000 a Touchdown 1939     71       NA    6.0    20  0.0
##     3:   $21 a Day Once a Month 1941      7       NA    8.2     5  0.0
##     4:                  $40,000 1996     70       NA    8.2     6 14.5
##     5: $50,000 Climax Show, The 1975     71       NA    3.4    17 24.5
##    ---                                                                
## 58784:                tom thumb 1958     98       NA    6.5   274  4.5
## 58785:              www.XXX.com 2003    105       NA    1.1    12 45.5
## 58786:   www.hellssoapopera.com 1999    100       NA    6.6     5 24.5
## 58787:                      xXx 2002    132 85000000    5.5 18514  4.5
## 58788:  xXx: State of the Union 2005    101 87000000    3.9  1584 24.5
##          r2   r3   r4   r5   r6   r7   r8   r9  r10  mpaa Action Animation
##     1:  4.5  4.5  4.5 14.5 24.5 24.5 14.5  4.5  4.5            0         0
##     2: 14.5  4.5 24.5 14.5 14.5 14.5  4.5  4.5 14.5            0         0
##     3:  0.0  0.0  0.0  0.0 24.5  0.0 44.5 24.5 24.5            0         1
##     4:  0.0  0.0  0.0  0.0  0.0  0.0  0.0 34.5 45.5            0         0
##     5:  4.5  0.0 14.5 14.5  4.5  0.0  0.0  0.0 24.5            0         0
##    ---                                                                    
## 58784:  4.5  4.5  4.5 14.5 14.5 24.5 14.5  4.5  4.5            0         1
## 58785:  0.0  0.0  0.0  0.0  0.0 24.5  0.0  0.0 24.5            0         0
## 58786:  0.0 24.5  0.0  0.0  0.0  0.0  0.0 24.5 44.5            0         0
## 58787:  4.5  4.5  4.5 14.5 14.5 14.5 14.5  4.5  4.5 PG-13      1         0
## 58788:  4.5  4.5  4.5  4.5 14.5  4.5  4.5  4.5 14.5 PG-13      1         0
##        Comedy Drama Documentary Romance Short
##     1:      1     1           0       0     0
##     2:      1     0           0       0     0
##     3:      0     0           0       0     1
##     4:      1     0           0       0     0
##     5:      0     0           0       0     0
##    ---                                       
## 58784:      0     0           0       0     0
## 58785:      0     1           0       1     0
## 58786:      0     0           0       0     0
## 58787:      0     0           0       0     0
## 58788:      0     0           0       0     0
```

To see some information about *data.table* in memory:

```r
tables()
```

```
##      NAME       NROW NCOL MB
## [1,] DT            9    3  1
## [2,] moviesdt 58,788   24 12
## [3,] X             2    2  1
##      COLS                                                                            
## [1,] x,y,v                                                                           
## [2,] title,year,length,budget,rating,votes,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,mpaa,Action
## [3,] V1,foo                                                                          
##      KEY
## [1,]    
## [2,]    
## [3,]    
## Total: 14MB
```

# Accesing data

Accessing rows is similar to accessing *data.frame*'s row.

```r
# Rows 1 - 5
moviesdt[1:5,]
```

```
##                       title year length budget rating votes   r1   r2  r3
## 1:                        $ 1971    121     NA    6.4   348  4.5  4.5 4.5
## 2:        $1000 a Touchdown 1939     71     NA    6.0    20  0.0 14.5 4.5
## 3:   $21 a Day Once a Month 1941      7     NA    8.2     5  0.0  0.0 0.0
## 4:                  $40,000 1996     70     NA    8.2     6 14.5  0.0 0.0
## 5: $50,000 Climax Show, The 1975     71     NA    3.4    17 24.5  4.5 0.0
##      r4   r5   r6   r7   r8   r9  r10 mpaa Action Animation Comedy Drama
## 1:  4.5 14.5 24.5 24.5 14.5  4.5  4.5           0         0      1     1
## 2: 24.5 14.5 14.5 14.5  4.5  4.5 14.5           0         0      1     0
## 3:  0.0  0.0 24.5  0.0 44.5 24.5 24.5           0         1      0     0
## 4:  0.0  0.0  0.0  0.0  0.0 34.5 45.5           0         0      1     0
## 5: 14.5 14.5  4.5  0.0  0.0  0.0 24.5           0         0      0     0
##    Documentary Romance Short
## 1:           0       0     0
## 2:           0       0     0
## 3:           0       0     1
## 4:           0       0     0
## 5:           0       0     0
```

```r
# Year == 2005 & rating > 9
moviesdt[moviesdt$year == 2005 & movies$rating > 9.5,]
```

```
##                      title year length budget rating votes r1  r2 r3 r4 r5
##  1:           Blaze Orange 2005     16      0    9.6     7  0 0.0  0  0  0
##  2:     Filmic Achievement 2005     80     NA    9.6    10  0 0.0  0  0  0
##  3:         Goodnight Bill 2005     19     NA    9.6     7  0 0.0  0  0  0
##  4:       Goodnite Charlie 2005    119 100000    9.8    34  0 4.5  0  0  0
##  5:     Keeper of the Past 2005     18  30000    9.9     7  0 0.0  0  0  0
##  6:             Morphin(e) 2005     20   8000    9.7     7  0 0.0  0  0  0
##  7:                 Nun Fu 2005      5   5000    9.8     5  0 0.0  0  0  0
##  8:              Oath, The 2005     23     NA    9.8     5  0 0.0  0  0  0
##  9: Weg ist das Spiel, Der 2005      3     NA    9.8     8  0 0.0  0  0  0
## 10:        Wild Girls Gone 2005     93     NA    9.6     7  0 0.0  0  0  0
##     r6 r7   r8   r9  r10 mpaa Action Animation Comedy Drama Documentary
##  1:  0  0 14.5 14.5 74.5           0         0      0     0           0
##  2:  0  0 14.5 24.5 74.5           0         0      1     0           0
##  3:  0  0  0.0 44.5 45.5           0         0      0     1           0
##  4:  0  0  4.5  4.5 84.5           1         0      0     0           0
##  5:  0  0  0.0 14.5 84.5           0         0      0     0           0
##  6:  0  0  0.0 24.5 74.5           1         0      0     1           0
##  7:  0  0  0.0 24.5 84.5           1         0      0     0           0
##  8:  0  0  0.0 24.5 84.5           0         0      0     1           0
##  9:  0  0  0.0 24.5 74.5           0         0      0     0           0
## 10:  0  0 14.5 14.5 74.5           0         0      1     0           0
##     Romance Short
##  1:       0     1
##  2:       0     0
##  3:       0     1
##  4:       0     0
##  5:       0     1
##  6:       0     1
##  7:       0     1
##  8:       0     1
##  9:       0     1
## 10:       0     0
```

Accesing columns is quite different, with *data.frames* columns should be specified as a character vector.  
With *data.tables* the columns should be specified as a list of the actual names, not as characters.

```r
# Sample subset...
sampledt <- head (moviesdt[movies$rating > 9.5,], 10)

# Access columns year and title
sampledt[, list(year, title)]
```

```
##     year                                      title
##  1: 1981                                Adaptatziya
##  2: 1950                          Akatsuki no dasso
##  3: 2004                                     Anyone
##  4: 2004                              Apartment 206
##  5: 2003                                Army of One
##  6: 2003                              Aufbruch, Der
##  7: 2001            Ballad of Courtney & James, The
##  8: 2004 BattleGround: 21 Days on the Empire's Edge
##  9: 1998                              Berlin Berlin
## 10: 1959                             Biyaya ng lupa
```

It's also possible specify the columns names as a character, but in this case the *with* argument should be set to *FALSE*.

```r
# Access columns year and title
sampledt[, c('year', 'title'), with=FALSE]
```

```
##     year                                      title
##  1: 1981                                Adaptatziya
##  2: 1950                          Akatsuki no dasso
##  3: 2004                                     Anyone
##  4: 2004                              Apartment 206
##  5: 2003                                Army of One
##  6: 2003                              Aufbruch, Der
##  7: 2001            Ballad of Courtney & James, The
##  8: 2004 BattleGround: 21 Days on the Empire's Edge
##  9: 1998                              Berlin Berlin
## 10: 1959                             Biyaya ng lupa
```


