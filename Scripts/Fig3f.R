pkgs <- c("ComplexHeatmap", "dplyr")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    if (p == "ComplexHeatmap") {
      if (!requireNamespace("BiocManager", quietly = TRUE)) {
        install.packages("BiocManager")
      }
      BiocManager::install(p, ask = FALSE, update = FALSE)
    } else {
      install.packages(p)
    }
  }
  library(p, character.only = TRUE)
}

mk_df <- read.csv("./Data/Fig3f.csv", check.names = F, row.names = 1)

# Create a color-mapping function
col_fun = function(x) {
  ifelse(x == "*", "darkred", 
         ifelse(x == "△", "darkblue", "white"))
}

# Create the color matrix
color_matrix = matrix(col_fun(mk_df), nrow = nrow(mk_df))

# Define column groups
column_groups = c("A", "B", "B", "B", "B", "C", "C", "C", "C", "C", "C", "C")
names(column_groups) = colnames(mk_df)

# Set column annotations for displaying groups
column_ha = HeatmapAnnotation(
  Group = c("total", "Income", "Income", "Income", "Income", 
            "Region", "Region", "Region", "Region", "Region", "Region", "Region"),
  col = list(Group = c("total" = "grey", "Income" = "lightblue", "Region" = "lightgreen")),
  show_legend = FALSE,
  annotation_name_side = "left"
)

pdf("./Figures/Fig3f.pdf")
# Define column splits for the three groups
column_split = factor(c("total", "Income", "Income", "Income", "Income", 
                        "Region", "Region", "Region", "Region", "Region", "Region", "Region"),
                      levels = c("total", "Income", "Region"))

# Draw the heatmap
ht = Heatmap(color_matrix,
             name = " ",
             col = structure(c("darkred", "darkblue", "white"), 
                             names = c("darkred", "darkblue", "white")),
             rect_gp = gpar(col = NA),  # Remove cell borders
             cluster_rows = FALSE,
             cluster_columns = FALSE,
             show_heatmap_legend = FALSE,
             
             # Configure row and column labels
             row_names_side = "left",
             row_names_gp = gpar(fontsize = 10),
             column_names_side = "top", 
             column_names_gp = gpar(fontsize = 10),
             column_names_rot = 45,  # Rotate column names by 45 degrees to avoid overlap
             
             # Set cell dimensions
             width = unit(12, "cm"),
             height = unit(15, "cm"),
             
             # Apply column grouping
             column_split = column_split,
             column_title = NULL,
             column_gap = unit(2, "mm"),  # Gap between groups
             
             # Set group borders
             border = TRUE,
             border_gp = gpar(col = "black", lwd = 2),
             
             # Render each cell
             cell_fun = function(j, i, x, y, width, height, fill) {
               grid.rect(x = x, y = y, width = width, height = height, 
                         gp = gpar(fill = fill, col = NA))
             })

# Draw the heatmap
draw(ht)

# Add the legend inside the heatmap
legend_x = unit(0.02, "npc")
legend_y = unit(0.95, "npc")

grid.rect(x = legend_x, y = legend_y, 
          width = unit(2, "cm"), height = unit(1.5, "cm"),
          gp = gpar(fill = "white", col = "black", alpha = 0.8))

grid.text("Legend", x = legend_x, y = legend_y - unit(0.3, "cm"),
          just = "left", gp = gpar(fontsize = 9, fontface = "bold"))

# Red square and label
grid.rect(x = legend_x + unit(0.2, "cm"), y = legend_y - unit(0.6, "cm"),
          width = unit(0.3, "cm"), height = unit(0.3, "cm"),
          gp = gpar(fill = "darkred", col = NA))
grid.text("*", x = legend_x + unit(0.35, "cm"), y = legend_y - unit(0.6, "cm"),
          gp = gpar(fontsize = 8))

# Blue square and label
grid.rect(x = legend_x + unit(0.2, "cm"), y = legend_y - unit(0.9, "cm"),
          width = unit(0.3, "cm"), height = unit(0.3, "cm"),
          gp = gpar(fill = "darkblue", col = NA))
grid.text("△", x = legend_x + unit(0.35, "cm"), y = legend_y - unit(0.9, "cm"),
          gp = gpar(fontsize = 8))

# Add group labels
# total group label
grid.text("total", x = unit(0.04, "npc"), y = unit(0.98, "npc"),
          gp = gpar(fontsize = 10, fontface = "bold"))

# Income group label
grid.text("Income", x = unit(0.18, "npc"), y = unit(0.98, "npc"),
          gp = gpar(fontsize = 10, fontface = "bold"))

# Region group label
grid.text("Region", x = unit(0.55, "npc"), y = unit(0.98, "npc"),
          gp = gpar(fontsize = 10, fontface = "bold"))
dev.off()
