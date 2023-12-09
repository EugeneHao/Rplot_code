library(ggsurvfit)
mymodel <- survfit2(Surv(time, status) ~ surg, data = df_colon)

ggsurvfit(mymodel) +
  add_confidence_interval() + # 添加置信区间
  scale_color_manual(values = c('#54738E', '#82AC7C')) + # 修改颜色
  scale_fill_manual(values = c('#54738E', '#82AC7C')) + # 修改颜色
  add_risktable() + # 添加风险表格
  theme_minimal() +
  theme(legend.position = "bottom")
