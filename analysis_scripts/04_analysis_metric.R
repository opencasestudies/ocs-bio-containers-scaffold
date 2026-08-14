#!/usr/bin/env Rscript

library(here)
library(tidyverse)

load(here("data", "wrangled", "wrangled_data.rda"))

cor_matrix_all <- table1_extract %>% 
    select(num_paired_samples, 
           kegg_annotated_compounds, 
           hmdb_annotated_compounds) %>%
    cor(., method = "spearman")

#output information about the correlation analysis for all datasets
cat("All Datasets\n")
cat("Number of Datasets per variable in correlation analysis (All Data): ", nrow(table1_extract), "\n")
cat("Annoted Compounds Spearman Correlation (All Data): ", cor_matrix_all["kegg_annotated_compounds", "hmdb_annotated_compounds"], "\n")
cat("Number of samples and KEGG Annotated Compounds Spearman Corelation (All Data): ", cor_matrix_all["num_paired_samples", "kegg_annotated_compounds"], "\n")
cat("HMDB Annotated Compounds and Number of samples Spearman Correlation (All Data): ", cor_matrix_all["hmdb_annotated_compounds", "num_paired_samples"], "\n")

cor_matrix_non_longitudinal <- table1_extract %>%
    filter(longitudinal == "No") %>%
    select(num_paired_samples, 
           kegg_annotated_compounds, 
           hmdb_annotated_compounds) %>%
    cor(., method = "spearman")

#output information about non-longitudinal datasets correlation analysis
cat("\nNon-longitudinal Datasets\n")
cat("Number of Datasets per variable in correlation analysis (Non-longitudinal Data): ", nrow(table1_extract %>% filter(longitudinal == "No")), "\n")
cat("Annoted Compounds Spearman Correlation (Non-longitudinal Data): ", cor_matrix_non_longitudinal["kegg_annotated_compounds", "hmdb_annotated_compounds"], "\n")
cat("Number of samples and KEGG Annotated Compounds Spearman Corelation (Non-longitudinal Data): ", cor_matrix_non_longitudinal["num_paired_samples", "kegg_annotated_compounds"], "\n")
cat("HMDB Annotated Compounds and Number of samples Spearman Correlation (Non-longitudinal Data): ", cor_matrix_non_longitudinal["hmdb_annotated_compounds", "num_paired_samples"], "\n")


cor_matrix_adult <- table1_extract %>%
    filter(!str_detect(tolower(cohort_description),
                      "infants|children")) %>%
    select(num_paired_samples, 
           kegg_annotated_compounds, 
           hmdb_annotated_compounds) %>%
    cor(., method = "spearman")

#output information about the Adult only datasets correlation analysis
cat("\nAdult Datasets\n")
cat("Number of Datasets per variable in correlation analysis (Adult Data): ", nrow(table1_extract %>% filter(!str_detect(tolower(cohort_description), "infants|children"))), "\n")
cat("Annoted Compounds Spearman Correlation (Adult Data): ", cor_matrix_adult["kegg_annotated_compounds", "hmdb_annotated_compounds"], "\n")
cat("Number of samples and KEGG Annotated Compounds Spearman Corelation (Adult Data): ", cor_matrix_adult["num_paired_samples", "kegg_annotated_compounds"], "\n")
cat("HMDB Annotated Compounds and Number of samples Spearman Correlation (Adult Data): ", cor_matrix_adult["hmdb_annotated_compounds", "num_paired_samples"], "\n")
