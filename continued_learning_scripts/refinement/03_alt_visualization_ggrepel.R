#!/usr/bin/env Rscript

library(here)
library(tidyverse)
library(ggplot2)
library(patchwork)
library(ggrepel)

load(here::here("results", "plots", "scatter_plots.rda"))

hmdb_scatter$layers[[2]] <- NULL #remove the geom_text layer
kegg_scatter$layers[[2]] <- NULL #remove the geom_text layer

hmdb_scatter + labs(title = NULL) + geom_text_repel() +
  kegg_scatter +  labs(title = NULL) + geom_text_repel() +
  plot_layout(guides = "collect") +
  plot_annotation(title = 'Paired sample count vs annotation coverage')

#save the plot
output_dir <- here::here("results", "plots")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

ggsave(here::here(output_dir, "combined_scatter.png"))