#!/usr/bin/env Rscript

library(plotly)
library(htmlwidgets)
library(here)
library(tidyverse)

load(here("data", "wrangled", "wrangled_data.rda"))
table1_extract <- table1_extract %>%
    mutate(longitudinal = case_when(longitudinal == "Yes" ~ "Longitudinal", 
                                    longitudinal == "No" ~ "Not longitudinal", 
                                    TRUE ~ "Unknown"))

hover_text_template <- paste(
    "<b>Dataset:</b> %{text}<br>",
    "<b>Description:</b> %{customdata}",
    "<extra></extra>"
)

plotly_plot_hmdb <- table1_extract %>%
    plotly::plot_ly(
        x = ~num_paired_samples, 
        y = ~hmdb_annotated_compounds,
        color = ~longitudinal,
        text = ~dataset_name,                 # Point label text
        customdata = ~cohort_description,     # Hover description storage
        legendgroup = ~longitudinal, 
        showlegend = FALSE,
        type = 'scatter', 
        mode = "markers+text", 
        textposition = "top center",
        hovertemplate = hover_text_template   # Set hover text
    ) %>% 
    plotly::layout(
        title = 'Paired sample count vs HMDB annotation coverage', 
        xaxis = list(title = 'No. samples with paired data'), 
        yaxis = list(title = 'HMDB Annotated compounds')
    )

plotly_plot_kegg <- table1_extract %>%
    plotly::plot_ly(
        x = ~num_paired_samples, 
        y = ~kegg_annotated_compounds,
        color = ~longitudinal,
        text = ~dataset_name,
        customdata = ~cohort_description,
        legendgroup = ~longitudinal, 
        showlegend = TRUE,
        type = 'scatter', 
        mode = "markers+text", 
        textposition = "top center",
        hovertemplate = hover_text_template
    ) %>% 
    plotly::layout(
        title = 'Paired sample count vs KEGG annotation coverage', 
        xaxis = list(title = 'No. samples with paired data'), 
        yaxis = list(title = 'KEGG Annotated compounds')
    )

combined_plot <- subplot(style(plotly_plot_hmdb, showlegend = F), 
        plotly_plot_kegg) %>% 
    highlight(on = "plotly_hover", 
              off = "plotly_doubleclick", 
              persistent = FALSE, 
              dynamic = FALSE) %>% 
    layout(title = "Paired sample count vs annotation coverage")

output_dir <- here::here("results", "plots")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

saveWidget(combined_plot, 
           file = here(output_dir, "interactive_combined_plot.html"), 
           selfcontained = TRUE)