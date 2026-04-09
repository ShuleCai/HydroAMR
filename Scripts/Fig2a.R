pkgs <- c("ggplot2", "dplyr", "ggthemes", "patchwork")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

region_data <- read.csv("./Data/Fig2a_region.csv", row.names = 1)
income_data <- read.csv("./Data/Fig2a_income.csv", row.names = 1)
# Compute a shared y-axis range for both metrics
y_min <- min(c(region_data$log_ratio_hydro, region_data$log_ratio_total,
               income_data$log_ratio_hydro, income_data$log_ratio_total))
y_max <- max(c(region_data$log_ratio_hydro, region_data$log_ratio_total,
               income_data$log_ratio_hydro, income_data$log_ratio_total))
# Create the Region bar chart
p1 <- ggplot(region_data) +
  # Bar chart for hydro_pop_m (blue)
  geom_col(aes(x = reorder(Name, -log_ratio_hydro), y = log_ratio_hydro), 
           fill = "#1f77b4", width = 0.7, alpha = 0.7) +
  # Marker for Total_hydro (black star)
  geom_point(aes(x = reorder(Name, -log_ratio_hydro), y = log_ratio_total), 
             shape = 8, size = 3, color = "black", stroke = 0.5) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  labs(title = NULL, 
       x = NULL, 
       y = expression(log[2]("x"/"mean"))) +
  ylim(y_min * 1.01, y_max * 1.01) +
  theme_base() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Create the Income level bar chart
p2 <- ggplot(income_data) +
  # Bar chart for hydro_pop_m (green)
  geom_col(aes(x = reorder(Name, -log_ratio_hydro), y = log_ratio_hydro), 
           fill = "#2ca02c", width = 0.7, alpha = 0.7) +
  # Marker for Total_hydro (black star)
  geom_point(aes(x = reorder(Name, -log_ratio_hydro), y = log_ratio_total), 
             shape = 8, size = 3, color = "black", stroke = 0.5) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  labs(title = NULL, 
       x = NULL, 
       y = expression(log[2]("x"/"mean"))) +
  ylim(y_min * 1.01, y_max * 1.01) +
  theme_base() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Combine the plots horizontally
combined_plot <- p1 + p2 + 
  plot_layout(widths = c(7, 4)) +
  plot_annotation(theme = theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold")))

# Display the plot
print(combined_plot)

ggsave("./Figures//Fig2a.pdf", combined_plot, family = "ArialMT")
