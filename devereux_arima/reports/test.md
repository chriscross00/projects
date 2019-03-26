test
================
Christoper Chan
23:08 25 March 2019

``` r
library(knitr)
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.1.0     ✔ purrr   0.2.5
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.8
    ## ✔ tidyr   0.8.2     ✔ stringr 1.3.1
    ## ✔ readr   1.2.1     ✔ forcats 0.3.0

    ## ── Conflicts ───────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

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
print('hello world')
```

    ## [1] "hello world"
