test
================
Christoper Chan
00:25 26 March 2019

TO DO:

-   Make md render graphs properly
-   [This](https://deanattali.com/blog/ezknitr-package/) might fix my problems

``` r
library(knitr)
library(tidyverse)
```

    ## ── Attaching packages ─────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.1.0       ✔ purrr   0.3.2  
    ## ✔ tibble  2.1.1       ✔ dplyr   0.8.0.1
    ## ✔ tidyr   0.8.3       ✔ stringr 1.4.0  
    ## ✔ readr   1.3.1       ✔ forcats 0.4.0

    ## ── Conflicts ────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(ggplot2)
```

``` r
df <- data.frame(X = 1:5, Y = 1:5)
a <- ggplot(df, aes(X, Y)) +
  geom_point()
print(a)
```

![](/home/ckc/Documents/git_projects/projects/devereux_arima/notebooks/test_dir/analysis_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
print('hello world')
```

    ## [1] "hello world"
