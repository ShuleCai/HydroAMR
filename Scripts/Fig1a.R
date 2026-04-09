pkgs <- c("tidyr", "dplyr", "ggplot2", "ggpattern", "ggthemes")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

df_year_comb <- read.csv("./Data/Fig1a.csv", row.names = 1, check.names = F)
df_long <- df_year_comb[-2,] %>% as.data.frame %>% 
  tibble::rownames_to_column("type") %>%
  pivot_longer(cols = -type, names_to = "year", values_to = "value") %>%
  mutate(
    year = as.numeric(year),
    type = factor(type, levels = c("df_year_other", "df_year_hydro"))
  )

p <- ggplot(df_long, aes(x = factor(year), y = value, fill = type)) +
  geom_col_pattern(
    position = position_stack(reverse = FALSE),
    pattern = c("crosshatch", "stripe")[as.numeric(df_long$type)],
    pattern_angle = c(30, 45)[as.numeric(df_long$type)],
    pattern_density = 0.1,
    pattern_spacing = 0.02,
    pattern_color = "white",
    pattern_alpha = 0.3,
    pattern_size = 0.1,
    pattern_fill = "white",
    colour = "black",  # Bar outline color
    width = 0.85
  ) +
  scale_fill_manual(
    values = c("#08807f", "#000d7c"),
    labels = c("Other AMR studies", "AMR studies in hydrology")
  ) +
  labs(x = "Year", y = "Number of studies", fill = NULL) +
  theme_base() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    legend.position = "bottom"
  ) +
  guides(fill = guide_legend(reverse = TRUE)) +
  scale_y_continuous(labels = scales::comma)
ggsave(p, filename = "./Figures/Fig1a.pdf",
       family = "ArialMT")
