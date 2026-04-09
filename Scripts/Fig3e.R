pkgs <- c("ComplexHeatmap", "viridis", "dplyr", "extrafont")
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

term_year <- read.csv("./Data/Fig3e.csv", row.names = 1, check.names = F)

my_palette <- colorRampPalette(c("blue", "white", "red"))(100)
note <- matrix("", nrow = nrow(term_year), ncol = 35)
note[term_year > 10] <- sprintf("%.0f", term_year[term_year > 10])

p0 <- ComplexHeatmap::pheatmap(data.matrix(term_year),
                               scale = "none",
                               cluster_cols = F,
                               cluster_rows = F,
                               fontsize_col = 8,
                               fontsize_row = 9,
                               angle_col = c("0"),
                               row_names_side = "left",
                               column_names_side = "top",
                               cellwidth = 17,
                               cellheight = 15,
                               legend = F,
                               # color = viridis::rainbow(n=21),
                               color = turbo(n=21, begin = 0.05, end = 0.86),
                               breaks = seq(0, 100, length.out = 21),
                               display_numbers = F,
                               number_format = "%.0f",
                               border_color = NA,
                               legend_breaks = c(0, 50, 100),
                               # fontsize_number = 7*0.9,
                               name = "Frequency",
                               cell_fun = function(j, i, x, y, width, height, fill) {
                                 if (term_year[i, j] >= 10)
                                   grid.text(sprintf("%.0f", term_year[i, j]), x, y, gp = gpar(fontsize = 9*0.9))
                               },
                               # fontfamily = "Times"
                               # row_names_gp = gpar(face = "bold")
)
p1 <-
  p0 + rowAnnotation(Trend = anno_horizon(term_year %>% t,
                                          normalize = T,
                                          width = unit(12, "mm"),
                                          axis = F),
                     show_annotation_name = T,
                     annotation_name_rot = 0,
                     annotation_name_gp = gpar(fontsize = 10),
                     annotation_name_side = "top"
  ) +
  rowAnnotation(Occurrence = anno_barplot(term_year %>% rowSums,
                                          axis_param = list(gp = gpar(fontsize = 9),
                                                            side = "top")),
                annotation_name_gp = gpar(fontsize = 9),
                annotation_name_side = "top",
                show_annotation_name = F,
                annotation_name_rot = 0)
pdf("./Figures/Fig3e.pdf", family = "Times", height = 8, width = 11)
p1
dev.off()
