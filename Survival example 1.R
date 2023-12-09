library(survival) 
library(survminer)

surv_model <- survfit(Surv(time, status) ~ sex, data = lung)
p1 <- ggsurvplot(surv_model, data = lung,
           conf.int = TRUE, # 添加置信区间
           pval = TRUE, # 添加p值 (can customize pval)
           fun = "pct", # 将y轴转变为百分比的格式
           size = 1, # 修饰线条的粗细
           linetype = "strata", # 改变两条线条的类型
           palette = c("lightseagreen", "goldenrod1"), # 改变两条曲线的颜色
           legend = c(0.8, 0.85), # 改变legend的位置
           legend.title = "Gender", # 改变legend的题目
           legend.labs = c("Male", "Female"), # 改变legend的标签
           risk.table = TRUE,    # add risk table
           tables.height = 0.2,
           tables.theme = theme_cleantable(),
           surv.median.line = "hv", 
           ggtheme = theme_bw())

p1$plot <- p1$plot + annotate("text", x = 750, y = 70, # 注明x和y轴的位置
           label = "Chisq = 10.3 on 1 degrees of freedom") # 添加文本信息
p1
