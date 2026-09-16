#!/usr/bin/env Rscript

library(here)
library(tidyverse)
library(readr)

load(here("data", "imported", "raw_table1.rda"))

#wrangle the data
table1_extract <- raw_table %>%
    dplyr::rename(c("dataset_name" = "X1",
             "ref" = "X2",
             "cohort_description_num_paired_samples" = "X3",
             "longitudinal" = "X5",
             "hmdb_annotated_compounds" = "X6",
             "kegg_annotated_compounds" = "X7")) %>%
    dplyr::mutate(num_paired_samples = as.numeric(
                                  stringr::str_extract(
                                    cohort_description_num_paired_samples,
                                    "\\d+$"
                                    )
                                ),
            cohort_description_text = stringr::str_remove(
                                        cohort_description_num_paired_samples,
                                        "\\d+$"
                                      ),
          cohort_description = dplyr::case_when(lead(is.na(dataset_name),
                                              default = FALSE) ~
                                        paste0(cohort_description_text,
                                              dplyr::lead(cohort_description_text)),
                                        .default = cohort_description_text)
           ) %>%
    dplyr::filter(!is.na(dataset_name)) %>%
    dplyr::select(!c(X4,
              cohort_description_num_paired_samples,
              cohort_description_text))

#output information about the extracted data
cat("Dimensions: ", paste(dim(table1_extract), collapse = " x "), "\n")
cat("Number of NAs: ", sum(is.na(table1_extract)), "\n")
cat("Dataset Name (Row 4): ", unlist(table1_extract[4, "dataset_name"]), "\n")

#save the data
output_dir <- here("data", "wrangled")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

save(table1_extract, file = here(output_dir,
                                 "wrangled_data.rda"))
write_csv(table1_extract,
                 file = here(output_dir,
                             "wrangled_data.csv"))
