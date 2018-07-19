library(tidyverse)
library(fs)
library(here)

in_files <- list.files(here("data/zipped_consumer_data/"), pattern = "zip$")
in_dirs <- paste0("data/zipped_consumer_data/", in_files)

out_folders <- in_files %>% str_remove_all("\\.zip")
out_dirs <- paste0("data/unzipped_consumer_data/", out_folders)

map2(in_dirs, out_dirs, ~unzip(.x, exdir = .y))

new_file_names <- out_folders

unzipped_all_files <- 
dir_ls("data/unzipped_consumer_data/") %>% 
  map(dir_ls) %>% 
  unname %>% 
  unlist %>% 
  unname

new_names <- unzipped_all_files %>% 
  str_replace_all(., "\\.", 
                  paste0("_", 
                         str_extract_all(., 
                                         "[0-9].*(?=(._))", 
                                         simplify = TRUE), "."))
  
file_move(unzipped_all_files, new_names)

dir_create(here("data/e4"))

dir_ls(here("data/unzipped_consumer_data/")) %>% 
  map(dir_ls) %>% 
  map(~file_copy(path = ., here("data/e4")))

dir_ls("data/unzipped_consumer_data/") %>% 
  dir_delete()

