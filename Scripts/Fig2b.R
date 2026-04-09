pkgs <- c("ggplot2", "scatterpie", "dplyr", "ggrepel")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

stats_comb <- read.csv("./Data/Fig2b.csv", row.names = 1)

# Draw the scatter plot
ggplot(stats_comb, aes(x = hydro_pop_m, y = Total_hydro)) +
  geom_point(size = 3, color = "blue") +
  geom_text_repel(aes(label = Name), 
                  size = 3.5,
                  box.padding = 0.5,
                  point.padding = 0.2,
                  max.overlaps = Inf) +
  labs(x = "Number of studies per population million",
       y = "Number of studies") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("./Figures/Fig2b.pdf", family = "ArialMT")
