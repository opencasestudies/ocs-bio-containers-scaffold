#!/usr/bin/env Rscript

library(here)
library(tidyverse)

load(here("data", "wrangled", "wrangled_data.rda"))

#' A function to find a correlation matrix given an input data frame
#'
#' This function will find the Spearman correlation matrix reporting pairwise Spearman correlations from among the num_paired_samples, kegg_annotated_compounds, and hmdb_annotated_compounds variables
#' 
#' @param input_df the input df to find the correlation from
#'        This may be filtered in a later step to only include datasets that are __ (all adults, all longitudinal, etc.). 
#'        Needs to have columns num_paired_samples, kegg_annotated_compounds, hmdb_annotated_compounds, cohort_description, and longitudinal.
#' @param filter_description default is "All Data" assuming that the dataset isn't filtered. 
#'        Change to reflect how the data should be filtered prior to finding correlations. 
#'        Options include "Non-longitudinal" and "Adult".
#'
#' Will output information rather than returning a variable or object.
find_cor_matrix <- function(input_df, filter_description = "All Data"){
  
  #check input to make sure it is supported
  stopifnot(filter_description %in% c("All Data", "Non-longitudinal", "Adult"))
  
  #filter based off of filter_description option
  if (filter_description == "Non-longitudinal"){
    to_assess <- input_df %>%
      filter(longitudinal == "No")
  } else if(filter_description == "Adult"){
    to_assess <- input_df %>%
      filter(!stringr::str_detect(tolower(cohort_description), 
                         "infants|children"))
  } else{
    #Using All Datasets
    to_assess <- input_df
  }
  
  #Find Spearman correlations
  cor_matrix <- to_assess %>%
    select(num_paired_samples,
           kegg_annotated_compounds,
           hmdb_annotated_compounds) %>%
    cor(., method = "spearman")
  
  #output information about the correlation analysis
  cat("\n", filter_description, "\n")
  cat("Number of datasets per variable in correlation analysis (", filter_description, ") : ", nrow(to_assess), "\n")
  cat("Annotated Compounds Spearman Correlation (", filter_description, "): ", cor_matrix["kegg_annotated_compounds", "hmdb_annotated_compounds"], "\n")
  cat("Number of samples and KEGG Annotated Compounds Spearman Correlation (", filter_description, "): ", cor_matrix["num_paired_samples", "kegg_annotated_compounds"], "\n")
  cat("HMDB Annotated Compounds and Number of samples Spearman Correlation (", filter_description, "): ", cor_matrix["hmdb_annotated_compounds", "num_paired_samples"], "\n")
}

# All datasets
find_cor_matrix(table1_extract)

# Non-longitudinal datasets only
find_cor_matrix(table1_extract, filter_description = "Non-longitudinal")

# Adult datasets only
find_cor_matrix(table1_extract, filter_description = "Adult")
