library(tidyverse)
library(ggrepel)
library(cowplot)

scores_df <- read.delim("mageck_analysis/MageckLibISG_CoVclust.gene_summary.txt", header = TRUE, as.is = TRUE)

#### user input
FDR_cutoff <- 0.05
user_selected_pos_genes <- c("APOL6", "DAXX", "HERC5")
user_selected_neg_genes <- c()
####

print(scores_df[which(scores_df$id %in% user_selected_pos_genes),] %>% select(id, pos.score, pos.p.value, pos.fdr))

scores_df$custom_pos_color <- "high_fdr"
scores_df[which(scores_df$pos.fdr < FDR_cutoff), ]$custom_pos_color <- "low_fdr"
scores_df[which(scores_df$id %in% user_selected_pos_genes),]$custom_pos_color <- "user_selected"


scores_df$custom_neg_color <- "high_fdr"
scores_df[which(scores_df$neg.fdr < FDR_cutoff), ]$custom_neg_color <- "low_fdr"
scores_df[which(scores_df$id %in% user_selected_neg_genes),]$custom_neg_color <- "user_selected"




# Putative antiviral- positive score.
p1 <- ggplot()
p1 <- p1 + geom_point(data = scores_df, aes(x = id, y =-log10(pos.score), color=custom_pos_color), 
                      size = 2)
p1 <- p1 + geom_text_repel(data = scores_df[which(scores_df$pos.fdr < FDR_cutoff | scores_df$id %in% user_selected_pos_genes),], 
                           aes(x = id, y =-log10(pos.score), label = id, 
                               color=custom_pos_color),
                           box.padding   = 0.5, 
                           point.padding = 0.1,
                           segment.color = "grey50",
                           segment.size = 0.5)
p1 <- p1 + scale_y_continuous(limits = c(0, 14), breaks = c(2, 4, 6, 8, 10, 12, 14))
p1 <- p1 + scale_color_manual(values = c("high_fdr"="grey80", "low_fdr" = "grey30", "user_selected" = "firebrick3"))
p1 <- p1 + theme_classic(base_size = 11)
p1 <- p1 + theme(axis.title.x = element_blank(),
                 axis.ticks.x = element_blank(),
                 axis.text.x = element_blank(),
                 axis.line.x = element_blank())
p1 <- p1 + theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))

#print(p1)



# Putative proviral - negative score.
p2 <- ggplot()
p2 <- p2 + geom_point(data = scores_df, aes(x = id, y =-log10(neg.score), color=custom_neg_color), 
                      size = 2)
p2 <- p2 + geom_text_repel(data = scores_df[which(scores_df$neg.fdr < FDR_cutoff | scores_df$id %in% user_selected_neg_genes),], 
                           aes(x = id, y =-log10(neg.score), label = id, color = custom_neg_color),
                           box.padding   = 0.5, 
                           point.padding = 0.1,
                           segment.color = "grey50",
                           segment.size = 0.5)
p2 <- p2 + scale_y_reverse(limits = c(14, 0), breaks = c(2, 4, 6, 8, 10, 12, 14))
p2 <- p2 + scale_color_manual(values = c("high_fdr"="grey80", "low_fdr" = "grey30", "user_selected" = "firebrick3"))
p2 <- p2 + theme_classic(base_size = 11)
p2 <- p2 + theme(axis.title.x = element_blank(),
                 axis.ticks.x = element_blank(),
                 axis.text.x = element_blank(),
                 axis.line.x = element_blank())
p2 <- p2 + theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))

#print(p2)


p12 <- plot_grid(p1, p2, nrow = 2, ncol = 1)

print(p12)

ggsave(plot = p12, filename = "mageck_score_plot.eps", device = "eps", width = 15, height = 10, units = "cm") ###### EPS format
ggsave(plot = p12, filename = "mageck_score_plot.pdf", device = "pdf", width = 15, height = 10, units = "cm") ###### PDF format
ggsave(plot = p12, filename = "mageck_score_plot.png", device = "png", width = 15, height = 10, units = "cm") ###### PNG format
