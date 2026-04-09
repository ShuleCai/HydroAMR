pkgs <- c("dplyr", "ggplot2")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

world_s <- readRDS("./Data/Fig1c.rds")
world_s$color <- cut(world_s$Hydro_prop, 
                     breaks = c(-Inf, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, Inf),
                     labels = c("<1%", "1-2%", "2-3%", "3-4%", "4-5%", "5-6%",
                                "6-7%", "7-8%", "8-9%", "9-10%", ">10%"))

## Map of the proportion of hydrocycle-related publications
ggplot(data = world_s) + 
  geom_sf(aes(fill = color)) +
  scale_fill_manual(name = "Proportion",
                    values = c("#534da0", "#2e7db3", "#5aba9c", "#94ce9c", "#d4e28d",
                               "#fdd680", "#f7a05f", "#f06a45", "#d2414c", "#901644", "#68012a")) +
  coord_sf(y = c(-50, 90), expand = T) +
  theme_void() +
  labs(title = "Proportion of hydrocycle-related AMR publications")+
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(hjust = 0.5),
        legend.position = "bottom")
ggsave("./Figures/Fig1c.pdf", family = "ArialMT")
