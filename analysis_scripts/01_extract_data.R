#!/usr/bin/env Rscript

library(tabulapdf)
library(here)
library(readr)

#extract the data
raw_table <- tabulapdf::extract_tables("https://www.nature.com/articles/s41522-022-00345-5.pdf",
                                       pages = 2,
                                       method = "stream",
                                       col_names = FALSE
                                      )[[1]]

#output information about the extracted data
cat("Dimensions: ", paste(dim(raw_table), collapse = " x "), "\n")
cat("Number of NAs: ", sum(is.na(raw_table)), "\n")

#save the data
output_dir <- here::here("data", "imported")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}


save(raw_table,
    file = here::here(output_dir,
                      "raw_table1.rda"))

readr::write_csv(raw_table,
                 file = here::here(output_dir,
                                   "raw_table1.csv"))
