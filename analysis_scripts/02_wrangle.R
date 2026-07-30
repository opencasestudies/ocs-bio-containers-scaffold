#!/usr/bin/env Rscript

library(here)
library(tidyverse)
library(readr)

load(here::here("data", "imported", "raw_table1.rda"))

#wrangle the data
table1_extract <- raw_table %>%
    rename(c("dataset_name" = "X1",
             "ref" = "X2",
             "cohort_description_num_paired_samples" = "X3",
             "longitudinal" = "X5",
             "hmdb_annotated_compounds" = "X6",
             "kegg_annotated_compounds" = "X7")) %>%
    mutate(num_paired_samples = as.numeric(
                                  str_extract(
                                    cohort_description_num_paired_samples,
                                    "\\d+$"
                                    )
                                ),
            cohort_description_text = str_remove(
                                        cohort_description_num_paired_samples,
                                        "\\d+$"
                                      ),
          cohort_description = case_when(lead(is.na(dataset_name),
                                              default = FALSE) ~
                                        paste0(cohort_description_text,
                                              lead(cohort_description_text)),
                                        .default = cohort_description_text)
           ) %>%
    filter(!is.na(dataset_name)) %>%
    select(!c(X4,
              cohort_description_num_paired_samples,
              cohort_description_text))

#output information about the extracted data
cat("Dimensions: ", paste(dim(table1_extract), collapse = " x "), "\n")
cat("Number of NAs: ", sum(is.na(table1_extract)), "\n")
cat("Dataset Name (Row 4): ", unlist(table1_extract[4, "dataset_name"]), "\n")

#save the data
output_dir <- here::here("data", "wrangled")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

save(table1_extract, file = here::here(output_dir,
                                       "wrangled_data.rda"))
readr::write_csv(table1_extract,
                 file = here::here(output_dir,
                                   "wrangled_data.csv"))
