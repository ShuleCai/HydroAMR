pkgs <- c("ggplot2", "gridExtra", "ggthemes")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

total_df_norm <- read.csv("./Data/Fig3g_hydro.csv", row.names = 1, check.names = F)
other_df_norm <- read.csv("./Data/Fig3g_other.csv", row.names = 1, check.names = F)
# Get the technology names
tech_names <- rownames(total_df_norm)
years <- as.numeric(colnames(total_df_norm))

# Create the color mapping
colors <- c("Total" = "#000e79", "Other" = "#96ce9f")

# Create an empty list to store all plots
plot_list <- list()

# Create a plot for each technology
for (i in 1:length(tech_names)) {
  tech_name <- tech_names[i]

  # Extract the data
  total_data <- as.numeric(total_df_norm[i, ])
  other_data <- as.numeric(other_df_norm[i, ])

  # Create a data frame
  df <- data.frame(
    Year = rep(years, 2),
    Count = c(total_data, other_data),
    Group = rep(c("Total", "Other"), each = length(years))
  )

  # Create the ggplot figure
  p <- ggplot(df, aes(x = Year, y = Count, color = Group)) +
    geom_smooth(method = "loess", se = FALSE, linewidth = 1) +
    scale_color_manual(values = colors) +
    scale_x_continuous(breaks = c(2000, 2010, 2020)) + # Show only 2000, 2010, and 2020
    labs(title = tech_name, x = NULL, y = NULL) +
    theme_few() +
    theme(
      panel.background = element_rect(fill = "white", color = NA),
      plot.background = element_rect(fill = "white", color = NA),
      panel.grid = element_blank(),
      axis.line = element_line(color = "black"),
      legend.position = "none", # Hide the legend
      plot.title = element_text(hjust = 0.5, size = 10) # Center the title and adjust its size
    )

  # Add the plot to the list
  plot_list[[i]] <- p
}

# Combine all plots into a 2-row layout
combined_plot <- grid.arrange(grobs = plot_list, nrow = 2, ncol = 5)
ggsave("./Figures/Fig3g.pdf", combined_plot,
  width = 10, height = 3
)
