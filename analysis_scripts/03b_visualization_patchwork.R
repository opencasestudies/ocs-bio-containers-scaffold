#!/usr/bin/env Rscript

library(here)
library(tidyverse)
library(ggplot2)
library(patchwork)

load(here::here("results", "plots", "scatter_plots.rda"))

hmdb_scatter + labs(title = NULL) +
  kegg_scatter +  labs(title = NULL) +
  plot_layout(guides = "collect") +
  plot_annotation(title = 'Paired sample count vs annotation coverage')

#save the plot
output_dir <- here::here("results", "plots")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

ggsave(here::here(output_dir, "combined_scatter.png"))
