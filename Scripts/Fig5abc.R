pkgs <- c("ggplot2", "patchwork", "dplyr", "RColorBrewer", "ggthemes", "ggpattern")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

color_palette <- readRDS("./Data/Fig5_palette.rds")
plot_data_pct1 <- read.csv("./Data/Fig5b.csv", check.names = F, row.names = 1)
plot_data_pct2 <- read.csv("./Data/Fig5c.csv", check.names = F, row.names = 1)
total1 <- read.csv("./Data/Fig5b_total.csv", check.names = F, row.names = 1)
total2 <- read.csv("./Data/Fig5c_total.csv", check.names = F, row.names = 1)

# Create the first percentage bar chart
p1_data <- data.frame(
  category = "Hydrocycle\nproportion",
  status = c("Yes", "No"),
  percentage = c(5.070298, 100-5.070298)
)
pic_line_width = 0.2
p1 <- ggplot(p1_data, aes(x = category, y = percentage, fill = status)) +
  geom_col(position = "stack", width = 0.8, linewidth = pic_line_width, color = "black") +
  geom_text(aes(label = ifelse(status == "Yes", paste0(round(percentage, 2), "%"), "")),
            position = position_stack(vjust = 0.5), 
            size = 4, fontface = "bold", color = "white") +
  # scale_fill_manual(values = c("Yes" = "#4E79A7", "No" = "#E0E0E0")) +
  geom_col_pattern(
    position = position_stack(reverse = FALSE),
    pattern = c("stripe", "crosshatch"),
    pattern_angle = c(30, 45),
    pattern_density = 0.1,
    pattern_spacing = 0.13,
    pattern_color = "white",
    pattern_alpha = 0.3,
    # pattern_size = 0.1,
    pattern_size = 0.1,
    pattern_fill = "white",
    colour = "black",  # Bar outline color
    width = 0.85
  ) +
  scale_fill_manual(
    values = c("#08807f", "#000d7c"),
    # labels = c("Other AMR studies", "AMR studies in hydrology")
  ) +
  labs(x = "", y = "Percentage (%)") +
  theme_few() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"),
    axis.text.x = element_text(size = 10, face = "bold"),
    axis.title.y = element_text(size = 10),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    legend.position = "none"
  ) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20)) 

# Create the second percentage bar chart
p2_data <- data.frame(
  category = "Hydro-only",
  status = c("Yes", "No"),
  percentage = c(58.51528, 100-58.51528)
)

p2 <- ggplot(p2_data, aes(x = category, y = percentage, fill = status)) +
  geom_col(position = "stack", width = 0.8, linewidth = pic_line_width, color = "black") +
  geom_text(aes(label = ifelse(status == "Yes", paste0(round(percentage, 2), "%"), "")),
            position = position_stack(vjust = 0.5), 
            size = 4, fontface = "bold", color = "white") +
  # geom_col_pattern(
  #   position = position_stack(reverse = FALSE),
  #   pattern = c("crosshatch", "stripe"),
  #   pattern_angle = c(30, 45),
  #   pattern_density = 0.1,
  #   pattern_spacing = 0.13,
  #   pattern_color = "white",
  #   pattern_alpha = 0.3,
  #   # pattern_size = 0.1,
  #   pattern_size = 0.1,
  #   pattern_fill = "white",
  #   colour = "black",  # Bar outline color
  #   width = 0.85
  # ) +
  scale_fill_manual(
    values = c("grey90", "#898989"),
    # labels = c("Other AMR studies", "AMR studies in hydrology")
  ) +
  # scale_fill_manual(values = c("Yes" = "#F28E2B", "No" = "#E0E0E0")) +
  labs(x = "", y = "Percentage (%)") +
  theme_few() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 12, face = "bold"),
    axis.text.x = element_text(size = 10, face = "bold"),
    axis.title.y = element_text(size = 10),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    legend.position = "none"
  ) +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20))

# Create the short bar chart for p3 (total values)
p3_top <- ggplot(total1, aes(x = name, y = Total)) +
  geom_col(fill = "#bebebe", width = 0.6, alpha = 1, color = "black", linewidth = pic_line_width) +
  geom_text(aes(label = sprintf("%.0f", Total)), 
            vjust = -0.5, size = 3) +
  labs(x = NULL, y = "Total (M USD)") +
  theme_few() +
  theme(
    legend.position = "none",
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 9),
    axis.text.y = element_text(size = 8),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    plot.margin = margin(b = 0, t = 5, unit = "pt")
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

# Create the stacked percentage bar chart for p3
p3_bottom <- ggplot(plot_data_pct1, aes(x = name, y = Percentage, fill = `Research Area`)) +
  geom_col(position = "fill", width = 0.8, linewidth = pic_line_width, color = "black") +
  labs(
    x = NULL,
    y = "Percentage (%)",
    fill = "Research Area"
  ) +
  theme_few() +
  theme(
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
    axis.title.y = element_text(size = 9),
    axis.text.y = element_text(size = 8),
    legend.position = "none",
    legend.title = element_text(size = 9),
    legend.text = element_text(size = 8),
    legend.key.size = unit(0.4, "cm"),
    plot.margin = margin(t = 0, unit = "pt")
  ) +
  scale_fill_manual(values = color_palette) +
  scale_y_continuous(labels = scales::percent_format(scale = 100)) +
  guides(fill = guide_legend(nrow = 3, byrow = TRUE))

# Create the short bar chart for p4 (total values)
p4_top <- ggplot(total2, aes(x = name, y = Total)) +
  geom_col(fill = "#bebebe", width = 0.6, alpha = 1, color = "black", linewidth = pic_line_width) +
  geom_text(aes(label = sprintf("%.0f", Total)), 
            vjust = -0.5, size = 3) +
  labs(x = NULL, y = "Total (M USD)") +
  theme_few() +
  theme(
    legend.position = "none",
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 9),
    axis.text.y = element_text(size = 8),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    plot.margin = margin(b = 0, t = 5, unit = "pt")
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

# Create the stacked percentage bar chart for p4
p4_bottom <- ggplot(plot_data_pct2, aes(x = name, y = Percentage, fill = `Research Area`)) +
  geom_col(position = "fill", width = 0.8, linewidth = pic_line_width, color = "black") +
  labs(
    x = NULL,
    y = "Percentage (%)",
    fill = "Research Area"
  ) +
  theme_few() +
  theme(
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
    axis.title.y = element_text(size = 9),
    axis.text.y = element_text(size = 8),
    legend.position = "bottom",
    plot.margin = margin(t = 0, unit = "pt")
  ) +
  scale_fill_manual(values = color_palette) +
  scale_y_continuous(labels = scales::percent_format(scale = 100))

# Create two empty placeholder plots above p1 and p2
empty1 <- ggplot() + 
  theme_void() +
  theme(plot.margin = margin(0, 0, 0, 0))

empty2 <- ggplot() + 
  theme_void() +
  theme(plot.margin = margin(0, 0, 0, 0))

# Create a 2-row by 4-column layout
combined_plot <- empty1 + empty2 + p3_top + p4_top +
  p1 + p2 + p3_bottom + p4_bottom +
  plot_layout(
    nrow = 2,
    heights = c(0.15, 1),  # First row for short bar charts, second row for the main panels
    widths = c(1, 1, 3, 4),  # Width ratios for the four columns
    guides = "collect"
  ) & theme(legend.position = "bottom")

ggsave(plot = combined_plot, 
       filename = "./Figures/Fig5abc.pdf",
       family = "ArialMT", width = 7)
