R Basics
================

##### Setting the root directory

``` r
setwd("~/Desktop/projects/r-projects")
```

##### Clean environment memory in R

``` r
rm(list = ls())
```

##### Import data

``` r
sample <- read.csv("sample.csv", header = FALSE)

#In case the a table is a txt file..
#sample <- read.table("sample.txt", sep=",", header = FALSE)
```

##### Assess data

``` r
summary(sample)
```

    ##        V1        
    ##  Min.   :  1.00  
    ##  1st Qu.: 25.75  
    ##  Median : 50.50  
    ##  Mean   : 50.50  
    ##  3rd Qu.: 75.25  
    ##  Max.   :100.00  
    ##                  
    ##                                                            V2    
    ##  Angle-D Binders with Locking Rings, Label Holders          : 2  
    ##  Cardinal Slant-D\256 Ring Binder, Heavy Gauge Vinyl        : 2  
    ##  GBC Pre-Punched Binding Paper, Plastic, White, 8-1/2" x 11": 2  
    ##  Holmes HEPA Air Purifier                                   : 2  
    ##  LX 788                                                     : 2  
    ##  #10 White Business Envelopes,4 1/8 x 9 1/2                 : 1  
    ##  (Other)                                                    :89  
    ##               V3           V4              V5                  V6         
    ##  Grant Carroll : 7   Min.   :    3   Min.   :-1766.010   Min.   :   1.76  
    ##  Annie Cyprus  : 6   1st Qu.: 1540   1st Qu.:  -91.028   1st Qu.:   6.48  
    ##  Beth Paige    : 6   Median : 5300   Median :   -0.425   Median :  19.98  
    ##  Carlos Soltero: 5   Mean   : 5037   Mean   :  104.522   Mean   :  77.43  
    ##  Joy Bell      : 5   3rd Qu.: 8398   3rd Qu.:   93.470   3rd Qu.:  82.23  
    ##  Dorothy Wardle: 4   Max.   :10945   Max.   : 3424.220   Max.   :1637.53  
    ##  (Other)       :67                                                        
    ##        V7                             V8    
    ##  Min.   : 0.490   Northwest Territories:21  
    ##  1st Qu.: 2.985   Nunavut              :79  
    ##  Median : 5.900                             
    ##  Mean   :13.501                             
    ##  3rd Qu.:13.180                             
    ##  Max.   :74.350                             
    ##                                             
    ##                               V9          V10        
    ##  Paper                         :21   Min.   :0.3500  
    ##  Binders and Binder Accessories:11   1st Qu.:0.3800  
    ##  Telephones and Communication  :10   Median :0.5300  
    ##  Appliances                    : 7   Mean   :0.5147  
    ##  Chairs & Chairmats            : 7   3rd Qu.:0.5900  
    ##  Computer Peripherals          : 7   Max.   :0.8500  
    ##  (Other)                       :37   NA's   :3

``` r
nrow(sample)
```

    ## [1] 100

``` r
head(sample)
```

    ##   V1                                                  V2
    ## 1  1    Eldon Base for stackable storage shelf, platinum
    ## 2  2  1.7 Cubic Foot Compact "Cube" Office Refrigerators
    ## 3  3 Cardinal Slant-D\256 Ring Binder, Heavy Gauge Vinyl
    ## 4  4                                                R380
    ## 5  5                            Holmes HEPA Air Purifier
    ## 6  6   G.E. Longer-Life Indoor Recessed Floodlight Bulbs
    ##                   V3  V4      V5     V6    V7      V8
    ## 1 Muhammed MacIntyre   3 -213.25  38.94 35.00 Nunavut
    ## 2       Barry French 293  457.81 208.16 68.02 Nunavut
    ## 3       Barry French 293   46.71   8.69  2.99 Nunavut
    ## 4      Clay Rozendal 483 1198.97 195.99  3.99 Nunavut
    ## 5     Carlos Soltero 515   30.94  21.78  5.94 Nunavut
    ## 6     Carlos Soltero 515    4.43   6.64  4.95 Nunavut
    ##                               V9  V10
    ## 1         Storage & Organization 0.80
    ## 2                     Appliances 0.58
    ## 3 Binders and Binder Accessories 0.39
    ## 4   Telephones and Communication 0.58
    ## 5                     Appliances 0.50
    ## 6             Office Furnishings 0.37

``` r
tail(sample)
```

    ##      V1                                       V2              V3    V4
    ## 95   95       Bevis Boat-Shaped Conference Table   Doug Bickford 10499
    ## 96   96 Linden\256 12" Wall Clock With Oak Frame   Doug Bickford 10535
    ## 97   97                               Newell 326   Doug Bickford 10535
    ## 98   98             Prismacolor Color Pencil Set    Jamie Kunitz 10789
    ## 99   99               Xerox Blank Computer Paper Anthony Johnson 10791
    ## 100 100                          600 Series Flip    Ralph Knight 10945
    ##         V5     V6    V7                    V8                           V9
    ## 95   31.21 262.11 62.74 Northwest Territories                       Tables
    ## 96  -44.14  33.98 19.99 Northwest Territories           Office Furnishings
    ## 97   -0.79   1.76  0.70 Northwest Territories          Pens & Art Supplies
    ## 98   76.42  19.84  4.10 Northwest Territories          Pens & Art Supplies
    ## 99   93.36  19.98  5.77 Northwest Territories                        Paper
    ## 100   4.22  95.99  8.99 Northwest Territories Telephones and Communication
    ##      V10
    ## 95  0.75
    ## 96  0.55
    ## 97  0.56
    ## 98  0.44
    ## 99  0.38
    ## 100 0.57

``` r
str(sample) #show structure of R object
```

    ## 'data.frame':    100 obs. of  10 variables:
    ##  $ V1 : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ V2 : Factor w/ 95 levels "#10 White Business Envelopes,4 1/8 x 9 1/2",..: 36 3 29 65 45 39 15 69 68 88 ...
    ##  $ V3 : Factor w/ 43 levels "Aaron Bergman",..: 38 9 9 20 18 18 15 15 37 24 ...
    ##  $ V4 : int  3 293 293 483 515 515 613 613 643 678 ...
    ##  $ V5 : num  -213.2 457.8 46.7 1199 30.9 ...
    ##  $ V6 : num  38.94 208.16 8.69 195.99 21.78 ...
    ##  $ V7 : num  35 68.02 2.99 3.99 5.94 ...
    ##  $ V8 : Factor w/ 2 levels "Northwest Territories",..: 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ V9 : Factor w/ 16 levels "Appliances","Binders and Binder Accessories",..: 14 1 2 16 1 9 2 14 14 10 ...
    ##  $ V10: num  0.8 0.58 0.39 0.58 0.5 0.37 0.38 NA NA 0.38 ...

``` r
dim(sample) #dimensions
```

    ## [1] 100  10

##### Counting

``` r
max(sample$V4)
```

    ## [1] 10945

``` r
min(sample$V5)
```

    ## [1] -1766.01

``` r
unique(sample$V3)
```

    ##  [1] Muhammed MacIntyre Barry French       Clay Rozendal     
    ##  [4] Carlos Soltero     Carl Jackson       Monica Federle    
    ##  [7] Dorothy Badders    Neola Schneider    Carlos Daly       
    ## [10] Claudia Miner      Allen Rosenblatt   Sylvia Foulston   
    ## [13] Jim Radford        Carl Ludwig        Don Miller        
    ## [16] Annie Cyprus       Grant Carroll      Alan Barnes       
    ## [19] Jack Garza         Julia West         Eugene Barchas    
    ## [22] Edward Hooks       Brad Eason         Nicole Hansen     
    ## [25] Dorothy Wardle     Aaron Bergman      Don Jones         
    ## [28] Beth Thompson      Frank Price        Michelle Lonsdale 
    ## [31] Ann Chong          Joy Bell           Skye Norling      
    ## [34] Barry Weirich      Adrian Hane        Andrew Gjertsen   
    ## [37] Ralph Knight       Beth Paige         Bryan Davis       
    ## [40] Delfina Latchford  Doug Bickford      Jamie Kunitz      
    ## [43] Anthony Johnson   
    ## 43 Levels: Aaron Bergman Adrian Hane Alan Barnes ... Sylvia Foulston

``` r
sort(unique(sample$V3))
```

    ##  [1] Aaron Bergman      Adrian Hane        Alan Barnes       
    ##  [4] Allen Rosenblatt   Andrew Gjertsen    Ann Chong         
    ##  [7] Annie Cyprus       Anthony Johnson    Barry French      
    ## [10] Barry Weirich      Beth Paige         Beth Thompson     
    ## [13] Brad Eason         Bryan Davis        Carl Jackson      
    ## [16] Carl Ludwig        Carlos Daly        Carlos Soltero    
    ## [19] Claudia Miner      Clay Rozendal      Delfina Latchford 
    ## [22] Don Jones          Don Miller         Dorothy Badders   
    ## [25] Dorothy Wardle     Doug Bickford      Edward Hooks      
    ## [28] Eugene Barchas     Frank Price        Grant Carroll     
    ## [31] Jack Garza         Jamie Kunitz       Jim Radford       
    ## [34] Joy Bell           Julia West         Michelle Lonsdale 
    ## [37] Monica Federle     Muhammed MacIntyre Neola Schneider   
    ## [40] Nicole Hansen      Ralph Knight       Skye Norling      
    ## [43] Sylvia Foulston   
    ## 43 Levels: Aaron Bergman Adrian Hane Alan Barnes ... Sylvia Foulston

``` r
length(unique(sample$V3))
```

    ## [1] 43

##### Queries

``` r
which(sample$V3 == "Eugene Barchas")
```

    ## [1] 37 38 39

``` r
length(which(sample$V3 == "Eugene Barchas"))
```

    ## [1] 3

##### Check data type

``` r
is.matrix(sample)
```

    ## [1] FALSE

``` r
is.data.frame(sample)
```

    ## [1] TRUE

##### Manipulate data

``` r
sample_mtx <- as.matrix(sample)
is.matrix(sample_mtx)
```

    ## [1] TRUE

``` r
a <- matrix(1,2,3)
a
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    1    1
    ## [2,]    1    1    1

``` r
is.matrix(a)
```

    ## [1] TRUE

``` r
as.data.frame(a)
```

    ##   V1 V2 V3
    ## 1  1  1  1
    ## 2  1  1  1

##### Transpose

``` r
t(a)
```

    ##      [,1] [,2]
    ## [1,]    1    1
    ## [2,]    1    1
    ## [3,]    1    1

``` r
a
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    1    1
    ## [2,]    1    1    1

##### Delete/add a row/columns

``` r
a <- a[-1,]
a
```

    ## [1] 1 1 1

``` r
a <- rbind(a, c(2,2,2)) #add row
a
```

    ##   [,1] [,2] [,3]
    ## a    1    1    1
    ##      2    2    2

``` r
a <- cbind(a, c(2,3)) #add col
a
```

    ##   [,1] [,2] [,3] [,4]
    ## a    1    1    1    2
    ##      2    2    2    3
