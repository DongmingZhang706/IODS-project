library('readxl')
library('gplots')
library('pheatmap')

Aniger <- read_xlsx("//ad.helsinki.fi/home/z/zhangdon/Desktop/Visualization/data_visualization/data2.xlsx", col_names = TRUE)

Aniger

x<-subset(Aniger, select = c("Glucose", "Galactose", "Rhamnose", "Xylose", "Arabinose"))

x

y<-as.data.frame(x, row.names = Aniger$ID)
y
z <- data.matrix(y[1:5], rownames = Aniger$ID)
rownames(z) <- Aniger$ID
z
scale(z)

col <- colorRampPalette(c("red","white","blue"))(50)
heatmap.2(z, Rowv = T, Colv = FALSE, dendrogram = "row", col = col, trace = "none", cexCol = 1.2, key = TRUE, symm=FALSE)


heatmap.2(z, Rowv = T, Colv = FALSE, dendrogram = "row", scale = "col", col = col, trace = "none", cexCol = 1.2, key = TRUE, symm=FALSE)

pheatmap(z, scale = 'column', cluster_rows = TRUE, cluster_cols = FALSE, fontsize = 8, cellheight = 8, filename = 'test.jpg')

pheatmap(scale(z), cluster_rows = TRUE, cluster_cols = FALSE, fontsize = 8, cellheight = 8, filename = 'test1.jpg')
