# Replication of Lee & Zhang (2013), OA 2
Christian Mueller  
3rd September 2015  

Validate the computation of Myers' index by replicating
an analysis, which appears in Online Appendix 2 of Lee and Zhang's
2013 research paper.

Melissa M. Lee and Nan Zhan (2013). The Art of Counting the Governed:
Census Accuracy, Civil War, and State Presence. CDDRL Working Papers, 
Vol. 146. Available [here](http://cddrl.fsi.stanford.edu/publications/the_art_of_counting_the_governed_census_accuracy_civil_war_and_state_presence).

## Prepare


```r
suppressPackageStartupMessages(source("../myers-score.R"))
```


```r
lz <- read.csv("../tests/data/lz-oa2.1.csv")
```

## Validate

Test if raw computation matches the result that Lee and Zhang compute.


```r
myers(lz$age, lz$freq, bin_start = 10, bin_size = 60)
```

```
## Source: local data frame [1 x 1]
## 
##      myers
##      (dbl)
## 1 17.91136
```

Lee and Zhang (2013: Table OA2.3 on p. 40) report the correct result as 17.911%.

## Validate internals

Also validate each step in the computation using the data of Lee & Zhang.


```r
target <- lz$age
freq <- lz$freq
bin_start <- 10
bin_size <- 60

d <- data.frame(target = target, freq = freq)
d_filter <- seq(bin_start, bin_start + bin_size + 10 - 2)

d <- d %>%
  filter(target %in% d_filter) %>%
  arrange(target) %>%
  mutate(lastdigit = target %% 10, wgt = c(1:9, rep(10, bin_size - (10 - 1)), 9:1))
```

I just copy-pasted the definition of the function but I removed the `stop()` and the `na.omit()` calls because the are not needed here.


```r
group_by(d, lastdigit) %>%
  summarise(freq = sum(freq * wgt))
```

```
## Source: local data frame [10 x 2]
## 
##    lastdigit     freq
##        (dbl)    (dbl)
## 1          0 26426394
## 2          1  9000586
## 3          2 15404372
## 4          3  9695204
## 5          4 10492890
## 6          5 23965274
## 7          6 11822456
## 8          7  9974852
## 9          8 16003030
## 10         9  8463680
```

This computes the total terminal digits in the "blended" poulation
It matches column (k) in table OA 2.2 and column (5) in table OA 2.3.


```r
group_by(d, lastdigit) %>%
  summarise(freq = sum(freq * wgt)) %>%
  mutate(
    freq = freq / sum(freq),
    score = (freq * 100) - 10,
    score = abs(score)
  )
```

```
## Source: local data frame [10 x 3]
## 
##    lastdigit       freq     score
##        (dbl)      (dbl)     (dbl)
## 1          0 0.18709119 8.7091187
## 2          1 0.06372153 3.6278468
## 3          2 0.10905848 0.9058475
## 4          3 0.06863923 3.1360774
## 5          4 0.07428661 2.5713389
## 6          5 0.16966717 6.9667173
## 7          6 0.08369955 1.6300449
## 8          7 0.07061905 2.9380948
## 9          8 0.11329680 1.3296800
## 10         9 0.05992039 4.0079606
```

This computes the percent of each terminal digit in the "blended"
population as well as the deviation from the expected 10%.
It matches columns (6) and (7) of table OA 2.3.
