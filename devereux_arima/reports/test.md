test
================
Christoper Chan
22:59 25 March 2019

``` r
library(ggplot2)
```

``` r
## Test
```

``` r
df <- data.frame(X = 1:5, Y = 1:5)
ggplot(df, aes(X, Y)) +
  geom_point()
```

![](/home/ckc/Documents/git_projects/projects/devereux_arima/reports/test_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
getwd()
```

    ## [1] "/home/ckc/Documents/git_projects/projects/devereux_arima/notebooks"

``` r
print('hello world')
```

    ## [1] "hello world"
