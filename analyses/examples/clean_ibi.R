library(tidyverse)
library(here)
library(fs)

ibi_file_names <- 
dir_ls("data/e4", regexp =  "IBI_.*")

ids <- 
  str_extract_all(ibi_file_names, "(?<=_)[0-9].*(?=(.csv))")
  
data_in <- 
map(ibi_file_names, read_csv, col_name = F) %>% 
  bind_rows(.id = "ID") %>% 
  mutate(ID = str_extract_all(ID, "(?<=_)[0-9].*(?=(.csv))", simplify = T)) %>% 
  nest(-ID) %>% 
  rename(phys_data = data)



f_clean_phys_data <- function(df) {
  df %>%
    tibble::rowid_to_column(., "row_number") %>% 
    rename(time = X1, ibi = X2) %>% 
    mutate(ibi = case_when(row_number == 1 ~ NA_character_, 
                           TRUE ~ ibi) %>% as.numeric(), 
           start_time = pull(. , time) %>% .[1], 
           time = case_when(row_number == 1 ~ start_time, 
                            TRUE ~ time + start_time)) %>% 
    mutate_at(vars(time, start_time), as.POSIXct, origin="1970-01-01") %>% 
    mutate(end_time = max(time), 
           total_time = {end_time - start_time} %>% as.numeric(.,units="mins"))
}



data_in_clean <- 
  data_in %>% 
  mutate(phys_data = phys_data %>% map(f_clean_phys_data))


tags_df <- 
dir_ls("data/e4", regexp =  "tags_.*") %>% 
  map(read_csv, col_name =F) %>%
  bind_rows(.id = "ID") %>% 
  mutate(ID = str_extract_all(ID, "(?<=_)[0-9].*(?=(.csv))", simplify = T)) %>% 
  nest(-ID) %>% 
  rename(tags_data = data)


f_clean_tags <- function(df) {
  df %>% 
    rename(time = X1) %>% 
    mutate_at(vars(time), as.POSIXct, origin="1970-01-01")
} 

tags_clean <- 
tags_df %>% 
  mutate(tags_data = tags_data %>% map(f_clean_tags))

#excludes people with less than 10 minutes of data.
data_to_plot <- 
data_in_clean %>% 
  left_join(tags_clean) %>% 
  mutate(total_time = phys_data %>% map_dbl(~pull(., total_time)[1] %>% unlist())) %>% 
  filter(total_time > 10)


plot_data <- function(phys_data, tags_data, title) {
  ggplot(phys_data, aes(x = time, y = ibi)) + 
    geom_col() +
    theme_classic() + 
    geom_vline(xintercept = tags_data$time, color= "red", size = 1) + 
    labs(title = title)
}

plot_df <- 
data_to_plot %>% 
  mutate(plot = pmap(list(phys_data, tags_data, ID), plot_data))


# write out the plot data -------------------------------------------------


write_rds(plot_df, "data/preprocessed/g4_plot_data.rds")
