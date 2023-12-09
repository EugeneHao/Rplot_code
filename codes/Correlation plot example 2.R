library(ggcorrplot)
library(patchwork)

mydata <- ggplot2::diamonds[, c(1, 5:10)]
my_corr <- cor(mydata)

ggcorrplot(my_corr, 
           method = "square", 
           type = "lower", 
           ggtheme = theme_minimal(),
           show.legend = TRUE, 
           legend.title = "Correlation coefficients", 
           show.diag = TRUE, # 是否显示对角线相关系数
           colors = c("darkblue", "white", "#C44E52"), # 相关系数中低高所对应颜色
           outline.color = "grey50",
           hc.order = FALSE, 
           lab = T, # 是显示相关系数
           lab_col = "black", # 相关系数的颜色
           lab_size = 4,# 系数大小
           tl.cex = 12, # 修饰变量名
           tl.srt = 30, # 变量名旋转角度
           digits = 3, # 小数点展示几位
           title = "Correlation Matrix of Diomonds Dataset") + 
  theme(legend.position = c(0.3, 0.75), 
        panel.grid = element_blank())
