library(tidyverse)
source('make_plot.R')
source('make_interactive_plot.R')

# Please open make_plot.R and make_intercative_plot.R to see the documentation of make_plot() and make_interactive_plot(), respectively.

# Importing the input file.

df <- read_csv('test_data.csv')

# Here are the examples of the non-interactive and interactive visualisations of Distribution of Cronbach's Alpha when an item within an assessment is dropped.

make_plot(df)

make_interactive_plot(df)