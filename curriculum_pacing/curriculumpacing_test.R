library(tidyverse)
source("make_plot.R")

# Please open make_plot.R to see the documentation of make_plot()

# Importing the input files
rdf <- read_tsv("ds185_student_problem_All_Data_508_2015_0729_210705_1.txt")
ord_df <- read_csv("ds185_student_problem_All_Data_508_2015_0729_210705_1_problem_hierarchy_order.csv")

# Here are the examples of the different types of curriculum pacing plots
make_plot(rdf, ord_df, "Absolute", "Day", 1, 365, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage")
make_plot(rdf, ord_df, "Absolute", "Day", 1, 365, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage and performance")

make_plot(rdf, ord_df, "Absolute", "Week", 1, 52, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage")
make_plot(rdf, ord_df, "Absolute", "Week", 1, 52, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage and performance")

make_plot(rdf, ord_df, "Absolute", "Month", 1, 12, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage")
make_plot(rdf, ord_df, "Absolute", "Month", 1, 12, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage and performance")

make_plot(rdf, ord_df, "Relative", "Day", 1, 365, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage")
make_plot(rdf, ord_df, "Relative", "Day", 1, 365, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage and performance")

make_plot(rdf, ord_df, "Relative", "Week", 1, 52, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage")
make_plot(rdf, ord_df, "Relative", "Week", 1, 52, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage and performance")

make_plot(rdf, ord_df, "Relative", "Month", 1, 12, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage")
make_plot(rdf, ord_df, "Relative", "Month", 1, 12, "2011-07-01 00:00:00", "2012-06-30 00:00:00", "Usage and performance")
