E4 plots
================
William Hall
July 18, 2018

These plots show the inter-beat intervals from the E4 device. The red lines represent the point at which participants pressed the event button on the E4 device and mark different portions of the study protocol (e.g. baseline, stressor, etc.). Each plot is labeled with a unique identifier.

``` r
e4_plots <- 
read_rds(here("data/preprocessed/g4_plot_data.rds"))

walk(e4_plots$plot, print)
```

![](e4_plots_files/figure-markdown_github/plot%20e4%20data-1.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-2.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-3.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-4.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-5.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-6.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-7.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-8.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-9.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-10.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-11.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-12.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-13.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-14.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-15.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-16.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-17.png)![](e4_plots_files/figure-markdown_github/plot%20e4%20data-18.png)
