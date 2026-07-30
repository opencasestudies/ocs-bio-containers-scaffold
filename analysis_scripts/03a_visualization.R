#!/usr/bin/env Rscript

library(here)
library(tidyverse)
library(ggplot2)

load(here::here("data", "wrangled", "wrangled_data.rda"))

cat("Dimensions: ", paste(dim(table1_extract), collapse = " x "), "\n")

#HMDB plot

hmdb_scatter <- table1_extract %>%
  mutate(longitudinal = factor(longitudinal, levels = c("No", "Yes"))) %>%
  ggplot(aes(x = num_paired_samples,
             y = hmdb_annotated_compounds,
             color = longitudinal,
             label = dataset_name)) +
  geom_point(size = 2.5) +
  geom_text(vjust = -0.5, size = 2.8, color = "black") +
  scale_color_viridis_d(end = 0.6) +
  labs(title = "Paired sample count vs HMDB annotation coverage",
       x = "No. samples with paired data",
       y = "HMDB Annotated compounds",
       color = "Longitudinal")  +
  theme_minimal(base_size = 12) +
  coord_fixed(ratio = 1)

#save the plot
output_dir <- here::here("results", "plots")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

ggsave(here::here(output_dir, "hmdb_scatter.png"))

cat("HMDB plot completed\n")

#KEGG plot

kegg_scatter <- table1_extract %>%
  mutate(longitudinal = factor(longitudinal, levels = c("No", "Yes"))) %>%
  ggplot(aes(x = num_paired_samples,
             y = kegg_annotated_compounds,
             color = longitudinal,
             label = dataset_name)) +
  geom_point(size = 2.5) +
  geom_text(vjust = -0.5, size = 2.8, color = "black") +
  scale_color_viridis_d(end = 0.6) +
  labs(title = "Paired sample count vs KEGG annotation coverage",
       x = "No. samples with paired data",
       y = "KEGG Annotated compounds",
       color = "Longitudinal")  +
  theme_minimal(base_size = 12) +
  coord_fixed(ratio = 1)

#save the plot
ggsave(here::here(output_dir, "kegg_scatter.png"))


cat("KEGG plot completed\n")

#save the plot ggplot objects
save(hmdb_scatter, kegg_scatter,
     file = here::here(output_dir, 
                              "scatter_plots.rda"))
