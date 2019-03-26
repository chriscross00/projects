test
================
Christoper Chan
22:49 25 March 2019

``` r
library(ggplot2)
```

``` r
df <- data.frame(X = 1:5, Y = 1:5)

ggplot(df, aes(X, Y)) +
  geom_point()
```

![](/home/ckc/Documents/git_projects/projects/devereux_arima/reports/test_files/figure-markdown_github/unnamed-chunk-2-1.png)
