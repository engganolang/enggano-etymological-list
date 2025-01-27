# R codes used to transform the original .xlsx file into .rds, .csv, and .tsv
## G. Rajeg (2025)

library(readxl)
library(tidyverse)

rawdf <- read_xlsx("data-raw/Enggano-Etymological-List.xlsx") |> 
  select(-Concepticon_ID,
         -Concepticon_URL) # remove concepticon columns as they are processed differently here: https://github.com/engganolang/enolex

colnames_temp <- colnames(rawdf)

colnames_temp <- str_replace_all(colnames_temp, "\\r\\n", " ")

colnames(rawdf) <- colnames_temp

rawdf <- rawdf |> 
  mutate(across(where(is.character), ~replace_na(., "")))

rawdf |> 
  write_rds("data-raw/Enggano-Etymological-List.rds")
rawdf |> 
  write_csv("data-raw/Enggano-Etymological-List.csv",
            na = "")
rawdf |> 
  write_tsv("data-raw/Enggano-Etymological-List.tsv",
            na = "")
