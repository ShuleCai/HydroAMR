pkgs <- c("tidyr", "dplyr", "ggplot2", "ggpattern", "ggthemes")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

df_norm <- read.csv("Data/Fig1b.csv", row.names = 1, check.names = F)
# Convert the data to long format for easier use with ggplot2
df_norm_long <- df_norm %>%
  tibble::rownames_to_column("Category") %>%
  pivot_longer(cols = -Category, names_to = "Year", values_to = "Value") %>%
  mutate(Year = as.numeric(Year))  # Convert the year column to numeric

# Create the plot
ggplot(df_norm_long, aes(x = Year, y = Value, color = Category, linetype = Category)) +
  geom_line(size = 0.5) +
  # Set line types: solid for Total and dashed styles for the others
  scale_linetype_manual(values =  c("df_year_hydro" = "dashed", "df_year_total" = "solid", "df_year_other" = "twodash")) +
  # Set colors: black for Total and custom colors for the others
  scale_color_manual(values = c("df_year_hydro" = "#000d7c", "df_year_total" = "black", "df_year_other" = "#08807f")) +
  labs(title = NULL,
       x = "Year",
       y = "Number of studies",
       color = "Category") +
  theme_base() +
  theme(plot.title = element_text(hjust = 0.5),  # Center the title
        legend.position = "bottom")  # Place the legend at the bottom
ggsave("./Figures/Fig1b.pdf", family = "ArialMT")                     
