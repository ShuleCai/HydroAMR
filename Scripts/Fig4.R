pkgs <- c("dplyr", "ggplot2", "stringr")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
  library(p, character.only = TRUE)
}

df_topics_c_m <- read.csv("./Data/Fig4_total.csv")

plot_data <- df_topics_c_m %>%
  select(individual = CustomName, group = Topic.category, value = Count) %>%
  mutate(value = log10(value))
datagroup <- plot_data$group %>% unique()
datagroup <- c("Antimicrobial agent", "AMR control & removal", "Aquaculture health & disease control", "AMR surveillance")


allplotdata <- tibble(
  "group" = rep(datagroup, 2),
  "individual" = paste0("empty_individual_", 1:8),
  "value" = 0
) %>%
  bind_rows(plot_data) %>%
  arrange(desc(group), desc(value)) %>%
  mutate(xid = 1:n()) %>%
  mutate(angle = 90 - 360 * (xid - 0.5) / n()) %>%
  mutate(hjust = ifelse(angle < -90, 1, 0)) %>%
  mutate(angle = ifelse(angle < -90, angle + 180, angle))

# Extract placeholder entries and make layout adjustments
firstxid <- which(str_detect(allplotdata$individual, pattern = "empty_individual"))

segment_data <- data.frame(
  "from" = firstxid + 1,
  "to" = c(c(firstxid - 1)[-1], nrow(allplotdata)),
  "label" = datagroup
) %>%
  mutate(labelx = as.integer((from + to) / 2))

# Define a custom axis
coordy <- tibble(
  "coordylocation" = seq(from = min(allplotdata$value), to = max(allplotdata$value), 1),
  "coordytext" = as.character(round(coordylocation, 2)),
  "x" = 1
)

# Build a custom grid for the axis
griddata <- expand.grid("locationx" = firstxid[-1], "locationy" = coordy$coordylocation)

# Draw the plot
ggplot() +
  geom_bar(data = allplotdata, aes(x = xid, y = value, fill = group), stat = "identity") +
  geom_text(
    data = allplotdata %>% filter(!str_detect(individual, pattern = "empty_individual")),
    aes(x = xid, label = individual, y = value + 0.1, angle = angle, hjust = hjust),
    color = "black", alpha = 1, size = 2.5
  ) +
  geom_segment(
    data = griddata,
    aes(x = locationx - 0.5, xend = locationx + 0.5, y = locationy, yend = locationy),
    colour = "grey", alpha = 0.8, size = 0.6
  ) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(limits = c(-1, 3.5)) +
  coord_polar() +
  theme_void() +
  theme(legend.position = "none")


# Save the figure
ggsave("./Figures/Fig4a.pdf", family = "ArialMT")

plot_data <- read.csv("./Data/Fig4_country.csv", row.names = 1, check.names = F)
plot_data <- plot_data %>% mutate(topic_category = factor(topic_category, levels = c(
  "AMR_surveillance", "AMR_control_removal",
  "aquaculture_health", "antmicrobial_agent"
) %>% rev()))
ggplot(plot_data, aes(x = country, y = topic_category)) +
  geom_point(aes(size = value, color = proportion)) +
  theme_bw() +
  scale_color_gradient(low = "lightgrey", high = "red") +
  labs(x = "", y = "") +
  scale_size_continuous(
    trans = "sqrt",
    range = c(2, 5)
  ) +
  scale_x_discrete(position = "top") +
  theme(
    panel.grid = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 0, vjust = 0.5)
  )
ggsave("./Figures/Fig4d.pdf",
  family = "ArialMT",
  height = 2.5,
  width = 10
)
