pkgs <- c("dplyr", "ggplot2")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

world_s_pop <- readRDS("./Data/Fig1d.rds")
world_s_pop$color <- cut(world_s_pop$hydro_pop_m, breaks = c(-Inf, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, Inf),
                         labels = c("<1", "1-2", "2-3", "3-4", "4-5", "5-6", "6-7", "7-8", "8-9", "9-10", ">10"))

ggplot(data = world_s_pop) + 
  geom_sf(aes(fill = color)) +
  scale_fill_manual(name = "Number of publication\n / Populaion millions",
                    values = c("#534da0", "#2e7db3", "#5aba9c", "#94ce9c", "#d4e28d",
                               "#fdd680", "#f7a05f", "#f06a45", "#d2414c", "#901644", "#68012a")) +
  coord_sf(y = c(-50, 90), expand = T) +
  theme_void() +
  labs(title = "Number of Hydrocycle-related AMR publication / Population millions")+
  theme(panel.grid.major = element_blank(),
        plot.title = element_text(hjust = 0.5),
        legend.position = "bottom")
ggsave("./Figures/Fig1d.pdf", family = "ArialMT")
